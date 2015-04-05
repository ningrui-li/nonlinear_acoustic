%% estimate_fnum_70mm
% This script is used to generate a plot from which the F/# can be
% estimated from the initial pressure data measured using a hydrophone.
% The F/# will be used as a parameter in the 70 mm focus Field II 
% Simulation.

clear; clf;

load /luscinia/nl91/scratch/c52/focus70mm/quarter_symmetric/c52_70mm_qsymmetric_intensity_vals_linear.mat
% re-order intensity matrix to match Field II dimensions
intensity = permute(intensity, [3 2 1]);
lat = lat/10;  % conversion from mm to cm
ele = ele/10;

focalDepth = 7; % cm

% this is the intensity plane closest to the transducer face.
intensity_transducer_plane = squeeze(intensity(:, :, 1));
figure(1)
imagesc(lat, ele, intensity_transducer_plane);
xlabel('Lateral Position (cm)')
ylabel('Elevational Position (cm)')
title('Intensity Field at Depth = 0 cm Plane, C5-2, 70mm Focal Depth')
print -dpng estimate_fnum_c52_70mm.png

% aperture width estimated by eye  
apertureWidth = 2; % cm
Fnum = roundn(focalDepth/apertureWidth, -1);
fprintf('F/# is approximately %.1f.\n', Fnum)
