%% make_loads_script
% Example script for calling kzk_make_loads to create the loads file from
% the intensity fields.
clear; clf;

element_vol = .25*.25*.25;
kzk_make_loads('/luscinia/nl91/nonlinear_acoustic/dyna/', element_vol);