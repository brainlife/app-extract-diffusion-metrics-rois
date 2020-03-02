function [] = inflateROIs()

if ~isdeployed
    disp('loading path')

    %for IU HPC
    addpath(genpath('/N/u/brlife/git/vistasoft'))
    addpath(genpath('/N/u/brlife/git/encode'))
    addpath(genpath('/N/u/brlife/git/jsonlab'))
    addpath(genpath('/N/u/brlife/git/spm'))
    addpath(genpath('/N/u/brlife/git/wma_tools'))

    %for old VM
    addpath(genpath('/usr/local/vistasoft'))
    addpath(genpath('/usr/local/encode'))
    addpath(genpath('/usr/local/jsonlab'))
    addpath(genpath('/usr/local/spm'))
    addpath(genpath('/usr/local/wma_tools'))
end

% Set top directory
topdir = pwd;

% Load configuration file
config = loadjson('config.json');

% parse variables
roisDir = config.rois;
smoothKernel = config.smooth;
rois = dir(roisDir);
rois = rois(3:end);

% for loop to smooth
for rr = 1:length(rois)
    roi = niftiRead(fullfile(rois(rr).folder,rois(rr).name));
    roi.data = smooth3(roi.data,'box',smoothKernel);
    roi.data(roi.data(:) > 0) = 1;
    niftiWrite(roi,sprintf('inflate_%s',rois(rr).name));
    clear roi;
end

exit;
end
