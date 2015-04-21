%% run_calc_sws.m
% Calculates shear wave speeds at various depths for KZK sims run with
% various combinations of attenuation and nonlinear coefficient values.

clear; clf;
close all;
addpath /luscinia/nl91/nonlinear_acoustic/sws/

% change to sws estimation plot folder before running script
cd sws_ttp_plots

a = [0.005 0.3 0.45 1.0 1.5];
B = [0 3.5 7];

sws = zeros(length(a), length(B));
a_count = 1;
B_count = 1;
for alpha = a
    for beta = B
        sws(a_count, B_count) = calc_sws(alpha, beta, 281);
        B_count = B_count + 1;
    end
    a_count = a_count + 1;
end

cd ..