clear; clf;

nln = 10; % ASCII value for new line
addpath ../../../metrics

% Linear KZK
fprintf('Linear KZK:\n')
load(['/luscinia/nl91/nonlinear_acoustic/kzk/field_ii_c52_focus70mm/B_0/',...
     'a_0.45_B_0/c52_70mm_intensity_field_ii_pressure_input.mat']);

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
load(['/luscinia/nl91/nonlinear_acoustic/kzk/field_ii_c52_focus70mm/B_3.5/',...
      'a_0.45_B_3.5/c52_70mm_intensity_field_ii_pressure_input.mat'])
                 
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

% KZK, B = 7
fprintf('KZK, B = 7:\n')
load(['/luscinia/nl91/nonlinear_acoustic/kzk/field_ii_c52_focus70mm/B_7/'...
      'a_0.45_B_7/c52_70mm_intensity_field_ii_pressure_input.mat'])
                 
intensity_kzk_B7_70mm = permute(intensity, [3 2 1]);
intensity_kzk_B7_70mm = intensity_kzk_B7_70mm(1:length(kzk_ele), length(kzk_lat):end, :);
intensity_kzk_B7_70mm = intensity_kzk_B7_70mm ./ max(intensity_kzk_B7_70mm(:));

% Calculating location of max intensity
[maxEle, maxLat, maxDepth] = intensitypeak(intensity_kzk_B7_70mm, kzk_ele, ...
                                           kzk_lat, kzk_depth);
fprintf(['The maximum intensity occurs at %.2f cm in elevation position, '...
         '%.2f cm in lateral position, and %.2f cm in depth position.\n'],...
         maxEle, maxLat, maxDepth)
fprintf('\n')

%% Intensity Plot
figure(1)
subplot(3, 1, 1)
imagesc(squeeze(intensity_kzk_B0_70mm(end, :, :))')
subplot(3, 1, 2)
imagesc(squeeze(intensity_kzk_B35_70mm(end, :, :))')
subplot(3, 1, 3)
imagesc(squeeze(intensity_kzk_B7_70mm(end, :, :))')

%% center trace plot
figure(2)
centertrace('kzk_diff_B_centertrace_c52_70mm.png', 'KZK Sim Center Traces - C5-2, 70 mm Focus',...
            intensity_kzk_B0_70mm, kzk_depth, 'KZK Sim - $\beta=0$',...
            intensity_kzk_B35_70mm, kzk_depth, 'KZK Sim - $\beta=3.5$',...
            intensity_kzk_B7_70mm, kzk_depth, 'KZK Sim - $\beta=7$')
        
%% KZK, B = 0 contour plots
% contour plot in elevation-lateral plane at various depths
% Depth planes in 3.75 cm, 5.10 cm, and 6.40 cm planes. 
figure(3);
contourplots('kzk_B0_70mm_depth.png', ['KZK Sim' nln '70 mm Focus, \beta=0' nln 'Depth Plane'],...
              intensity_kzk_B0_70mm, kzk_ele, kzk_lat, kzk_depth, 3,...
              [76 103 129], [0 0.45 -.4 0]);

% contour plot in depth-elevation plane at various lateral positions
% Lateral planes are 0.00 cm, 0.06 cm, and 0.14 cm planes.
figure(4);
contourplots('kzk_B0_70mm_lateral.png', ['KZK Sim' nln '70 mm Focus, \beta=0' nln 'Lateral Plane'],...
             intensity_kzk_B0_70mm, kzk_ele, kzk_lat, kzk_depth, 2,...
             [1 4 8], [-.3 0 1 9]);

% contour plot in depth-lateral plane at various elevational positions
% Elevational planes are -0.14 cm, -0.06 cm, and 0.00 cm planes.
figure(5);
contourplots('kzk_B0_70mm_elevational.png', ['KZK Sim' nln '70 mm Focus, \beta=0' nln 'Elevational Plane'],...
             intensity_kzk_B0_70mm, kzk_ele, kzk_lat, kzk_depth, 1,...
             [53 57 61], [0 .6 1 9]); 
         
%% KZK, B = 3.5 contour plots
figure(6);
contourplots('kzk_B35_70mm_depth.png', ['KZK Sim' nln '70 mm Focus, \beta=3.5' nln 'Depth Plane'],...
              intensity_kzk_B35_70mm, kzk_ele, kzk_lat, kzk_depth, 3,...
              [76 103 129], [0 0.45 -.4 0]);

figure(7);
contourplots('kzk_B35_70mm_lateral.png', ['KZK Sim' nln '70 mm Focus, \beta=3.5' nln 'Lateral Plane'],...
             intensity_kzk_B35_70mm, kzk_ele, kzk_lat, kzk_depth, 2,...
             [1 4 8], [-.3 0 1 9]);

figure(8);
contourplots('kzk_B35_70mm_elevational.png', ['KZK Sim' nln '70 mm Focus, \beta=3.5' nln 'Elevational Plane'],...
             intensity_kzk_B35_70mm, kzk_ele, kzk_lat, kzk_depth, 1,...
             [53 57 61], [0 .6 1 9]); 
         
%% KZK, B = 7 contour plots
figure(9);
contourplots('kzk_B7_70mm_depth.png', ['KZK Sim' nln '70 mm Focus, \beta=7' nln 'Depth Plane'],...
              intensity_kzk_B7_70mm, kzk_ele, kzk_lat, kzk_depth, 3,...
              [76 103 129], [0 0.45 -.4 0]);

figure(10);
contourplots('kzk_B7_70mm_lateral.png', ['KZK Sim' nln '70 mm Focus, \beta=7' nln 'Lateral Plane'],...
             intensity_kzk_B7_70mm, kzk_ele, kzk_lat, kzk_depth, 2,...
             [1 4 8], [-.3 0 1 9]);

figure(11);
contourplots('kzk_B7_70mm_elevational.png', ['KZK Sim' nln '70 mm Focus, \beta=7' nln 'Elevational Plane'],...
             intensity_kzk_B7_70mm, kzk_ele, kzk_lat, kzk_depth, 1,...
             [53 57 61], [0 .6 1 9]); 
          
%% Difference plot
% B=3.5 vs. linear
% should be made into a function.
intensity_diff = intensity_kzk_B35_70mm-intensity_kzk_B0_70mm;

figure(12)
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
print -dpng kzk_B35_diffplot_70mm_depth.png

figure(13)
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
print -dpng kzk_B35_diffplot_70mm_lateral.png


% B=7 vs. linear
intensity_diff = intensity_kzk_B7_70mm-intensity_kzk_B0_70mm;

figure(14)
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
print -dpng kzk_B7_diffplot_70mm_depth.png

figure(15)
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
% suptitle('Linear vs. \beta = 7')
print -dpng kzk_B7_diffplot_70mm_lateral.png