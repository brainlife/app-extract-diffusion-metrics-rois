#!/usr/bin/env python3

import json
import subprocess
import pandas as pd
import numpy as np
import os, sys, argparse
import glob

def generateSummaryCsvs(subjectID,diffusion_measures,summary_measures,columns,outdir):
	#### loop through summary measures and make csvs for each. these can be used in MLC analyses ####
	
	with open('roi_name_list.txt','r') as roi_name_list_f:
		structureList = roi_name_list_f.read().split()
		print(structureList)

	# loop through summary statistic measures making one csv per parcellation and measure
	for measures in summary_measures:
		print(measures)

		# set up pandas dataframe
		df = pd.DataFrame([],columns=columns,dtype=object)
		df['subjectID'] = [ subjectID for x in range(len(structureList)) ]
		df['structureID'] = [ structureList[x] for x in range(len(structureList)) ]
		df['nodeID'] = [ 1 for x in range(len(structureList)) ]

		# loop through diffusion measures and read in diffusion measure data. each csv will contain all diffusion measures
		for metrics in diffusion_measures:
			print(metrics)
			# left hemisphere
			with open('./tmp/%s.%s.txt' %(measures,metrics),'r') as data_f:
				data = pd.read_csv(data_f,header=None)

			# add to dataframe
			df[metrics] = data
			
			# handle scaling issues
			if np.nanmedian(df[metrics].astype(np.float)) < 0.01:
				df[metrics] = df[metrics].astype(np.float) * 1000

		# write out to csv
		df.to_csv('./%s/%s.csv' %(outdir,measures), index=False)

def main():

	print("setting up input parameters")
	#### load config ####
	with open('config.json','r') as config_f:
		config = json.load(config_f)

	#### parse inputs ####
	subjectID = config['_inputs'][0]['meta']['subject']
  
	#### set up other inputs ####
	# grab diffusion measures from file names
	diffusion_measures = [ x.split('.')[2] for x in glob.glob('./tmp/MIN.*.txt') ]

	# depending on what's in the array, rearrange in a specific order I like
	if all(x in diffusion_measures for x in ['noddi_kappa','ga']):
		diffusion_measures = ['ad','fa','md','rd','ga','ak','mk','rk','ndi','isovf','odi','noddi_kappa']
	elif all(x in diffusion_measures for x in ['noddi_kappa','fa']):
		diffusion_measures = ['ad','fa','md','rd','ndi','isovf','odi','noddi_kappa']
	elif all(x in diffusion_measures for x in ['ndi','ga']):
		diffusion_measures = ['ad','fa','md','rd','ga','ak','mk','rk','ndi','isovf','odi']
	elif all(x in diffusion_measures for x in ['ndi','fa']):
		diffusion_measures = ['ad','fa','md','rd','ndi','isovf','odi']
	elif 'ga' in diffusion_measures:
		diffusion_measures = ['ad','fa','md','rd','ga','ak','mk','rk']
	elif 'fa' in diffusion_measures:
		diffusion_measures = ['ad','fa','md','rd']
	elif 'noddi_kappa' in diffusion_measures:
		diffusion_measures = ['ndi','isovf','odi','noddi_kappa']
	else:
		diffusion_measures = ['ndi','isovf','odi']

	if 'myelinmap' in diffusion_measures:
		diffusion_measures = diffusion_measures + ['myelinmap']

	if 'gmd' in diffusion_measures:
		diffusion_measures = diffusion_measures + ['gmd']

	# summary statistics measures
	summary_measures = [ x.split('.')[1].split('/')[2] for x in glob.glob('./tmp/*.%s.txt' %diffusion_measures[0]) ]
	
	# set columns for pandas array
	columns = ['subjectID','structureID','nodeID'] + diffusion_measures
		
	# set outdir
	outdir = 'parc-stats'
	
	# generate output directory if not already there
	if os.path.isdir(outdir):
		print("directory exits")
	else:
		print("making output directory")
		os.mkdir(outdir)

	#### run command to generate csv structures ####
	print("generating csvs")
	generateSummaryCsvs(subjectID,diffusion_measures,summary_measures,columns,outdir)

if __name__ == '__main__':
	main()
