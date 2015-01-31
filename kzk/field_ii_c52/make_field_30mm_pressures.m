clear; clf;

nln = 10; % ASCII char for new line (used for multi-line titles when plotting)

% Experimentally measured face pressure input (C5-2, 30mm)
%   - Massaged into quarter symmetric form -> see /face_pressure/focus30mm/ 
%     of this repository for more info on how this was done.
load /luscinia/nl91/lab/nonlinearity/focus30mm/pressure_waveforms_median_qsymmetric_single_precision_interpolated_axes.mat

% Count # of peaks in expt pressure data to get number of excitation cycles.
centerEleAxis = round(length(ele)/2);
centerLatAxis = round(length(lat)/2);
t = t * 1e6; % seconds to microseconds

% pressure contains all of the pressure data on the transducer plane
% through time. Dimensions are time x lateral position x elevational
% position.
figure(1)
plot(t, squeeze(pressure(:, centerLatAxis, centerEleAxis)), 'k-')
xlabel('Time (\mus)')
ylabel('Pressure')
title(['Experimentally Measured Face Pressure vs. Time', nln,...
       '(ele = 0mm, lat = 0mm, C5-2, 30 mm Focus)'])
print -dpng c52_30mm_pressure_vs_time_centertrace.png

% From this center trace figure, it appears that there are 7 peaks 
% corresponding to 7 excitation cycles.
% We can also note that the period between peaks is approximately 0.42
% microseconds, corresponding to about a 2.36 MHz excitation frequency.

