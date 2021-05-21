[![Abcdspec-compliant](https://img.shields.io/badge/ABCD_Spec-v1.1-green.svg)](https://github.com/brain-life/abcd-spec)
[![Run on Brainlife.io](https://img.shields.io/badge/Brainlife-brainlife.app.285-blue.svg)](https://doi.org/10.25663/brainlife.app.285)

# Extract diffusion metrics inside ROIs 

This app will extracts diffusion metrics (tensor, NODDI) from within ROIs for ROI-level analysis using FSL. Will output metric x ROI NIFTI images. Takes in DWI, tensor, NODDI, and ROIs inputs and outputs a directory with the metric x ROI NIFTI images. Inflation can be performed on the ROIs using SPM. 

### Authors 

- Brad Caron (bacaron@iu.edu) 

### Contributors 

- Soichi Hayashi (hayashis@iu.edu) 

### Funding 

[![NSF-BCS-1734853](https://img.shields.io/badge/NSF_BCS-1734853-blue.svg)](https://nsf.gov/awardsearch/showAward?AWD_ID=1734853)
[![NSF-BCS-1636893](https://img.shields.io/badge/NSF_BCS-1636893-blue.svg)](https://nsf.gov/awardsearch/showAward?AWD_ID=1636893)
[![NSF-ACI-1916518](https://img.shields.io/badge/NSF_ACI-1916518-blue.svg)](https://nsf.gov/awardsearch/showAward?AWD_ID=1916518)
[![NSF-IIS-1912270](https://img.shields.io/badge/NSF_IIS-1912270-blue.svg)](https://nsf.gov/awardsearch/showAward?AWD_ID=1912270)
[![NIH-NIBIB-R01EB029272](https://img.shields.io/badge/NIH_NIBIB-R01EB029272-green.svg)](https://grantome.com/grant/NIH/R01-EB029272-01)

## Running the App 

### On Brainlife.io 

You can submit this App online at [https://doi.org/10.25663/brainlife.app.285](https://doi.org/10.25663/brainlife.app.285) via the 'Execute' tab. 

### Running Locally (on your machine) 

1. git clone this repo 

2. Inside the cloned directory, create `config.json` with something like the following content with paths to your input files. 

```json 
{
   "dwi":    "testdata/dwi/dwi.nii.gz",
    "bvals":    "testdata/dwi/dwi.bvals",
    "bvecs":    "testdata/dwi/dwi.bvecs",
    "fa":    "testdata/tensor/fa.nii.gz",
    "icvf":    "testdata/noddi/icvf.nii.gz",
    "rois":    "testdata/rois/rois/",
    "inflate":    true,
    "smooth":    1
} 
``` 

### Sample Datasets 

You can download sample datasets from Brainlife using [Brainlife CLI](https://github.com/brain-life/cli). 

```
npm install -g brainlife 
bl login 
mkdir input 
bl dataset download 
``` 

3. Launch the App by executing 'main' 

```bash 
./main 
``` 

## Output 

The main output of this App is is a directory containing the metric x ROI NIFTI images. 

#### Product.json 

The secondary output of this app is `product.json`. This file allows web interfaces, DB and API calls on the results of the processing. 

### Dependencies 

This App requires the following libraries when run locally. 

- FSL: https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/FslInstallation
- Freesurfer: https://surfer.nmr.mgh.harvard.edu/fswiki/DownloadAndInstall
- Matlab: https://www.mathworks.com/help/install/install-products.html
- SPM8: https://www.fil.ion.ucl.ac.uk/spm/software/spm8/
- jsonlab: https://github.com/fangq/jsonlab
