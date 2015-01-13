%% estimate_fnum_30mm
% This script is used to generate a plot from which the F/# can be
% estimated from the initial pressure data measured using a hydrophone.
% The F/# will be used as a parameter in the 30 mm focus Field II 
% Simulation.

clear; clf;

load /luscinia/nl91/scratch/c52/focus30mm/quarter_symmetric/c52_intensity_vals_30_qsymm_intensity.mat
% re-order intensity matrix to match Field II dimensions
intensity = permute(intensity, [3 2 1]);
lat = lat/10;  % conversion from mm to cm
ele = ele/10;

focalDepth = 3; % cm

% this is the intensity plane closest to the transducer face.
intensity_transducer_plane = squeeze(intensity(:, :, 1));
figure(1)
imagesc(lat, ele, intensity_transducer_plane);
xlabel('Lateral Position (cm)')
ylabel('Elevational Position (cm)')
title('Intensity Field at Depth = 0 cm Plane, C5-2, 30mm Focal Depth')
print -dpng estimate_fnum_c52_30mm.png

% aperture width estimated by eye  
apertureWidth = 1.08; % cm
Fnum = roundn(focalDepth/apertureWidth, -1);
fprintf('F/# is approximately %.1f.\n', Fnum)