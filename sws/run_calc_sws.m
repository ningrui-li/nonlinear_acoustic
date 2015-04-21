%% run_calc_sws.m
% Calculates shear wave speeds at various depths for KZK sims run with
% various combinations of attenuation and nonlinear coefficient values.

clear; clf;
close all;
%a = [0.005 0.3 0.45 1.0 1.5];
%B = [0 3.5 7];

a = 0.005;
B = 0;

for alpha = a
    for beta = B
        sws = calc_sws(alpha, beta, 281);
    end
end