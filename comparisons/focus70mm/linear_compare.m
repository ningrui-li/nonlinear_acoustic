clear; clf;

addpath ../metrics/

%% Field II and KZK (linear) sim comparisons - 70 mm focus

% Field
fprintf('Field II:\n')
load /luscinia/nl91/nonlinear_acoustic/field/field_c52_70mm/dyna-I-f2.36-F3.5-FD0.070-a0.45.mat
field_ele = -1.2:0.02:0;
field_lat = 0:0.02:2.0;
field_depth = 0:0.05:9.0;

intensity_field_70mm = reshape(intensity, 61, 101, 181);
intensity_field_70mm = flip(intensity_field_70mm, 3);
intensity_field_70mm = intensity_field_70mm ./ max(intensity_field_70mm(:));
intensity_field_70mm_depth = field_depth;

% Getting location of max intensity
[maxEle, maxLat, maxDepth] = intensitypeak(intensity_field_70mm, field_ele, ...
                                           field_lat, field_depth);
fprintf(['The maximum intensity occurs at %.2f cm in elevation position, '...
         '%.2f cm in lateral position, and %.2f cm in depth position.\n'],...
         maxEle, maxLat, maxDepth)         
fprintf('\n')

% KZK
fprintf('Linear KZK:\n')
load /luscinia/nl91/scratch/c52/focus70mm/quarter_symmetric/c52_70mm_qsymmetric_intensity_vals_linear.mat

% cut data to just quarter of all values, since it is quarter symmetric
kzk_ele = ele(1:(floor(length(ele)/2)+1));
kzk_lat = lat((floor(length(lat)/2)+1):end);
kzk_depth = depthStep;
% mm to cm
kzk_ele = kzk_ele./10;
kzk_lat = kzk_lat./10;
kzk_depth = kzk_depth./10;

intensity_kzk_70mm = permute(intensity, [3 2 1]);
intensity_kzk_70mm = intensity_kzk_70mm(1:length(kzk_ele), length(kzk_lat):end, :);
intensity_kzk_70mm = intensity_kzk_70mm ./ max(intensity_kzk_70mm(:));
intensity_kzk_70mm_depth = kzk_depth;

% Calculating location of max intensity
[maxEle, maxLat, maxDepth] = intensitypeak(intensity_kzk_70mm, kzk_ele, ...
                                           kzk_lat, kzk_depth);
fprintf(['The maximum intensity occurs at %.2f cm in elevation position, '...
         '%.2f cm in lateral position, and %.2f cm in depth position.\n'],...
         maxEle, maxLat, maxDepth)
fprintf('\n')     