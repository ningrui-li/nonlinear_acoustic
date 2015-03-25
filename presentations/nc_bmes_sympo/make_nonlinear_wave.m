%% make_nonlinear_wave.m
% Quick script for making a plot of a nonlinear acoustic wave propagating
% as a function of time using raw data from the KZK sims.
clear; clf;

% functions for getting pressure wave propagating through axial planes.
addpath /luscinia/kah67/Nonlinear_Sims/3DSims/3d_functions
addpath /luscinia/kah67/102113_Verasonics_measurements/routines

% get position vector data
load /luscinia/kah67/102113_Verasonics_measurements/20131018/focus70/11pwr/p0p0mm/pressure_waveforms_median

numLatSteps = length(lat);
numEleSteps = length(ele);
numTimeSteps = length(t);

% chosen depth plane = 71 -> corresponds to depth of 70*.05cm = 3.55cm
% subtract one from 71 to convert from 1-based index to 0-based index.
depth_index = 70;
pout = readGenoutSlice(['/luscinia/nl91/nonlinear_acoustic/kzk',...
                        '/field_ii_c52_focus70mm/B_3.5/a_0.3_B_3.5/P.dat'],...
                        depth_index,numLatSteps*numEleSteps*numTimeSteps);

% reshape pout matrix and create plot
pout = reshape(pout, numTimeSteps, numLatSteps, numEleSteps);

t = t*1e6; % s to us
pout = pout*1e-6; % Pa to MPa

figure(1)
plot(t, squeeze(pout(:, round(numLatSteps/2), round(numEleSteps/2))), 'k-')
axis([7 9 min(pout(:)) max(pout(:))])
xlabel('Time (\mus)', 'FontSize', 14)
ylabel('Pressure (MPa)', 'FontSize', 14)
title(['Nonlinear Acoustic Wave (\alpha = 0.3 dB/cm/MHz, \beta = 3.5)'], 'FontSize', 14)

print -dpng nonlinear_wave_through_time.png