#! /usr/bin/env bash

#Process the genbank data (needs alignment)
echo -e "\e[92mPulling data directly from genbank"
python genbankdl.py -d

#Analyze the downloaded data
echo -e "\e[92mProcessing Data"
python irdformatter_py3.py -i influenza_faa.tsv -c -v

#Output motif over time data
python motiftime_py3.py -i influenza_faa.tsv

#Explain output
echo -e "\e[92mProcessing complete!"
echo -e "\e[95mAssignments are in the first .TSV.xlsx file"
echo -e "\e[95mCluster analysis is in the color.TSV.xlsx file"
