#!/bin/bash

ndi=`jq -r '.ndi' config.json`
odi=`jq -r '.odi' config.json`
isovf=`jq -r '.isovf' config.json`
ad=`jq -r '.ad' config.json`
fa=`jq -r '.fa' config.json`
md=`jq -r '.md' config.json`
rd=`jq -r '.rd' config.json`

mkdir -p raw

# set metrics for every situation
if [ ! -f ${ndi} ]; then
	metric="ad fa md rd"
	echo ${metric}
elif [ -f ${ndi} ] && [ -f ${fa} ]; then
	metric="ndi odi isovf ad fa md rd"
	echo ${metric}
else
	metric="ndi odi isovf"
	echo ${metric}
fi

# extract tensor data in rois
for ROI in dwi_*.nii.gz
do
	for MET in ${metric}
	do
		fslmaths ${!MET} -mul ${ROI} ${MET}_${ROI}
	done
done

