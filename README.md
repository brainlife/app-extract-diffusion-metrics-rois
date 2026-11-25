<h1 align="center">Extract diffusion metrics inside ROIs</h1>

<p align="center">
  Per-ROI summary statistics of tensor, NODDI and myelin maps, as CSV tables, from a set of ROIs and the diffusion maps of the same subject.
</p>

<p align="center">
  <a href="https://github.com/brainlife/abcd-spec"><img src="https://img.shields.io/badge/ABCD_Spec-v1.1-green.svg" alt="ABCD Spec v1.1"></a>
  <a href="https://doi.org/10.25663/brainlife.app.525"><img src="https://img.shields.io/badge/Brainlife-brainlife.app.525-blue.svg" alt="Run on brainlife.io"></a>
  <a href="LICENSE"><img src="https://img.shields.io/badge/License-MIT-lightgrey.svg" alt="MIT license"></a>
</p>

> 📍 **This branch, `v1.2`, is the brainlife.io App Extract diffusion metrics inside ROIs** ([doi:10.25663/brainlife.app.525](https://doi.org/10.25663/brainlife.app.525)). The other Apps in this repository are listed under **Versions on brainlife.io** below.

## 🧠 At a glance

<!-- brainlife-app:begin (generated from the App manifest; edit the manifest, not this block) -->

> **Extracts summary statistics (min, max, mean, median, mode, SD, non-zero count) of tensor, NODDI and myelin maps inside each ROI with Connectome Workbench, as CSVs.**

Optionally inflates the ROIs (MATLAB smooth3), resamples ROIs and metric maps to the DWI grid with FreeSurfer mri_vol2vol, computes per-ROI statistics with wb_command -volume-stats, and writes one CSV per statistic. Values of metrics whose median is below 0.01 (for example diffusivities in mm2/s) are multiplied by 1000.

| | |
|---|---|
| 📥 **Inputs** | `neuro/dwi` · `neuro/tensor` · `neuro/noddi` (optional) · `neuro/myelin-map` (optional) · `neuro/rois` |
| 📤 **Outputs** | `neuro/parc-stats` |
| 🐳 **Container** | `brainlife/mcr:neurodebian1604-r2017a` |
| ⚙️ **Resources** | 1 CPUs · 16 GB memory · 0.33 h walltime |
| 🔑 **Requires** | `FREESURFER_LICENSE` |
| 🔗 **Run it** | [doi.org/10.25663/brainlife.app.525](https://doi.org/10.25663/brainlife.app.525) |

#### 📥 Inputs

| Input | Datatype | Required | Description |
|---|---|---|---|
| `dwi` | `neuro/dwi` | yes | The path to the DWI datatype |
| `tensor` | `neuro/tensor` | yes | The path to the tensor datatype files |
| `noddi` | `neuro/noddi` | no | The path to the NODDI datatype files |
| `myelin` | `neuro/myelin-map` | no | Optional myelin map, resampled to the DWI grid like the diffusion maps. |
| `rois` | `neuro/rois` | yes | The path to the top directory containing the ROIs within which diffusion metrics will be extracted. ROIs must be in the same space as the DWI (resampled with --regheader). |

#### 📤 Outputs

| Output | Datatype | Description |
|---|---|---|
| `parc-stats` | `neuro/parc-stats` | Directory of CSVs (MIN, MAX, MEAN, MEDIAN, MODE, STDEV, COUNT_NONZERO) with one row per ROI and one column per metric. |

<details>
<summary><b>⚙️ Parameters</b> (2)</summary>

| Parameter | Type | Default | Description |
|---|---|---|---|
| `inflate` | boolean | `false` | Inflate (smooth and re-binarise) the ROIs before extracting metrics. |
| `smooth` | number | `1` | Box-kernel size for ROI inflation (odd number); used only when inflate is true. |

</details>

<!-- brainlife-app:end -->

## 🏷️ Versions on brainlife.io

Each version is a separate App on brainlife.io, built from a branch of this repository. Only the newest App is maintained; the older Apps wrote metric x ROI NIfTI images rather than statistics tables.

| App | Metrics | Branch | Run it | Status |
|---|---|---|---|---|
| **Extract diffusion metrics inside ROIs** (this branch) | tensor, optional NODDI and myelin | [`v1.2`](https://github.com/brainlife/app-extract-diffusion-metrics-rois/tree/v1.2) | [doi:10.25663/brainlife.app.525](https://doi.org/10.25663/brainlife.app.525) | current |
| Extract diffusion metrics inside ROIs - Deprecated | tensor and NODDI | [`v1.1`](https://github.com/brainlife/app-extract-diffusion-metrics-rois/tree/v1.1) | [doi:10.25663/brainlife.app.364](https://doi.org/10.25663/brainlife.app.364) | deprecated |
| Extract diffusion metrics inside ROIs (NODDI) | NODDI | [`v1.1`](https://github.com/brainlife/app-extract-diffusion-metrics-rois/tree/v1.1) | [doi:10.25663/brainlife.app.363](https://doi.org/10.25663/brainlife.app.363) | deprecated |
| Extract diffusion metrics inside ROIs (DTI) | tensor | [`v1.1`](https://github.com/brainlife/app-extract-diffusion-metrics-rois/tree/v1.1) | [doi:10.25663/brainlife.app.283](https://doi.org/10.25663/brainlife.app.283) | deprecated |
| Extract diffusion metrics inside ROIs - Deprecated | tensor and NODDI (old NODDI datatype) | [`v1.0`](https://github.com/brainlife/app-extract-diffusion-metrics-rois/tree/v1.0) | [doi:10.25663/brainlife.app.285](https://doi.org/10.25663/brainlife.app.285) | deprecated |
| Extract diffusion metrics inside ROIs (NODDI) - Deprecated | NODDI (old NODDI datatype) | [`v1.0`](https://github.com/brainlife/app-extract-diffusion-metrics-rois/tree/v1.0) | [doi:10.25663/brainlife.app.284](https://doi.org/10.25663/brainlife.app.284) | deprecated |

## 🚀 Running the App

### ☁️ On brainlife.io

Open the App at [doi.org/10.25663/brainlife.app.525](https://doi.org/10.25663/brainlife.app.525), choose a DWI dataset, its tensor maps, a set of ROIs (`neuro/rois`) and, optionally, NODDI maps and a myelin map from your project, decide whether to inflate the ROIs, and press **Execute**. The output is a `neuro/parc-stats` dataset of CSV tables with one row per ROI and one column per metric.

### 💻 Locally

You need [Singularity/Apptainer](https://apptainer.org/), [`jq`](https://jqlang.github.io/jq/) and a [FreeSurfer license](https://surfer.nmr.mgh.harvard.edu/registration.html) (the ROIs and maps are resampled with FreeSurfer `mri_vol2vol`). The containers are pulled from Docker Hub on first use.

1. Clone this repository and check out the current version (`git checkout v1.2`).
2. Create `config.json` with the paths to your inputs and the options you want. Leave out the NODDI keys (`ndi`, `isovf`, `odi`) or `myelin` if you do not have those maps. The CSV step reads the subject ID from `_inputs`, which brainlife.io fills in:

   ```json
   {
       "dwi": "/input/dwi/dwi.nii.gz",
       "bvals": "/input/dwi/dwi.bvals",
       "bvecs": "/input/dwi/dwi.bvecs",
       "ad": "/input/tensor/ad.nii.gz",
       "fa": "/input/tensor/fa.nii.gz",
       "md": "/input/tensor/md.nii.gz",
       "rd": "/input/tensor/rd.nii.gz",
       "ndi": "/input/noddi/ndi.nii.gz",
       "isovf": "/input/noddi/isovf.nii.gz",
       "odi": "/input/noddi/odi.nii.gz",
       "rois": "/input/rois/rois/",
       "inflate": false,
       "smooth": 1,
       "_inputs": [{"meta": {"subject": "sub-01"}}]
   }
   ```

3. Export your license and run the App:

   ```bash
   export FREESURFER_LICENSE="$(cat ~/freesurfer/license.txt)"
   ./main
   ```

### 🧪 Sample data

Download sample datasets from brainlife.io with the [brainlife CLI](https://github.com/brainlife/cli):

```bash
npm install -g brainlife
bl login
mkdir input
bl dataset download <dataset id>
```

## 📦 Outputs

```text
parc-stats/
└── parc-stats/
    ├── MIN.csv
    ├── MAX.csv
    ├── MEAN.csv
    ├── MEDIAN.csv
    ├── MODE.csv
    ├── STDEV.csv
    └── COUNT_NONZERO.csv
raw/          ROIs and metric maps resampled to the DWI grid
```

Each CSV has one row per ROI (`subjectID`, `structureID`, `nodeID`) and one column per metric (`ad`, `fa`, `md`, `rd`, and `ga`, `ak`, `mk`, `rk`, `ndi`, `isovf`, `odi`, `myelin` when present). Metrics whose median is below 0.01, such as diffusivities in mm²/s, are multiplied by 1000.

## 🩺 Troubleshooting

- **`something went wrong. check derivatives`**: `parc-stats/MEAN.csv` was not produced. The ROIs are resampled to the DWI with `--regheader`, so the ROIs and metric maps must already be in the same space as the DWI; check the logs.
- **ROI inflation**: when `inflate` is set, `smooth` is the box-kernel size used to inflate the ROIs and must be an odd number.

## 📚 Citing

> [!TIP]
> If you use this App in your work, please cite the App, the software it builds on and brainlife.io (below). GitHub's **Cite this repository** button gives the App citation in APA and BibTeX.

- Extract diffusion metrics inside ROIs. brainlife.io App. [doi:10.25663/brainlife.app.525](https://doi.org/10.25663/brainlife.app.525)
- Fischl. FreeSurfer. *NeuroImage* 62:774-781 (2012). [doi:10.1016/j.neuroimage.2012.01.021](https://doi.org/10.1016/j.neuroimage.2012.01.021)
- Marcus et al. Informatics and Data Mining Tools and Strategies for the Human Connectome Project. *Frontiers in Neuroinformatics* 5 (2011). [doi:10.3389/fninf.2011.00004](https://doi.org/10.3389/fninf.2011.00004)
- Zhang et al. NODDI: Practical in vivo neurite orientation dispersion and density imaging of the human brain. *NeuroImage* 61:1000-1016 (2012). [doi:10.1016/j.neuroimage.2012.03.072](https://doi.org/10.1016/j.neuroimage.2012.03.072)
- Hayashi S, Caron BA, Heinsfeld AS, et al. brainlife.io: a decentralized and open-source cloud platform to support neuroscience research. *Nature Methods* 21:809–813 (2024). [doi:10.1038/s41592-024-02237-2](https://doi.org/10.1038/s41592-024-02237-2)
- Avesani P, McPherson B, Hayashi S, et al. The open diffusion data derivatives, brain data upcycling via integrated publishing of derivatives and reproducible open cloud services. *Scientific Data* 6:69 (2019). [doi:10.1038/s41597-019-0073-y](https://doi.org/10.1038/s41597-019-0073-y)

## 👥 Authors

- Brad Caron

**Contributors:** Soichi Hayashi

## 💰 Funding

[![Wellcome-226486/Z/22/Z](https://img.shields.io/badge/Wellcome-226486%2FZ%2F22%2FZ-purple.svg)](https://wellcome.org/)
[![NIH-NINDS-U24NS140384](https://img.shields.io/badge/NIH_NINDS-U24NS140384-green.svg)](https://reporter.nih.gov/project-details/11261037)
[![NIH-NINDS-UM1NS132207](https://img.shields.io/badge/NIH_NINDS-UM1NS132207-green.svg)](https://reporter.nih.gov/project-details/11411328)
[![NIH-NIBIB-R01EB029272](https://img.shields.io/badge/NIH_NIBIB-R01EB029272-green.svg)](https://reporter.nih.gov/project-details/10262925)
[![NIH-NIBIB-R01EB030896](https://img.shields.io/badge/NIH_NIBIB-R01EB030896-green.svg)](https://reporter.nih.gov/project-details/10428625)
[![NIH-NIMH-R01MH126699](https://img.shields.io/badge/NIH_NIMH-R01MH126699-green.svg)](https://reporter.nih.gov/project-details/10460628)
[![NIH-NIDCD-R01DC020088](https://img.shields.io/badge/NIH_NIDCD-R01DC020088-green.svg)](https://reporter.nih.gov/project-details/11140284)
[![NSF-BCS-1734853](https://img.shields.io/badge/NSF_BCS-1734853-blue.svg)](https://www.nsf.gov/awardsearch/showAward?AWD_ID=1734853)
[![NSF-BCS-2203524](https://img.shields.io/badge/NSF_BCS-2203524-blue.svg)](https://www.nsf.gov/awardsearch/showAward?AWD_ID=2203524)
[![NSF-IIS-1636893](https://img.shields.io/badge/NSF_IIS-1636893-blue.svg)](https://www.nsf.gov/awardsearch/showAward?AWD_ID=1636893)
[![NSF-OAC-2148729](https://img.shields.io/badge/NSF_OAC-2148729-blue.svg)](https://www.nsf.gov/awardsearch/showAward?AWD_ID=2148729)
[![NSF-IIS-1912270](https://img.shields.io/badge/NSF_IIS-1912270-blue.svg)](https://www.nsf.gov/awardsearch/showAward?AWD_ID=1912270)
[![NSF-IIS-2148700](https://img.shields.io/badge/NSF_IIS-2148700-blue.svg)](https://www.nsf.gov/awardsearch/showAward?AWD_ID=2148700)
[![NSF-OAC-1916518](https://img.shields.io/badge/NSF_OAC-1916518-blue.svg)](https://www.nsf.gov/awardsearch/showAward?AWD_ID=1916518)

<sub>brainlife.io is publicly funded, and acknowledging that support helps keep it running. This App was developed with support from Wellcome, the U.S. National Institutes of Health (including the BRAIN Initiative BRAIN CONNECTS program: The Axonal Projectome EXchange, U24NS140384, and the Center for Mesoscale Connectomics, UM1NS132207) and the U.S. National Science Foundation.</sub>

## ⚖️ License

[MIT](LICENSE). FreeSurfer is distributed under its own [license](https://surfer.nmr.mgh.harvard.edu/fswiki/FreeSurferSoftwareLicense).
