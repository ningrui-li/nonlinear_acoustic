clear; clf;

nln = 10; % ASCII value for new line
 
atten = '0.005'; % dB/cm/MHz
fprintf('attenuation = %s dB/cm/MHz\n', atten)

% Linear KZK
fprintf('Linear KZK:\n')
load(sprintf(['/luscinia/nl91/nonlinear_acoustic/kzk/field_ii_c52_focus70mm/B_0/',...
     'a_%s_B_0/c52_70mm_intensity_field_field_ii_pressure_input.mat'], atten));

% mm to cm
ele = ele./10;
lat = lat./10;
depth = depth./10;
  
intensity_kzk_B0_70mm = intensity ./ max(intensity(:));
 
% KZK, B = 3.5
fprintf('KZK, B = 3.5:\n')
load(sprintf(['/luscinia/nl91/nonlinear_acoustic/kzk/field_ii_c52_focus70mm/B_3.5/',...
     'a_%s_B_3.5/c52_70mm_intensity_field_field_ii_pressure_input.mat'], atten));
                 
intensity_kzk_B35_70mm = intensity ./ max(intensity(:));       
        
%% Difference plot
addpath /luscinia/nl91/nonlinear_acoustic/kzk/intensity_field_functions/
% B=3.5 vs. linear
% should be made into a function.
intensity_diff = intensity_kzk_B35_70mm-intensity_kzk_B0_70mm;

create_vtk(intensity_diff, lat, ele, depth, 'c52_70mm_diff_a_0.005_B_3.5.vts')