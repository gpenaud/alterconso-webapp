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
  "--delimiter",
  type=str,
  default=",",
  help="csv delimiter"
)
parser.add_argument(
  "--group",
  "-g",
  required=True,
  type=str,
  help="determine the group"
)


args = parser.parse_args()
debug = args.debug
logging.basicConfig(level=logging.INFO, format='%(asctime)s | %(levelname)s | %(message)s')

directory_path = os.path.dirname(os.path.abspath(__file__))
csv_file       = "%s/data/%s/users.csv" % (directory_path, args.group)

try:
  with open(csv_file, newline='') as f:
    reader = csv.reader(f, delimiter=args.delimiter)
    for row in reader:
      if row[2] == "Nom":
        continue

      response = requests.post('http://127.0.0.1:5000/user', json = {
        "group_name": args.group,
        "user": row,
      })

      if response.status_code == 201:
        logging.info(response.json())
      else:
        logging.warning(response.json())

except (csv.Error) as err:
  sys.exit("Error during csv processing: %s" % err)
