function [] = kzk_make_loads(intensityFile, eleVol)
%%
% Function for inputting parameters to makeLoadsTemps from KZK simulated
% intensity fields.
% INPUTS:
% intensityFile - location and name of intensity file formatted like the
% output of field2dyna.m
% eleVol - volume of each element (cm^3)

%% load data stuff. add path stuff.
addpath /home/mlp6/git/fem/field/

load(intensityFile)
%% create inputs to makeLoadsTemps
% use max(intensity) as IsppaNorm (not sure if this is right)
IsppaNorm = max(intensity);

% pulse duration from /luscinia/kah67/102113_Verasonics_measurements/...
% 20131018/focus30/11pwr/p0p0mm/pressure_waveforms_median
pulseDuration = 20; % microseconds

% volumetric specific heat of water 
% assume room temperature (25 C)
% http://en.wikipedia.org/wiki/Heat_capacity#Table_of_specific_heat_capacities
cv = 4.1760;        % (J/cm^3/C)   

% scale down intensities
%intensity = intensity;
%% call to makeLoadsTemps
makeLoadsTemps(intensityFile, intensityFile, IsppaNorm, pulseDuration,...
               cv, eleVol, 'q', 1);