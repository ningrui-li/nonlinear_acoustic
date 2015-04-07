clear; clf;

%% load data stuff. add path stuff.
addpath /luscinia/nl91/matlab/fem/field
addpath /luscinia/nl91/scratch/c52/focus30mm/original/
load dyna-kzk-f2.36-F2.6-FD0.030-a0.45.mat

%% create inputs to makeLoadsTemps
% use max(intensity) as IsppaNorm (not sure if this is right)
IsppaNorm = max(intensity);

% name of fake dyna file
intensityFile = 'dyna-kzk-f2.36-F2.6-FD0.030-a0.45.mat'; 

% pulse duration from /luscinia/kah67/102113_Verasonics_measurements/...
% 20131018/focus30/11pwr/p0p0mm/pressure_waveforms_median
pulseDuration = 20; % microseconds

% volumetric specific heat of water 
% assume room temperature (25 C)
% http://en.wikipedia.org/wiki/Heat_capacity#Table_of_specific_heat_capacities
cv = 4.1760;        % (J/cm^3/C)   

% element volume (cm^3)
% from same data as pulseDuration
eleVol = .2*.2*.5;  % cm^3
%% call to makeLoadsTemps
makeLoadsTemps(intensityFile, intensityFile, IsppaNorm, pulseDuration,...
               cv, eleVol, 'h', 1);