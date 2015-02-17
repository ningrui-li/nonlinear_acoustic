clear; clf;

nln = 10; % ASCII char for new line (used for multi-line titles when plotting)

%% Estimate expt measured pressure waveform parameters
% Loading experimentally measured face pressure input (C5-2, 70mm)
% This was massaged into quarter symmetric form. See /face_pressure/focus70mm/ 
% of this repository for more info on how this was done.
load /luscinia/nl91/lab/nonlinearity/focus70mm/pressure_waveforms_median_qsymmetric_single_precision_interpolated_axes.mat

% Count # of peaks in expt pressure data to get number of excitation cycles.
centerEleAxis = round(length(ele)/2);
centerLatAxis = round(length(lat)/2);
t = t * 1e6; % seconds to microseconds

% pressure contains all of the pressure data on the transducer plane
% through time. Dimensions are time x lateral position x elevational
% position.
figure(1)
plot(squeeze(pressure(:, centerLatAxis, centerEleAxis)), 'k-')
xlabel('Time (\mus)')
ylabel('Pressure')
title(['Experimentally Measured Face Pressure vs. Time', nln,...
       '(ele = 0mm, lat = 0mm, C5-2, 70 mm Focus)'])
print -dpng c52_70mm_pressure_vs_time_centertrace.png

% From this center trace figure, it appears that there are 7 peaks 
% corresponding to 7 excitation cycles. The excitation waveform consists of
% approximately 1500 samples.
numExcitationCycles = 7;
numSamples = 1500;
% We can also note that the period between peaks is approximately 0.42
% microseconds, corresponding to about a 2.36 MHz excitation frequency.

%% Create pressure waveform
% Create sinusoidal excitation wave
f0 = 2.36e6; % excitation frequency (Hz)
% Let time vector be 7 cycles w/ 1500 samples, just like in expt measured
% data.
t_wave = linspace(0, numExcitationCycles/f0, numSamples); % time vector (s)
excitation = sin(2*pi*f0*t_wave);

% Define C5-2 impulse response using defineImpResp in FEM tools
addpath /luscinia/nl91/matlab/fem/field/
centerFrequency = 3.0e6;
fractionalBandwidth = 0.7;

% use sampling rate of time data of expt measured KZK inputs (Hz)
FIELD_PARAMS.samplingFrequency = 1/((t(2)-t(1))*1e-6); 
FIELD_PARAMS.Impulse = 'gaussian'; % assume Gaussian weighted impulse
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

print -dpng c52_70mm_synthetic_press_wave.png

%% Get locations of each element using Field II
% Get transducer handle using c5-2 probe parameters in probes repository.
addpath /luscinia/nl91/matlab/fem/probes/fem/ % for define c52 function
addpath /luscinia/nl91/matlab/Field_II/
check_start_Field_II;

% See /nonlinear_acoustic/field/field_c52_70mm/ for info on how Fnum was
% estimated.
FIELD_PARAMS.focus = [0 0 0.070];
FIELD_PARAMS.Fnum = 3.5;

Th = c52(FIELD_PARAMS);

% See pdf pages 31-32 of Field II user's guide for info on contents of 
% c52_data and c52_time_delays.
% http://field-ii.dk/documents/users_guide.pdf

c52_data = xdc_get(Th, 'rect');      % matrix containing lots of parameters 
                                     % of each element
                                      
phys_elem_pos = c52_data(24:26, :);   % Get submatrix containing physical 
                                     % element locations only
