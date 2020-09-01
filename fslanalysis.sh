#!/bin/bash

ad=`jq -r '.ad' config.json`
fa=`jq -r '.fa' config.json`
md=`jq -r '.md' config.json`
rd=`jq -r '.rd' config.json`
ga=`jq -r '.ga' config.json`
ak=`jq -r '.ak' config.json`
mk=`jq -r '.mk' config.json`
rk=`jq -r '.rk' config.json`
ndi=`jq -r '.ndi' config.json`
isovf=`jq -r '.isovf' config.json`
odi=`jq -r '.odi' config.json`

mkdir -p raw

# set metrics for every situation
if [[ $fa == "null" ]];
then
	METRIC="ndi isovf odi"
elif [[ $ndi == "null" ]] && [[ $ga == "null" ]]; then
	METRIC="ad fa md rd"
elif [[ $ndi == "null" ]] && [[ ! $ga == "null" ]]; then
	METRIC="ad fa md rd ga ak mk rk"
elif [[ ! $fa == "null" ]] && [[ ! $ndi == "null" ]] && [[ $ga == "null" ]]; then
	METRIC="ad fa md rd ndi isovf odi"
else
	METRIC="ad fa md rd ga ak mk rk ndi isovf odi"
fi

# extract tensor data in rois
for ROI in dwi_*.nii.gz
do
	for MET in ${metric}
	do
		fslmaths ${!MET} -mul ${ROI} ${MET}_${ROI}
	done
done

