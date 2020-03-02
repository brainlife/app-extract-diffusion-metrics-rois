#!/bin/bash

icvf=`jq -r '.icvf' config.json`
od=`jq -r '.od' config.json`
isovf=`jq -r '.isovf' config.json`
ad=`jq -r '.ad' config.json`
fa=`jq -r '.fa' config.json`
md=`jq -r '.md' config.json`
rd=`jq -r '.rd' config.json`

# set metrics for every situation
if [ ! -f ${icvf} ]; then
	metric="ad fa md rd"
	echo ${metric}
elif [ -f ${icvf} ] && [ -f ${fa} ]; then
	metric="icvf od isovf ad fa md rd"
	echo ${metric}
else
	metric="icvf od isovf"
	echo ${metric}
fi

# extract tensor data in rois
for ROI in dwi_*.nii.gz
do
	for MET in ${metric}
	do
		fslmaths ${!MET} -mul bin_${ROI} ${MET}_${ROI}
	done
done

