clear; clf;

addpath ../../../metrics/

%% Extreme (alpha = 0.1 dB/cm/MHz, beta = 10, amplitude 4e7) vs.
%  Linear (alpha = 0.45 dB/cm/MHz, beta = 0, amplitude 4e5) comparisons

% Linear KZK
fprintf('Linear KZK:\n')
load /luscinia/nl91/nonlinear_acoustic/kzk/field_ii_c52_focus30mm/B_10/a_0.1_B_10/c52_30mm_intensity_field_ii_pressure_input.mat
% cut data to just quarter of all values, since it is quarter symmetric
kzk_ele = ele(1:(floor(length(ele)/2)+1));
kzk_lat = lat((floor(length(lat)/2)+1):end);
kzk_depth = depth;
% mm to cm
kzk_ele = kzk_ele./10;
kzk_lat = kzk_lat./10;
kzk_depth = kzk_depth./10;

intensity_linear_30mm = permute(intensity, [3 2 1]);
intensity_linear_30mm = intensity_linear_30mm(1:length(kzk_ele), length(kzk_lat):end, :);
intensity_linear_30mm = intensity_linear_30mm ./ max(intensity_linear_30mm(:));
intensity_kzk_30mm_depth = kzk_depth;

% Getting location of max intensity
[maxEle, maxLat, maxDepth] = intensitypeak(intensity_linear_30mm, kzk_ele, ...
                                           kzk_lat, kzk_depth);
fprintf(['The maximum intensity occurs at %.2f cm in elevation position, '...
         '%.2f cm in lateral position, and %.2f cm in depth position.\n'],...
         maxEle, maxLat, maxDepth)         
fprintf('\n')

% Extreme KZK
fprintf('Extreme KZK:\n')
load /luscinia/nl91/nonlinear_acoustic/kzk/field_ii_c52_focus30mm/B_0/a_0.45_B_0/c52_30mm_intensity_field_field_ii_pressure_input.mat

intensity_xtreme_30mm = permute(intensity, [3 2 1]);
intensity_xtreme_30mm = intensity_xtreme_30mm(1:length(kzk_ele), length(kzk_lat):end, :);
intensity_xtreme_30mm = intensity_xtreme_30mm ./ max(intensity_xtreme_30mm(:));

% Calculating location of max intensity
[maxEle, maxLat, maxDepth] = intensitypeak(intensity_xtreme_30mm, kzk_ele, ...
                                           kzk_lat, kzk_depth);
fprintf(['The maximum intensity occurs at %.2f cm in elevation position, '...
         '%.2f cm in lateral position, and %.2f cm in depth position.\n'],...
         maxEle, maxLat, maxDepth)
fprintf('\n')     

figure(1)
subplot(2, 1, 1)
imagesc(squeeze(intensity_linear_30mm(end, :, :))')
subplot(2, 1, 2)
imagesc(squeeze(intensity_xtreme_30mm(end, :, :))')


%% center trace plot
figure(2)
centertrace('extreme_compare_centertrace_c52_30mm.png', 'Linear KZK vs. Extreme KZK Center Trace - C5-2, 30 mm Focus',...
            intensity_linear_30mm, intensity_kzk_30mm_depth, 'Linear KZK, C5-2, 30 mm Focus',...
            intensity_xtreme_30mm, intensity_kzk_30mm_depth, 'KZK (B=10), C5-2, 30 mm Focus')