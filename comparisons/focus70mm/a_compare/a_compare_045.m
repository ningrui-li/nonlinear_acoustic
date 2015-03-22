clear; clf;

nln = 10; % ASCII value for new line
addpath ../../../metrics
 
atten = '0.45'; % dB/cm/MHz
fprintf('attenuation = %s dB/cm/MHz\n', atten)

% Linear KZK
fprintf('Linear KZK:\n')
load(sprintf(['/luscinia/nl91/nonlinear_acoustic/kzk/field_ii_c52_focus70mm/B_0/',...
     'a_%s_B_0/c52_70mm_intensity_field_field_ii_pressure_input.mat'], atten));

% cut data to just quarter of all values, since it is quarter symmetric
kzk_ele = ele(1:(floor(length(ele)/2)+1));
kzk_lat = lat((floor(length(lat)/2)+1):end);
kzk_depth = depth;
% mm to cm
kzk_ele = kzk_ele./10;
kzk_lat = kzk_lat./10;
kzk_depth = kzk_depth./10;
  
intensity_kzk_B0_70mm = permute(intensity, [3 2 1]);
intensity_kzk_B0_70mm = intensity_kzk_B0_70mm(1:length(kzk_ele), length(kzk_lat):end, :);
intensity_kzk_B0_70mm = intensity_kzk_B0_70mm ./ max(intensity_kzk_B0_70mm(:));

% Calculating location of max intensity
[maxEle, maxLat, maxDepth] = intensitypeak(intensity_kzk_B0_70mm, kzk_ele, ...
                                           kzk_lat, kzk_depth);
fprintf(['The maximum intensity occurs at %.2f cm in elevation position, '...
         '%.2f cm in lateral position, and %.2f cm in depth position.\n'],...
         maxEle, maxLat, maxDepth)
fprintf('\n')     

% KZK, B = 3.5
fprintf('KZK, B = 3.5:\n')
load(sprintf(['/luscinia/nl91/nonlinear_acoustic/kzk/field_ii_c52_focus70mm/B_3.5/',...
     'a_%s_B_3.5/c52_70mm_intensity_field_field_ii_pressure_input.mat'], atten));
                 
intensity_kzk_B35_70mm = permute(intensity, [3 2 1]);
intensity_kzk_B35_70mm = intensity_kzk_B35_70mm(1:length(kzk_ele), length(kzk_lat):end, :);
intensity_kzk_B35_70mm = intensity_kzk_B35_70mm ./ max(intensity_kzk_B35_70mm(:));

% Calculating location of max intensity
[maxEle, maxLat, maxDepth] = intensitypeak(intensity_kzk_B35_70mm, kzk_ele, ...
                                           kzk_lat, kzk_depth);
fprintf(['The maximum intensity occurs at %.2f cm in elevation position, '...
         '%.2f cm in lateral position, and %.2f cm in depth position.\n'],...
         maxEle, maxLat, maxDepth)
fprintf('\n')

% % KZK, B = 7
% fprintf('KZK, B = 7:\n')
% load(['/luscinia/nl91/nonlinear_acoustic/kzk/field_ii_c52_focus70mm/B_7/'...
%       'a_2.5_B_7/c52_70mm_intensity_field_field_ii_pressure_input.mat'])
%                  
% intensity_kzk_B7_70mm = permute(intensity, [3 2 1]);
% intensity_kzk_B7_70mm = intensity_kzk_B7_70mm(1:length(kzk_ele), length(kzk_lat):end, :);
% intensity_kzk_B7_70mm = intensity_kzk_B7_70mm ./ max(intensity_kzk_B7_70mm(:));
% 
% % Calculating location of max intensity
% [maxEle, maxLat, maxDepth] = intensitypeak(intensity_kzk_B7_70mm, kzk_ele, ...
%                                            kzk_lat, kzk_depth);
% fprintf(['The maximum intensity occurs at %.2f cm in elevation position, '...
%          '%.2f cm in lateral position, and %.2f cm in depth position.\n'],...
%          maxEle, maxLat, maxDepth)
% fprintf('\n')

