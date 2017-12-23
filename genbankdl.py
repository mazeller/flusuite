# -*- coding: utf-8 -*-
#Written for Python 2.7
"""
Created on Tue Jun 28 15:29:43 2016

@author: michael.zeller
"""

import urllib, urllib2, sys, getopt, gzip, re
import os.path

usastates = ['alabama','alaska','arizona','arkansas','california','colorado','connecticut','delaware','florida','georgia','hawaii','idaho','illinois','indiana','iowa','kansas','kentucky','louisiana','maine','maryland','massachusetts','michigan','minnesota','mississippi','missouri','montana','nebraska','nevada','new hampshire','new jersey','new mexico','new york','north carolina','north dakota','ohio','oklahoma','oregon','pennsylvania','rhode island','south carolina','south dakota','tennessee','texas','utah','vermont','virginia','washington','west virginia','wisconsin','wyoming', 'usa']

#HELP DOCUMENATION
def displayHelp():
        print("""
        @@ snake @@  11/96
                          _,..,,,_ 
                     '``````^~"-,_`"-,_
       .-~c~-.                    `~:. ^-.     
   `~~~-.c    ;                      `:.  `-,     _.-~~^^~:.
         `.   ;      _,--~~~~-._       `:.   ~. .~          `.
          .` ;'   .:`           `:       `:.   `    _.:-,.    `.
        .' .:   :'    _.-~^~-.    `.       `..'   .:      `.    '
       :  .' _:'   .-'        `.    :.     .:   .'`.        :    ;
  jgs  :  `-'   .:'             `.    `^~~^`   .:.  `.      ;    ;
        `-.__,-~                  ~-.        ,' ':    '.__.`    :'
                                     ~--..--'     ':.         .:'
                                                     ':..___.:'
from: http://chris.com/ascii/index.php?art=animals/reptiles/snakes
        
USAGE: python genbankdl.py [-d]
        
The purpose of this program is to download the file from genbank containing all the flu information and process it out to TSV, for use to process
""")
 
def main():
	#Get arguments
	argv = sys.argv[1:]
	ftpDownload = False	#Downlaod the full AA Fasta file FTP from genbank
	try:
		opts, args = getopt.getopt(argv,"dh",["download","help"])
	except getopt.GetoptError:
		displayHelp()
		sys.exit(2)
	for opt, arg in opts:
		if opt in ('-h',"help"):
			displayHelp()
			sys.exit()
		elif opt in ("-d", "--download"):
			ftpDownload = True
            
	#Download file
	if(ftpDownload == True):
		response = urllib.urlretrieve('ftp://ftp.ncbi.nih.gov/genomes/INFLUENZA/influenza.faa.gz', 'influenza_faa.gz')
	
	#Unzip, program assumes the compressed file is present
	if(not os.path.isfile('influenza_faa')):
		zipArchive = gzip.open("influenza_faa.gz")
		output = open("influenza_faa", "wb")
		output.write(zipArchive.read())
		zipArchive.close()
		output.close()
	         
	#Open TSV to write to
	outputTSV = open('influenza_faa.tsv', 'w')
	outputTSV.write('Name	Sequence Accession	Complete Genome	Segment	Segment Length	Subtype	Collection Date	Host Species	Country	State/Province	Flu Season	Strain Name	Sequence	Clade Classification\n')
	
	headerInfo = []
	subheaderInfo = []
	sequence = ''
	#Parse and sort file
	with open('influenza_faa') as f:
        	for line in f:
			#Hunt for header lines
			if(line[0] == '>'):

                                #if(re.match("^>.+\|hemagglutinin\[.+/swine/.+H3",line.lower())): #JC: alt. REGEX to match the hemagglutinin swine H3 lines
                                # JC: could make this general purpose (H1, H3, etc)

				#This structure is positioned to not execute till after a full sequence has been filled
				if(len(subheaderInfo) >= 4) and (subheaderInfo[0] == 'hemagglutinin') and (subheaderInfo[3][0:2] == "H3"):
					#Check Species = Swine, check if is in US
					localInfo = subheaderInfo[2].split('/')
					if(localInfo[1].lower() == 'swine') and (localInfo[2].lower() in usastates):
						#Store pertinent information
						outputTSV.write("HA\t" + headerInfo[3] + "\t\t4\t\t" + subheaderInfo[3] + "\t" + localInfo[len(localInfo) - 1]+ "\tSwine\t\t" + localInfo[2]  + "\t\t" + subheaderInfo[2] + '\t' + sequence + '\n')

				#Blank variables
				sequence = ''
				headerInfo = line.split('|')

                                subheaderInfo = re.sub("[\[\])]",'(',headerInfo[4]).split('(')       #JC:the REGEX

#				subheaderInfo = headerInfo[4].replace('[','(').replace(')','(').replace(']','(').split('(')	#Replace with REGEX

			elif(line[0] == '\n'):
				x=1
			else:
				sequence = sequence + line.rstrip()

	#Close files
	f.close()
	outputTSV.close()
if __name__ == "__main__": main()
