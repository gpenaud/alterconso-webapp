#!/usr/bin/python3.9
# import argparse, os, glob, yaml, sys, subprocess, shutil

import argparse
import csv
import mysql.connector
import os
import requests
import shutil
import sys
import time

parser = argparse.ArgumentParser()

parser.add_argument(
  "--producer",
  "-p",
  type=str,
  help="determine the producer"
)
parser.add_argument(
  "--type",
  "-t",
  type=str,
  help="type of product"
)

args = parser.parse_args()

csv_file   = "./exported-products/" + args.producer + "/" + args.type + "/products.csv"
image_path = "./exported-products/" + args.producer + "/" + args.type + "/images"

unit_type = {
  'Piece'   : 0,
  'Kilogram': 1,
  'Gram' : 2,
  'Litre': 3,
  'Centilitre': 4,
  'Millilitre': 5
}

def cast_stringy_boolean(bool):
  if bool == 'true':
    return 0
  elif bool == 'false':
    return 1

def get_unit_type(unit):
  return unit_type[unit]

def convertToBinaryData(filename):
    # Convert digital data to binary format
    with open(filename, 'rb') as file:
        binaryData = file.read()
    return binaryData

def get_catalog_id_from_producer(cursor, producer):
  query="""SELECT id FROM Catalog WHERE LOWER(name) REGEXP '.*{producer}.*';""".format(producer = producer)
  cursor.execute(query)
  return cursor.fetchall()[0][0]

def get_default_txp_product(cursor):
  query="""SELECT id FROM TxpProduct WHERE name = 'Divers'"""
  cursor.execute(query)

  try:
    return cursor.fetchall()[0][0]
  except IndexError:
    return None

def create_default_taxonomy(cursor):
  query="""INSERT IGNORE INTO TxpCategory (image, displayOrder, name) VALUES (%s, 0, %s)"""
  cursor.execute(query, ("autres", "Divers"))
  default_txp_category = cursor.lastrowid

  query="""INSERT INTO TxpSubCategory (name, categoryId) VALUES (%s, %s)"""
  cursor.execute(query, ("Divers", default_txp_category))
  default_txp_subcategory = cursor.lastrowid

  query="""INSERT INTO TxpProduct (name, categoryId, subCategoryId) VALUES (%s, %s, %s)"""
  cursor.execute(query, ("Divers", default_txp_category, default_txp_subcategory))
  default_txp_product = cursor.lastrowid

  return default_txp_product

# ---------------------------------------------------------------------------- #

def get_image_id_from_db(cursor, filename):
  query="""SELECT id FROM File WHERE name = '{filename}';""".format(filename = filename)
  cursor.execute(query)

  try:
    return cursor.fetchall()[0][0]
  except IndexError:
    return False

def insert_image_in_db(cursor, filename, image):
  image = convertToBinaryData(image)
  print(image)
  query="""INSERT INTO File (name, cdate, data) VALUES (%s, NOW(), %s)"""
  cursor.execute(query, (filename, image))
  database.commit()
  return cursor.lastrowid

def insert_product_in_db(cursor, product, catalog_id, image_id, txp_product_id):

  query = (
    """
    INSERT INTO Product
      (`name`,`ref`,`price`,`vat`,`desc`,`stock`,`unitType`,`qt`,`organic`,`variablePrice`,`multiWeight`,`wholesale`,`retail`,`bulk`,`hasFloatQt`,`active`,`catalogId`,`imageId`,`txpProductId`)
    VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s );
    """
  )

  name = row[1], # 'Epinard'
  ref = row[2], # '000-001'
  price = float(row[3]),
  vat = float(row[4]),
  desc = '',
  stock = float(10),
  unit_type = get_unit_type(row[7]),
  qt = int(row[8]),
  organic = float(1),
  variable_price = 0,
  multi_weight = 0,
  wholesale = 0,
  retail = 0,
  bulk = 0,
  has_float_qt = 0,
  active = cast_stringy_boolean(row[9]),

  try:
    cursor.execute(query, (name, ref, price, vat, desc, unit_type, qt, organic, variable_price, multi_weight, wholesale, retail, bulk, has_float_qt, active, catalog_id, image_id, txp_product_id))
  except mysql.connector.Error as err:
    print(err)
    print(cursor.statement)

  database.commit()
  return cursor.lastrowid


database = mysql.connector.connect(
  host ="localhost",
  user ="docker",
  passwd ="docker",
  database="db",
  charset="utf8mb4",
  collation="utf8mb4_unicode_ci",
  use_unicode=True
)

# preparing a cursor object
cursor = database.cursor()

catalog_id = get_catalog_id_from_producer(cursor, args.producer)
default_txp_product = get_default_txp_product(cursor)
if (default_txp_product is None):
  default_txp_product = create_default_taxonomy(cursor)

database.commit()

with open(csv_file, newline='') as f:
  reader = csv.reader(f)
  try:
    for row in reader:
      if row[0] == "id":
        continue

      image_name = row[1].replace(' ', '_').replace('/','_').lower()
      image_url = row[10]
      image_path = os.path.abspath(image_path + "/" + filename + ".png")
      image_id = get_image_id_from_db(cursor, filename)

      if not image_id:
        res = requests.get(image_url, stream = True)
        if res.status_code == 200:
          with open(image_path,'wb') as f:
            shutil.copyfileobj(res.raw, f)
            image_id = insert_image_in_db(cursor, image_name, image_path)
        else:
          print('Image couldn\'t be inserted')

      insert_product_in_db(cursor, row, catalog_id, image_id, default_txp_product)

  except csv.Error as e:
    sys.exit('file {}, line {}: {}'.format(image_name, reader.line_num, e))

# Disconnecting from the server
cursor.close()
database.close()
