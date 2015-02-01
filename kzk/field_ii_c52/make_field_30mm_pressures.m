clear; clf;

nln = 10; % ASCII char for new line (used for multi-line titles when plotting)

%% Estimate expt measured pressure waveform parameters
% Loading experimentally measured face pressure input (C5-2, 30mm)
% This was massaged into quarter symmetric form. See /face_pressure/focus30mm/ 
% of this repository for more info on how this was done.
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
% corresponding to 7 excitation cycles. The excitation waveform consists of
% approximately 1500 samples.
numExcitationCycles = 7;
numSamples = 1500;
% We can also note that the period between peaks is approximately 0.42
% microseconds, corresponding to about a 2.36 MHz excitation frequency.

%% Create pressure waveform
% Create sinusoidal excitation wave
f0 = 2.36e6;                   % excitation frequency (Hz)
% Let time vector be 7 cycles w/ 1500 samples, just like in expt measured
% data.
t_wave = linspace(0, numExcitationCycles/f0, numSamples);  % time vector (s)
excitation = sin(2*pi*f0*t_wave);

% Define C5-2 impulse response using defineImpResp in FEM tools
addpath /luscinia/nl91/matlab/fem/field/
centerFrequency = 3.0e6;
fractionalBandwidth = 0.7;
FIELD_PARAMS.samplingFrequency = 1/((t(2)-t(1))*1e-6); % use sampling rate of 
                                                       % time data of expt
                                                       % measured KZK
                                                       % inputs (Hz)
FIELD_PARAMS.Impulse = 'gaussian';        % assume Gaussian weighted impulse
c52_imp_resp = defineImpResp(fractionalBandwidth, centerFrequency, FIELD_PARAMS);
t_c52_imp_resp = (1:length(c52_imp_resp)) * (1/FIELD_PARAMS.samplingFrequency);

% Get pressure waveform by convolving excitation wave w/ imp response
pwave = conv(excitation, c52_imp_resp);
t_pwave = (1:length(pwave)) * (1/FIELD_PARAMS.samplingFrequency);

%% Plot excitation wave + impulse response for error-checking
% Excitation wave
figure(2)
subplot(3, 1, 1)
plot(t_wave, excitation, 'k-')
xlabel('Time (s)')
ylabel('Voltage')
title('2.36 MHz Excitation Wave w/ 7 Cycles')

% C5-2 Gaussian impulse response
subplot(3, 1, 2)
plot(t_c52_imp_resp, c52_imp_resp, 'k-')
xlabel('Time (s)')
ylabel('Voltage')
title('C5-2 Gaussian Impulse Response')
xlim([0 max(t_c52_imp_resp)])

% Pressure waveform at each element
subplot(3, 1, 3)
plot(t_pwave, pwave, 'k-')
title('C5-2 Pressure Waveform')
ylabel('Pressure')
xlabel('Time (s)')
xlim([0 max(t_pwave)])

print -dpng c52_30mm_synthetic_press_wave.png

%% Get time delays of each element using Field II
% Get transducer handle using c5-2 probe parameters in probes repository.
addpath /luscinia/nl91/matlab/fem/probes/fem/ % for define c52 function
addpath /luscinia/nl91/matlab/Field_II/
check_start_Field_II;

% See /nonlinear_acoustic/field_field_c52_30mm/ for info on how Fnum was
% estimated.
FIELD_PARAMS.focus = [0 0 0.030];
FIELD_PARAMS.Fnum = 2.8;

Th = c52(FIELD_PARAMS);

% See pdf pages 31-32 of Field II user's guide for info on contents of 
% c52_data and c52_time_delays.
% http://field-ii.dk/documents/users_guide.pdf

c52_data = xdc_get(Th, 'rect');      % matrix containing lots of parameters 
                                     % of each element
                                      
phys_ele_pos = c52_data(24:26, :);   % Get submatrix containing physical 
                                     % element locations only
phys_ele_pos = unique(phys_ele_pos', 'rows'); % Remove repeated locations.
phys_ele_pos = phys_ele_pos * 1e3;   % convert m to mm

math_ele_pos = c52_data(8:10, :);    % Get submatrix containing physical 
                                     % element locations only. (Ignore axial)
math_ele_pos = unique(math_ele_pos', 'rows'); % Remove repeated locations.
math_ele_pos = math_ele_pos * 1e3;   % convert m to mm

figure(3)
plot(phys_ele_pos(:, 1), phys_ele_pos(:, 2), 'b.')
hold on
plot(math_ele_pos(:, 1), math_ele_pos(:, 2), 'rx')
title('Field II - Physical and Mathematical Element Center Locations')
xlabel('Lateral Position (mm)')
ylabel('Elevational Position (mm)')
axis([-12 12 -10 10]) % expt measured pressure data axis limits

c52_time_delays = xdc_get(Th, 'focus'); % vector containing time delays of
                                        % each physical element

figure(4)
plot(1e6*c52_time_delays(2:end), 'k-'); % plot w/ time delays in microseconds
title('C5-2 Element Time Delays')
xlabel('Physical Element Number')
ylabel('Time Delay (\mus)')
xlim([1 length(c52_time_delays(2:end))])

% C5-2 is a curvilinear probe, so elements away from the center of the
% probe are further from the focus. Thus, center elements need to be
% slightly delayed compared to side elements in order to beam form.