%% Intensity Plot
figure(1)
subplot(3, 1, 1)
imagesc(squeeze(intensity_kzk_B0_70mm(end, :, :))')
subplot(3, 1, 2)
imagesc(squeeze(intensity_kzk_B35_70mm(end, :, :))')
%subplot(3, 1, 3)
%imagesc(squeeze(intensity_kzk_B7_70mm(end, :, :))')

%% center trace plot
figure(2)
% centertrace('kzk_diff_B_centertrace_c52_70mm.png', 'KZK Sim Center Traces - C5-2, 70 mm Focus',...
%             intensity_kzk_B0_70mm, kzk_depth, 'KZK Sim - $\beta=0$',...
%             intensity_kzk_B35_70mm, kzk_depth, 'KZK Sim - $\beta=3.5$',...
%             intensity_kzk_B7_70mm, kzk_depth, 'KZK Sim - $\beta=7$')


centertrace(sprintf('kzk_centertrace_c52_70mm_a_%s.png', atten),...
            sprintf(['KZK Sim Center Traces', nln, ...
                     'C5-2, 70 mm Focus, a = %s dB/cm/MHz'], atten),...
            intensity_kzk_B0_70mm, kzk_depth, 'KZK Sim - $\beta=0$',...
            intensity_kzk_B35_70mm, kzk_depth, 'KZK Sim - $\beta=3.5$')              
        
%% Difference plot
% B=3.5 vs. linear
% should be made into a function.
intensity_diff = intensity_kzk_B35_70mm-intensity_kzk_B0_70mm;

figure(3)
plot_depths = [79 83 103];
subplot_index = 1;
for depthPos = plot_depths
    subplot(1, 3, subplot_index)
    subplot_index = subplot_index + 1;
    imagesc(kzk_lat, kzk_ele, squeeze(intensity_diff(:, :, depthPos)))
    xlabel('Lateral Position (cm)')
    ylabel('Elevational Position (cm)')
    title(sprintf(['Difference Plot' nln '70 mm Focus' nln 'Depth Plane - %.2f cm'], kzk_depth(depthPos)))
    colorbar
    axis([0 0.5 -0.5 0])
end
%suptitle('Linear vs. \beta = 3.5')
eval(sprintf('print -dpng kzk_B35_diffplot_70mm_depth_a_%s.png', atten))

figure(4)
plot_lat = [1 4 7];
subplot_index = 1;
for latPos = plot_lat
    subplot(1, 3, subplot_index)
    subplot_index = subplot_index + 1;
    imagesc(kzk_ele, kzk_depth, squeeze(intensity_diff(:, latPos, :))')
    xlabel('Elevational Position (cm)')
    ylabel('Depth Position (cm)')
    title(sprintf(['Difference Plot' nln '70 mm Focus' nln 'Lateral Plane - %.2f cm'], kzk_lat(latPos)))
    colorbar
end
%suptitle('Linear vs. \beta = 3.5')
eval(sprintf('print -dpng kzk_B35_diffplot_70mm_lateral_a_%s.png', atten))


% % B=7 vs. linear
% intensity_diff = intensity_kzk_B7_70mm-intensity_kzk_B0_70mm;
% 
% figure(14)
% plot_depths = [79 83 103];
% subplot_index = 1;
% for depthPos = plot_depths
%     subplot(1, 3, subplot_index)
%     subplot_index = subplot_index + 1;
%     imagesc(kzk_lat, kzk_ele, squeeze(intensity_diff(:, :, depthPos)))
%     xlabel('Lateral Position (cm)')
%     ylabel('Elevational Position (cm)')
%     title(sprintf(['Difference Plot' nln '70 mm Focus' nln 'Depth Plane - %.2f cm'], kzk_depth(depthPos)))
%     colorbar
%     axis([0 0.5 -0.5 0])
% end
% print -dpng kzk_B7_diffplot_70mm_depth.png

% figure(15)
% plot_lat = [1 4 7];
% subplot_index = 1;
% for latPos = plot_lat
%     subplot(1, 3, subplot_index)
%     subplot_index = subplot_index + 1;
%     imagesc(kzk_ele, kzk_depth, squeeze(intensity_diff(:, latPos, :))')
%     xlabel('Elevational Position (cm)')
%     ylabel('Depth Position (cm)')
%     title(sprintf(['Difference Plot' nln '70 mm Focus' nln 'Lateral Plane - %.2f cm'], kzk_lat(latPos)))
%     colorbar
% end
% % suptitle('Linear vs. \beta = 7')
% print -dpng kzk_B7_diffplot_70mm_lateral.png