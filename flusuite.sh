#!/bin/bash

#Put on some ASCII ART

#Check that scripts are installed
if [ ! -f "genbankdl.py" ]; then echo "The genbankdl.py Does Not Exist"; exit; fi
if [ ! -f "irdformatter_py3.py" ]; then echo "The irdformatter_py3.py Does Not Exist"; exit; fi

#Process the genbank data (needs alignment)
echo -e "\e[92mPulling data directly from genbank"
/usr/bin/python2.7 genbankdl.py -d

#Analyze the downloaded data
echo -e "\e[92mProcessing Data"
python irdformatter_py3.py -i influenza_faa.tsv -c -v

#Output motif over time data
python motiftime_py3.py -i influenza_faa.tsv

#Explain output
echo -e "\e[92mProcessing complete!"
echo -e "\e[95mAssignments are in the first .TSV.xlsx file"
echo -e "\e[95mCluster analysis is in the color.TSV.xlsx file"
