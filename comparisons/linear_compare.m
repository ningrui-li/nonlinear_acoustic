clear; clf;

addpath ../metrics/

%% Field II and KZK (linear) sim comparisons - 30 mm focus

% Field
fprintf('Field II:\n')
load /luscinia/nl91/nonlinear_acoustic/field/field_c52_30mm/dyna-I-f2.36-F2.8-FD0.030-a0.45.mat
field_ele = -1:0.02:0;
field_lat = 0:0.02:1.2;
field_depth = 0:0.05:5.2;

intensity_field_30mm = reshape(intensity, 51, 61, 105);
intensity_field_30mm = flip(intensity_field_30mm, 3);
intensity_field_30mm = intensity_field_30mm ./ max(intensity_field_30mm(:));
intensity_field_30mm_depth = field_depth;

% Getting location of max intensity
[maxEle, maxLat, maxDepth] = ind2sub(size(intensity_field_30mm),...
                               find(intensity_field_30mm == max(intensity_field_30mm(:))));
                           
fprintf(['The maximum intensity occurs at %.2f cm in elevation position, '...
         '%.2f cm in lateral position, and %.2f cm in depth position.\n'],...
         field_ele(maxEle), field_lat(maxLat), field_depth(maxDepth))         
fprintf('\n')

% KZK
fprintf('Linear KZK:\n')
load /luscinia/nl91/scratch/c52/focus30mm/quarter_symmetric/c52_intensity_vals_30_qsymm_intensity.mat

% cut data to just quarter of all values, since it is quarter symmetric
kzk_ele = ele(1:(floor(length(ele)/2)+1));
kzk_lat = lat((floor(length(lat)/2)+1):end);
kzk_depth = depthStep;
% mm to cm
kzk_ele = kzk_ele./10;
kzk_lat = kzk_lat./10;
kzk_depth = kzk_depth./10;

intensity_kzk_30mm = permute(intensity, [3 2 1]);
intensity_kzk_30mm = intensity_kzk_30mm(1:length(kzk_ele), length(kzk_lat):end, :);
intensity_kzk_30mm = intensity_kzk_30mm ./ max(intensity_kzk_30mm(:));
intensity_kzk_30mm_depth = kzk_depth;

% Calculating location of max intensity

[maxEle, maxLat, maxDepth] = ind2sub(size(intensity_kzk_30mm),...
                               find(intensity_kzk_30mm == max(intensity_kzk_30mm(:))));
                           
fprintf(['The maximum intensity occurs at %.2f cm in elevation position, '...
         '%.2f cm in lateral position, and %.2f cm in depth position.\n'],...
         kzk_ele(maxEle), kzk_lat(maxLat), kzk_depth(maxDepth))
fprintf('\n')     
figure(1)
subplot(2, 1, 1)
imagesc(squeeze(intensity_field_30mm(end, :, :))')
subplot(2, 1, 2)
imagesc(squeeze(intensity_kzk_30mm(end, :, :))')

%% center trace plot
figure(2)
centertrace('field_kzk_centertrace_c52_30mm.png', 'Field vs. KZK Center Trace - C5-2, 30 mm Focus',...
            intensity_field_30mm, intensity_field_30mm_depth, 'Field II, C5-2, 30 mm Focus',...
            intensity_kzk_30mm, intensity_kzk_30mm_depth, 'KZK, C5-2, 30 mm Focus')
%% KZK contour plots
% contour plot in elevation-lateral plane at various depths
figure(3);
contourplots('kzk_30mm_depth.png', 'KZK, 30 mm Focus - Depth Plane',...
              intensity_kzk_30mm, kzk_ele, kzk_lat, kzk_depth, 3, [51 61 71], [0 0.15 -.5 0]);


% contour plot in depth-elevation plane at various lateral positions
figure(4);
contourplots('kzk_30mm_lateral.png', 'KZK, 30 mm Focus - Lateral Plane', ...
             intensity_kzk_30mm, kzk_ele, kzk_lat, kzk_depth, 2, [1 5 9], [-.51 0 0 5.2]);


% contour plot in depth-lateral plane at various elevational positions
figure(5);
contourplots('kzk_30mm_elevational.png', 'KZK, 30 mm Focus - Elevational Plane', ...
             intensity_kzk_30mm, kzk_ele, kzk_lat, kzk_depth, 1, [43 47 51], [0 .35 0 5.2]);  

% %% Field II contour plots
% figure(6);
% contourplots('field2_30mm_depth.png', 'Field II, 30 mm Focus - Depth Plane', ...
           