phys_elem_pos = unique(phys_elem_pos', 'rows'); % Remove repeated locations.
phys_elem_pos = phys_elem_pos * 1e3;   % convert m to mm

math_elem_pos = c52_data(8:10, :);    % Get submatrix containing physical 
                                     % element locations only. (Ignore axial)
math_elem_pos = math_elem_pos';
math_elem_pos = math_elem_pos * 1e3;   % convert m to mm

%% Find 'lat' and 'ele' indices corresponding to element locations
% Find range of nonzero lateral position indices in which to put pressure
% waveform
minLatPosition = min(math_elem_pos(:, 1));
minLatPosition = round(minLatPosition, 1);
% needs to have even tenth's place b/c lat sweeps in 0.2 mm intervals
if (mod(minLatPosition, 0.2) ~= 0)
    minLatPosition = minLatPosition + 0.1;
end

maxLatPosition = max(math_elem_pos(:, 1));
maxLatPosition = round(maxLatPosition, 1);
% needs to have even tenth's place b/c lat sweeps in 0.2 mm intervals
if (mod(maxLatPosition, 0.2) ~= 0)
    maxLatPosition = maxLatPosition - 0.1;
end

latMinIndex = find(lat==minLatPosition); 
latMaxIndex = find(lat==maxLatPosition); 

% Find range of nonzero elevational position indices in which to put pressure
% waveform
minElePosition = min(math_elem_pos(:, 2));
minElePosition = round(minElePosition, 1);
% needs to have even tenth's place b/c ele sweeps in 0.2 mm intervals
if (mod(minLatPosition, 0.2) ~= 0)
    minElePosition = minElePosition + 0.1;
end

maxElePosition = max(math_elem_pos(:, 2));
maxElePosition = round(maxElePosition, 1);
% needs to have even tenth's place b/c ele sweeps in 0.2 mm intervals
if (mod(maxLatPosition, 0.2) ~= 0)
    maxElePosition = maxElePosition - 0.1;
end

eleMinIndex = find(ele==minElePosition);
eleMaxIndex = find(ele==maxElePosition);

%% Get time delays in terms of indices corresponding to each plane position 
c52_time_delays = xdc_get(Th, 'focus'); % vector containing time delays of
                                        % each physical element
c52_time_delays = c52_time_delays(2:end); % remove first index
c52_phys_elem_lat = phys_elem_pos(:, 1);
c52_interp_lat_positions = lat(latMinIndex:latMaxIndex);
c52_interp_time_delays = interp1(c52_phys_elem_lat, c52_time_delays,...
                                 c52_interp_lat_positions, 'linear');
                             
% Hard-coding is bad, but I probably won't use this code again... :(
c52_interp_time_delays(1) = c52_time_delays(1);
c52_interp_time_delays(2) = c52_time_delays(1);

c52_interp_time_delays(end) = c52_time_delays(end);
c52_interp_time_delays(end-1) = c52_time_delays(end);

% convert from seconds to time indices
c52_interp_time_delays = round(c52_interp_time_delays*FIELD_PARAMS.samplingFrequency);
                                              
% apply time delays across pressure input matrix
pressure_field_time_delays = zeros(length(lat), length(ele));
eleRange = eleMinIndex:eleMaxIndex;
for latIndex = latMinIndex:latMaxIndex
    pressure_field_time_delays(latIndex, eleRange) = c52_interp_time_delays(latIndex-latMinIndex+1);
end

%% interpolating intensity values to correspond to a mesh of uniform size
[eleGridInterp, latGridInterp] = ndgrid(ele, lat);
depth_field = griddata(math_elem_pos(:, 2), math_elem_pos(:, 1), math_elem_pos(:, 3),...
                       eleGridInterp, latGridInterp, 'linear');
                   
 % small correction here b/c griddata causes discontinuous z-values at
% lateral positions of +/- 5.2 mm. Just interpolate using the +/- 5.0 mm
% z-values. 
depth_field(:, latMinIndex) = depth_field(:, latMinIndex+1);
depth_field(:, latMaxIndex) = depth_field(:, latMaxIndex-1);          

depth_field(isnan(depth_field)) = 0; % Set NaN vals to 0.
depth_field = depth_field * 1e-3; % mm to m
depth_field = depth_field'; % change dimensions to be lat x ele

soundSpeed = 1540; % m/s
% convert depth values to a time delay based on sound speed.
depth_time_delay = depth_field ./ soundSpeed; 
% convert time delay into time indices delay based on sampling rate     
depth_time_delay = depth_time_delay * FIELD_PARAMS.samplingFrequency;                                     
depth_time_delay = round(depth_time_delay);
% negate depth_field values because a more negative depth means that the
% signal will occur later in time, so the pressure signals from that
% location need to be shifted forward.
depth_time_delay = -depth_time_delay;

% start_time_ind is the time index when the pressure wave at that
% locations begins. It is based on the actual element time delay
% (from pressure_field_time_delays) as well as the delay due to
% transducer geometry (from depth_time_delay).
pressure_field_time_delays = pressure_field_time_delays + depth_time_delay;

% C5-2 is a curvilinear probe, so elements away from the center of the
% probe are further from the focus. Thus, center elements need to be
% slightly delayed compared to side elements in order to beam form.

% Add pressure waveforms uniformly at those locations without time delays
pressure_field_ii = zeros(size(pressure));
init_time_ind = 3100;      % time index at which pressure waveform starts
for latInd = latMinIndex:latMaxIndex
    for eleInd = eleMinIndex:eleMaxIndex
        start_time_ind = init_time_ind + pressure_field_time_delays(latInd, eleInd);
        end_time_ind = start_time_ind + length(pwave)-1;
        pressure_field_ii(start_time_ind:end_time_ind, latInd, eleInd) = pwave;
    end
end

% Calculate intensity plane
c52_intensity_plane = zeros(length(lat), length(ele));
for latInd = 1:length(lat)
    for eleInd = 1:length(ele)
        c52_intensity_plane(latInd, eleInd) = sumsqr(pressure_field_ii(:, latInd, eleInd));
    end
end

pressure = pressure_field_ii;

save field_ii_c52_70mm_pressure_input.mat ele lat t pressure

%% Time delay plots
figure(3)
plot(1e6*c52_time_delays, 'k.'); % plot w/ time delays in microseconds
title('C5-2 Element Time Delays')
xlabel('Physical Element Number')
ylabel('Time Delay (\mus)')
xlim([1 length(c52_time_delays)])

print -dpng c52_70mm_phys_elem_time_delays.png

figure(4)
imagesc(lat, ele, pressure_field_time_delays')
title(['Field II' nln 'Pressure Input Time Delays'])
xlabel('Lateral Position (mm)')
ylabel('Elevational Position (mm)')
axis([min(lat) max(lat) min(ele) max(ele)]) % expt measured pressure data axis limits
colorbar

print -dpng c52_70mm_press_field_time_delays.png

%% Elem locations and intensity plot
% Physical and mathematical element locations (w/o looking at depth)
figure(5)
plot(phys_elem_pos(:, 1), phys_elem_pos(:, 2), 'b.')
hold on
plot(math_elem_pos(:, 1), math_elem_pos(:, 2), 'rx')
hold off
title(['Field II' nln 'Physical and Mathematical Element Center Locations'])
xlabel('Lateral Position (mm)')
ylabel('Elevational Position (mm)')
axis([min(lat) max(lat) min(ele) max(ele)]) % expt measured pressure data axis limits
legend('Physical Elements', 'Mathematical Elements', 0)

print -dpng c52_70mm_phys_math_elem_locs.png

% Intensity plot
figure(6)
imagesc(lat, ele, c52_intensity_plane')
title(['Field II' nln 'Pressure Input Intensity Plane'])
xlabel('Lateral Position (mm)')
ylabel('Elevational Position (mm)')
axis([min(lat) max(lat) min(ele) max(ele)]) % expt measured pressure data axis limits

print -dpng c52_70mm_intensity_plane.png

% Mathematical element locations (both interp and non-interp)
figure(7)
subplot(2, 1, 1)
scatter3(math_elem_pos(:, 1), math_elem_pos(:, 2),  math_elem_pos(:, 3))
title(['Field II' nln 'Mathematical Element Locations'])
xlabel('Lateral Position (mm)')
ylabel('Elevational Position (mm)')

subplot(2, 1, 2)
imagesc(lat, ele, depth_field')
title(['Field II' nln 'Grid Interpolated Mathematical Element Locations'])
xlabel('Lateral Position (mm)')
ylabel('Elevational Position (mm)')
colorbar

print -dpng c52_70mm_interp_elem_locations.png