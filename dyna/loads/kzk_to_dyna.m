function [] = kzk_to_dyna(intensity_file, attenuation)

load(intensity_file) 

%% pre-processing (unit conversion + change to Field II coordinates, etc)
% re-format intensity file to have dimensions in order of 
% elevation, depth, lateral positions
intensity = permute(intensity, [3 2 1]);

intensity = intensity((find(ele==-6):find(ele==0)), ...
                      (find(lat==0):find(lat==20)), ...
                      :);
% conversion from mm to cm
lat = lat(find(lat==0):find(lat==20))/10;
ele = ele(find(ele==-6):find(ele==0))/10;
depth = depth/10;
% making axial dimension negative w/ transducer face at z = 0
depth = -depth;

%% make measurementPointsAndNodes
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
latDynaMesh = 0:0.02:2;
eleDynaMesh = -.6:0.02:0;
depthDynaMesh = -9:0.025:0;

[eleGridOrig, latGridOrig, depthGridOrig] = ndgrid(ele, lat, depth);
[eleGrid, latGrid, depthGrid] = ndgrid(eleDynaMesh, latDynaMesh, depthDynaMesh);
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

%% other field parameters (mostly hard-coded for c52)
FIELD_PARAMS.Frequency = 2.36;           % MHz
FIELD_PARAMS.Transducer = 'c52';    
FIELD_PARAMS.alpha = attenuation;               % dB/cm/MHz
FIELD_PARAMS.Fnum = 3.5;     
FIELD_PARAMS.soundSpeed = 1540;          % m/s
FIELD_PARAMS.samplingFrequency = 5e9/10; % Hz (?) from try3d_kzk_sim.m
FIELD_PARAMS.focus = [0 0 0.070];        % m
FIELD_PARAMS.Impulse = 'gaussian';       % won't be used
%% save to dyna file
%eval(sprintf('save dyna-kzk-f%.2f-F%.1f-FD%.3f-a%.2f.mat intensity FIELD_PARAMS',...
%             FIELD_PARAMS.Frequency,FIELD_PARAMS.Fnum,FIELD_PARAMS.focus(3),...
%             FIELD_PARAMS.alpha));
save dyna-kzk.mat









