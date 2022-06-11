#!/usr/bin/python3.9

import argparse
import csv
import json
import logging
import os
import requests
import sys

from importlib import reload

sys.path.append(".")

parser = argparse.ArgumentParser()

parser.add_argument(
  "--debug",
  "-d",
  action="store_true",
  help="enable mode debug"
)
parser.add_argument(
  "--extract",
  "-x",
  action="store_true",
  help="extract name from csv file"
)
parser.add_argument(
  "--group",
  "-g",
  type=str,
  required=True,
  help="determine the group"
)
parser.add_argument(
  "--producer",
  "-p",
  type=str,
  required=True,
  help="determine the producer"
)
parser.add_argument(
  "--catalog",
  "-c",
  type=str,
  default="all",
  help="determine the catalog"
)
parser.add_argument(
  "--delimiter",
  type=str,
  default=",",
  help="csv delimiter"
)

args = parser.parse_args()
debug = args.debug
logging.basicConfig(level=logging.INFO, format='%(asctime)s | %(levelname)s | %(message)s')

directory_path = os.path.dirname(os.path.abspath(__file__))
csv_file       = "%s/data/%s/catalogs/%s/%s.csv" % (directory_path, args.group, args.producer, args.catalog)

try:
  with open(csv_file, newline='') as f:
    reader = csv.reader(f, delimiter=args.delimiter)
    for row in reader:
      if row[0] == "id":
        continue

      response = requests.post('http://127.0.0.1:5000/product', json = {
        "producer": args.producer,
        "product": row,
      })

      if response.status_code == 201:
        logging.info(response.json())
      else:
        logging.warning(response.json())

except (csv.Error) as err:
  sys.exit("Error during csv processing: %s" % err)
