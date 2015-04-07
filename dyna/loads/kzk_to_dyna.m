clear; clf;
load c52_intensity_vals_30mm_original

% figure(1)
% imagesc(depthStep, lat, squeeze(intensity(51, :, :)))
% size(squeeze(intensity(51, :, :)))

%% pre-processing (unit conversion + change to Field II coordinates, etc)
% re-format intensity file to have dimensions in order of 
% elevation, depth, lateral positions
intensity = permute(intensity, [3 2 1]);
% conversion from mm to cm
lat = lat/10;
ele = ele/10;
depthStep = depthStep/10;
% making axial dimension negative w/ transducer face at z = 0
depthStep = -depthStep;

%% make measurementPointsAndNodes
% getting uniform depth steps from kzk sim's depthStep output
depthStepSize = roundn(mean(diff(depthStep)), -2);
depth = roundn(depthStep(end), -2):-depthStepSize:0;
depth = depth';

FIELD_PARAMS.measurementPointsandNodes = zeros(length(lat)*length(depth)*length(ele), 4);
nodeid = 0;
for nDepth=1:length(depth)
    for nLat=1:length(lat)
        for nEle=1:length(ele)
            nodeid = nodeid + 1;
            FIELD_PARAMS.measurementPointsandNodes(nodeid, 1) = nodeid;
            FIELD_PARAMS.measurementPointsandNodes(nodeid, 2) = ele(nEle);
            FIELD_PARAMS.measurementPointsandNodes(nodeid, 3) = lat(nLat);
            FIELD_PARAMS.measurementPointsandNodes(nodeid, 4) = depth(nDepth);
        end            
    end
end
% defining more field parameters
FIELD_PARAMS.measurementPoints = FIELD_PARAMS.measurementPointsandNodes(:, 2:4);

%% interpolating intensity values to correspond to a mesh of uniform size
[eleGridOrig, latGridOrig, depthGridOrig] = ndgrid(ele, lat, depthStep);
[eleGrid, latGrid, depthGrid] = ndgrid(ele, lat, depth);
depthStep = depthStep';
intensity_interp = interpn(eleGridOrig, latGridOrig, depthGridOrig, intensity, eleGrid, latGrid, depthGrid, 'linear');
% lose the first and last depth planes due to those depth values being
% outside interpolation range, so we just replace those planes with the
% non-interpolated data.
intensity_interp(:, :, 1) = intensity(:, :, 1);
intensity_interp(:, :, end) = intensity(:, :, end);
% next step is to match up intensity values with measurementPointsAndNodes
intensity = zeros(1, numel(intensity_interp));
index = 1;
for nDepth=length(depth):-1:1
    for nLat=1:length(lat)
        for nEle=1:length(ele)
            intensity(index) = intensity_interp(nEle, nLat, nDepth);
            index = index + 1;
        end            
    end
end

%% estimating Fnum
focalDepth = 3; % cm
% this is the intensity plane closest to the transducer face.
% uncomment three lines below if you want to look at this plane.
% intensity_transducer_plane = squeeze(intensity_interp(:, :, 1));
% figure(1)
% imagesc(lat, ele, intensity_transducer_plane);
% estimated the aperture size to be approximately 
apertureSize = 1.16; % cm
FnumApprox = roundn(focalDepth/apertureSize, -1);

%% other field parameters (mostly hard-coded for c52)
FIELD_PARAMS.Frequency = 2.36;           % MHz
FIELD_PARAMS.Transducer = 'c52';    
FIELD_PARAMS.alpha = 0.45;               % dB/cm/MHz
FIELD_PARAMS.Fnum = FnumApprox;     
FIELD_PARAMS.soundSpeed = 1540;          % m/s
FIELD_PARAMS.samplingFrequency = 5e9/10; % Hz (?) from try3d_kzk_sim.m
FIELD_PARAMS.focus = [0 0 0.030];        % m
FIELD_PARAMS.Impulse = 'gaussian';       % won't be used
%% save to dyna file
eval(sprintf('save dyna-kzk-f%.2f-F%.1f-FD%.3f-a%.2f.mat intensity FIELD_PARAMS',...
             FIELD_PARAMS.Frequency,FIELD_PARAMS.Fnum,FIELD_PARAMS.focus(3),...
             FIELD_PARAMS.alpha));










