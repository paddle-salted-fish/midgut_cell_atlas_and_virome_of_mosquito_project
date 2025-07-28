#! /public21/home/sc90258/miniconda3/bin/python
# -*- coding: utf-8 -*-

# %%
import sys, subprocess
from pathlib import Path
title = sys.argv[1]
# title = 'bowtal_filter140bp'

# %%
# import the ref database, acc2id: accid to taxid; ref: taxid to viral name
ref = {}
acc2id = {}
with open('../ref/nuc_viruses.taxid', 'r') as inputFile:
	while True:
		line = inputFile.readline()
		if not line:
			break
		parse = line[:-1:].split('\t')
		id = parse[1]
		acc = parse[0]
		name = parse[2]
		ref[id] = name
		acc2id[acc] = id

# %%
result = []
x = set()

# %%
# get SAM-exported file, fields: read_name subject_accession
result = {}
with open(f'{title}.blastn', 'r') as inputFile:
	while True:
		line = inputFile.readline()
		if not line:
			break
		name = line[:-1:].split('\t')[1]
		if name in result.keys():
			result[name] += 1
		else:
			result[name] = 1
with open(f'{title}.abundance', 'w') as outputFile:
	for key, value in result.items():
		outputFile.write(f'{key}\t{value}\n')

# %%
# convert accid to taxid
abundance = {}
with open(f'{title}.abundance', 'r') as inputFile:
	while True:
		line = inputFile.readline()
		if not line:
			break
		parse = line[:-1:].split('\t')
		acc = parse[0]
		value = parse[1]
		abundance[acc] = value

# %%
# write into file
result = {}
for key, value in abundance.items():
	if acc2id[key] in result.keys():
		result[acc2id[key]] += int(value)
	else:
		result[acc2id[key]] = int(value)

with open(f'{title}.tmp.taxid', 'w') as taxid, open(f'{title}.tmp.abundance', 'w') as abundance:
	for key, value in result.items():
		taxid.write(f'{key}\n')
		abundance.write(f'{value}\n')

# convert virus name into species name
# %%
with open(f'{title}.tmp.species', 'w') as f:
	subprocess.run(['callTax', f'{title}.tmp.taxid', 'species'], stdout=f, text=True)

# %%
with open(f'{title}.tmp.family', 'w') as f:
	subprocess.run(['callTax', f'{title}.tmp.taxid', 'family'], stdout=f, text=True)

# %%
with open(f'{title}.species.abundance', 'w') as f:
	subprocess.run(['paste', '-d', '\t', f'{title}.tmp.species', f'{title}.tmp.family',
					f'{title}.tmp.abundance'], stdout=f, text=True)

# %%
family = {}
result = {}
with open(f'{title}.species.abundance', 'r') as inputFile:
	for line in inputFile.readlines():
		parse = line[:-1].split('\t')
		key = parse[0]
		family[key] = parse[1]
		if key in result.keys():
			result[key] += int(parse[2])
		else:
			result[key] = int(parse[2])

with open(f'{title}.species.abundance', 'w') as outputFile:
	for key in result.keys():
		outputFile.write(f'{key}\t{family[key]}\t{result[key]}\n')

with open(f'{title}.species.sorted.abundance', 'w') as f:
	subprocess.run(['sort', '-t', '\t', '-k3,3nr', f'{title}.species.abundance'], stdout=f, text=True)
Path(f'{title}.species.abundance').unlink(missing_ok=True)

# %%
with open(f'{title}.family.abundance', 'w') as f:
	subprocess.run(['paste', '-d', '\t', f'{title}.tmp.family',
					f'{title}.tmp.abundance'], stdout=f, text=True)

# %%
result = {}
with open(f'{title}.family.abundance', 'r') as inputFile:
	for line in inputFile.readlines():
		parse = line[:-1].split('\t')
		key = parse[0]
		if key in result.keys():
			result[key] += int(parse[1])
		else:
			result[key] = int(parse[1])

with open(f'{title}.family.abundance', 'w') as outputFile:
	for key in result.keys():
		outputFile.write(f'{key}\t{result[key]}\n')

# %%
with open(f'{title}.family.sorted.abundance', 'w') as f:
	subprocess.run(['sort', '-k2,2nr', f'{title}.family.abundance'], stdout=f, text=True)
Path(f'{title}.family.abundance').unlink(missing_ok=True)
# %%

for file in Path().glob('*tmp*'):
	file.unlink(missing_ok=True)
