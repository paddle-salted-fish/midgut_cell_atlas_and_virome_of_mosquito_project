#! /public21/home/sc90258/miniconda3/bin/python
# -*- coding: utf-8 -*-

import sys, re
from pathlib import Path

if len(sys.argv) == 3:
	with open(sys.argv[1], 'r') as inputFile, open(sys.argv[2], 'r') as headerFile, open(sys.argv[1] + '.fix', 'w') as outputFile:
		outputFile.write(inputFile.readline())
		line = headerFile.readline()
		line = headerFile.readline()
		while re.search('@SQ', line):
			outputFile.write(line)
			line = headerFile.readline()
		while True:
			line = inputFile.readline()
			if not line:
				break
			outputFile.write(line)
	Path(sys.argv[1] + '.fix').replace(sys.argv[1])
	sys.exit()

SQ = {}
with open(sys.argv[1], 'r') as inputFile, open(sys.argv[1] + '.fix', 'w') as outputFile:
	outputFile.write(inputFile.readline())
	line = inputFile.readline()
	while re.search('@SQ', line):
		try:
			SQ[line.split('\t')[1]] = line.split('\t')[2]
			line = inputFile.readline()
		except Exception:
			print(line)
	for key, value in SQ.items():
		outputFile.write(f'@SQ\t{key}\t{value}')
	outputFile.write(line)
	while True:
		line = inputFile.readline()
		if not line:
			break
		outputFile.write(line)

Path(sys.argv[1] + '.fix').replace(sys.argv[1])