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

%% Create pressure waveform
% Create sinusoidal excitation wave
f0 = 2.36e6;                   % excitation frequency (Hz)
t = linspace(0, 7/f0, 10000);  % time vector (s)
excitation = sin(2*pi*f0*t);

% Define C5-2 impulse response
addpath /luscinia/nl91/matlab/fem/field/
centerFrequency = 3.0e6;
fractionalBandwidth = 0.7;
FIELD_PARAMS.samplingFrequency = 0.5e9; % required inputs for calculating impulse
FIELD_PARAMS.Impulse = 'gaussian';      % response using defineImpResp.m       
c52_imp_resp = defineImpResp(fractionalBandwidth, centerFrequency, FIELD_PARAMS);
t_c52_imp_resp = [1:length(c52_imp_resp)] * (1/FIELD_PARAMS.samplingFrequency);

% Get pressure waveform by convolving excitation wave w/ imp response
pwave = conv(excitation, c52_imp_resp);
t_pwave = [1:length(pwave)] * (.1/FIELD_PARAMS.samplingFrequency);
%% Plot excitation wave + impulse response for error-checking
% Excitation wave
figure(2)
subplot(3, 1, 1)
plot(t, excitation, 'k-')
xlabel('Time (s)')
ylabel('Voltage')
title('2.36 MHz Excitation Wave w/ 7 Cycles')

% C5-2 Gaussian impulse response
subplot(3, 1, 2)
plot(t_c52_imp_resp, c52_imp_resp, 'k-')
xlabel('Time (s)')
ylabel('Voltage')
title('C5-2 Gaussian Impulse Response')

% Pressure waveform at each element
subplot(3, 1, 3)
plot(t_pwave, pwave, 'k-')
title('C5-2 Pressure Waveform')
ylabel('Pressure')
xlabel('Time (s)')