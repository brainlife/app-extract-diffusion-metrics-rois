#!/bin/bash

dwi=`jq -r '.dwi' config.json`
rois=`jq -r '.rois' config.json`
inflate=`jq -r '.inflate' config.json`
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
myelin=`jq -r '.myelin' config.json`

# set metrics for every situation
echo "parsing input diffusion metrics"
if [[ $fa == "null" ]];
then
	METRIC="ndi isovf odi"
elif [[ $ndi == "null" ]] && [ ! -f $ga ]; then
	METRIC="ad fa md rd"
elif [[ $ndi == "null" ]] && [ -f $ga ]; then
	METRIC="ad fa md rd ga ak mk rk"
elif [ -f $fa ] && [ -f $ndi ] && [ ! -f $ga ]; then
	METRIC="ad fa md rd ndi isovf odi"
else
	METRIC="ad fa md rd ga ak mk rk ndi isovf odi"
fi
echo "input diffusion metrics set"

if [[ ! $myelin == "null" ]]; then
	METRIC=$METRIC" myelin"
fi

# if rois weren't inflated, copy to working dir
[[ ${inflate} == 'false' ]] && cp ${rois}/*.nii.gz ./

# move rois into diffusion dimensions
for ROI in ./*.nii.gz
do
	echo ${ROI}
	echo ${dwi}
	mri_vol2vol --mov ${ROI} --targ ${dwi} --regheader --interp nearest --o dwi_${ROI:2}
done

# move metrics into ref space
for MET in ${METRIC}
do
	echo ${MET}
	echo ${dwi}
	metric=$(eval "echo \$${MET}")
	mri_vol2vol --mov ${metric} --targ ${dwi} --regheader --interp nearest --o ${MET}.nii.gz
done



