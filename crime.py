import csv
import json
import sys
import os

if len(sys.argv) != 2:
    print("Usage: census.py <dataset>\n (where dataset can be found in input-datasets)")
    exit(1)
NAME = sys.argv[1]

filename = 'input-datasets/%s.csv' % NAME
fh = open(filename, 'r')
csv_reader = csv.DictReader(fh)

output = 'processed-datasets/%s' % NAME
os.makedirs(output, exist_ok=True)
os.chdir(output)

for line in csv_reader:
    name=line["Area_unit_2013_code"]
    if len(name) == 0:
        print("Missing Area Unit!")
        continue
    o_fh = open(name, 'w')
    json.dump(line, o_fh)
    o_fh.close()

fh.close()
