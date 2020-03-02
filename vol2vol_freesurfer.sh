#!/bin/bash

dwi=`jq -r '.dwi' config.json`
rois=`jq -r '.rois' config.json`
inflate=`jq -r '.inflate' config.json`

# if rois weren't inflated, copy to working dir
[[ ${inflate} == 'false' ]] && cp ${rois}/*.nii.gz ./

# move rois into diffusion dimensions
for ROI in ./*.nii.gz
do
	echo ${ROI}
	echo ${dwi}
	mri_vol2vol --mov ${ROI} --targ ${dwi} --regheader --interp nearest --o dwi_${ROI:2}
done
