#!/bin/bash

#Put on some ASCII ART
print("""
      ___                         ___                    ___           ___                                     ___     
     /\__\                       /\  \                  /\__\         /\  \                                   /\__\    
    /:/ _/_                      \:\  \                /:/ _/_        \:\  \       ___           ___         /:/ _/_   
   /:/ /\__\                      \:\  \              /:/ /\  \        \:\  \     /\__\         /\__\       /:/ /\__\  
  /:/ /:/  /    ___     ___   ___  \:\  \            /:/ /::\  \   ___  \:\  \   /:/__/        /:/  /      /:/ /:/ _/_ 
 /:/_/:/  /    /\  \   /\__\ /\  \  \:\__\          /:/_/:/\:\__\ /\  \  \:\__\ /::\  \       /:/__/      /:/_/:/ /\__\
 \:\/:/  /     \:\  \ /:/  / \:\  \ /:/  /          \:\/:/ /:/  / \:\  \ /:/  / \/\:\  \__   /::\  \      \:\/:/ /:/  /
  \::/__/       \:\  /:/  /   \:\  /:/  /            \::/ /:/  /   \:\  /:/  /   ~~\:\/\__\ /:/\:\  \      \::/_/:/  / 
   \:\  \        \:\/:/  /     \:\/:/  /              \/_/:/  /     \:\/:/  /       \::/  / \/__\:\  \      \:\/:/  /  
    \:\__\        \::/  /       \::/  /                 /:/  /       \::/  /        /:/  /       \:\__\      \::/  /   
     \/__/         \/__/         \/__/                  \/__/         \/__/         \/__/         \/__/       \/__/    
SUPER UNSTABLE AND KIND OF CLUNKY
(art from http://patorjk.com/software/taag/#p=display&f=Graffiti&t=Type%20Something%20)
""")

#Check that scripts are installed
if [ ! -f "../genbankdl/genbankdl.py" ]; then echo "The File Does Not Exist"; exit; fi
if [ ! -f "../irdformatter/irdformatter_py3.py" ]; then echo "The File Does Not Exist"; exit; fi

#Process the genbank data (needs alignment)
echo -e "\e[92mPulling data directly from genbank"
/usr/bin/python2.7 ../genbankdl/genbankdl.py -d

#Analyze the downloaded data
echo -e "\e[92mProcessing Data"
/usr/bin/python2.7 ../irdformatter/irdformatter.py -i influenza_faa.tsv -c -v

#Explain output
echo -e "\e[92mProcessing complete!"
echo -e "\e[95mAssignments are in the first .TSV.xlsx file"
echo -e "\e[95mCluster analysis is in the color.TSV.xlsx file"
