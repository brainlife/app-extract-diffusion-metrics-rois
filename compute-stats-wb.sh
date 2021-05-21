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
myelin=`jq -r '.myelin' config.json`

mkdir -p tmp

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
	METRIC=$METRIC+" myelin"
fi

# summary measures
summ_measures="MIN MAX MEAN MEDIAN MODE STDEV COUNT_NONZERO"

# compute summary measures for each metric and roi
for ROI in dwi_*.nii.gz
do
	roinift=`echo ${ROI#*dwi_}`
	roiname=`echo ${roinift%*.nii.gz}`
	echo ${roiname} >> roi_name_list.txt

	for MET in ${METRIC}
	do
		metric=$(eval "echo \$${MET}")
		for smeas in ${summ_measures}
		do
			value=`eval 'wb_command -volume-stats ${metric} -roi ${ROI} -reduce ${smeas}'`
			if [ $? -eq 0 ]; then
				echo ${value} >> ./tmp/${smeas}.${MET}.txt
			else
				echo "NaN" >> ./tmp/${smeas}.${MET}.txt
			fi
		done
	done
done