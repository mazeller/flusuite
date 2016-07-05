#!/bin/bash

#need to add update functionality
#Consider adding to path

#Check if folders exist, then pull
if [ ! -e "flusuite" ]; then 
	echo -e "\e[92mDownloading Flusuite Wrapper" 
	git clone https://github.com/mazeller/flusuite.git
fi
if [ ! -e "genbankdl" ]; then 
	echo -e "\e[92mDownloading Genbank Downloader" 
	git clone https://github.com/mazeller/genbankdl.git
fi
if [ ! -e "irdformatter" ]; then 
	echo -e "\e[92mDownloading IRD Formatter" 
	git clone https://github.com/mazeller/irdformatter.git
fi

#Install Dependencies locally to python2.7
echo -e "\e[92mInstalling openpyxl"
curl 'https://pypi.python.org/packages/25/69/7976ba24d2b532e96157623daa8de4bbcad23e0761b3062d5e38775577d5/openpyxl-2.4.0-b1.tar.gz' -o 'openpyxl.tar.gz'
tar -zxf openpyxl.tar.gz 
/usr/bin/python2.7 openpyxl-2.4.0-b1/setup.py install --user
rm -R openpyxl-2.4.0-b1/
rm -R openpyxl.egg-info/
rm openpyxl.tar.gz

#Install is hopefully complete 
