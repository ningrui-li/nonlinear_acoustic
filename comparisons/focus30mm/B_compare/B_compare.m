clear; clf;

addpath ../../../metrics

% Linear KZK
fprintf('Linear KZK:\n')
load(['/luscinia/nl91/nonlinear_acoustic/kzk/field_ii_c52_focus30mm/'...
      'B_0/a_0.45_B_0/c52_30mm_intensity_field_field_ii_pressure_input.mat'])
                 
% cut data to just quarter of all values, since it is quarter symmetric
kzk_ele = ele(1:(floor(length(ele)/2)+1));
kzk_lat = lat((floor(length(lat)/2)+1):end);
kzk_depth = depth;
% mm to cm
kzk_ele = kzk_ele./10;
kzk_lat = kzk_lat./10;
kzk_depth = kzk_depth./10;
  
intensity_kzk_B0_30mm = permute(intensity, [3 2 1]);
intensity_kzk_B0_30mm = intensity_kzk_B0_30mm(1:length(kzk_ele), length(kzk_lat):end, :);
intensity_kzk_B0_30mm = intensity_kzk_B0_30mm ./ max(intensity_kzk_B0_30mm(:));

% Calculating location of max intensity
[maxEle, maxLat, maxDepth] = intensitypeak(intensity_kzk_B0_30mm, kzk_ele, ...
                                           kzk_lat, kzk_depth);
fprintf(['The maximum intensity occurs at %.2f cm in elevation position, '...
         '%.2f cm in lateral position, and %.2f cm in depth position.\n'],...
         maxEle, maxLat, maxDepth)
fprintf('\n')     


% KZK, B = 3.5
fprintf('KZK, B = 3.5:\n')
load(['/luscinia/nl91/nonlinear_acoustic/kzk/field_ii_c52_focus30mm/B_3.5/'...
      'a_0.45_B_3.5/c52_30mm_intensity_field_ii_pressure_input_beta_3.5.mat'])
                 
intensity_kzk_B35_30mm = permute(intensity, [3 2 1]);
intensity_kzk_B35_30mm = intensity_kzk_B35_30mm(1:length(kzk_ele), length(kzk_lat):end, :);
intensity_kzk_B35_30mm = intensity_kzk_B35_30mm ./ max(intensity_kzk_B35_30mm(:));

% Calculating location of max intensity
[maxEle, maxLat, maxDepth] = intensitypeak(intensity_kzk_B35_30mm, kzk_ele, ...
                                           kzk_lat, kzk_depth);
fprintf(['The maximum intensity occurs at %.2f cm in elevation position, '...
         '%.2f cm in lateral position, and %.2f cm in depth position.\n'],...
         maxEle, maxLat, maxDepth)
fprintf('\n')

figure(1)
subplot(2, 1, 1)
imagesc(squeeze(intensity_kzk_B0_30mm(end, :, :))')
subplot(2, 1, 2)
imagesc(squeeze(intensity_kzk_B35_30mm(end, :, :))')

%% center trace plot
figure(2)
centertrace('kzk_diff_B_centertrace_c52_30mm.png', 'KZK Sim Center Traces - C5-2, 30 mm Focus',...
            intensity_kzk_B0_30mm, kzk_depth, 'KZK Sim - $\beta=0$',...
            intensity_kzk_B35_30mm, kzk_depth, 'KZK Sim - $\beta=3.5$)')