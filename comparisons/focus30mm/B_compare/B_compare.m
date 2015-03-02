clear; clf;

nln = 10; % ASCII value for new line
addpath ../../../metrics

% Linear KZK
fprintf('Linear KZK:\n')
load(['/luscinia/nl91/nonlinear_acoustic/kzk/field_ii_c52_focus30mm/B_0/',...
     'a_0.45_B_0/c52_30mm_intensity_field_field_ii_pressure_input.mat']);

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
load(['/luscinia/nl91/nonlinear_acoustic/kzk/field_ii_c52_focus30mm/B_3.5/',...
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

% KZK, B = 7
fprintf('KZK, B = 7:\n')
load(['/luscinia/nl91/nonlinear_acoustic/kzk/field_ii_c52_focus30mm/B_7/'...
      'a_0.45_B_7/c52_30mm_intensity_field_ii_pressure_input_beta_7.mat'])
                 
intensity_kzk_B7_30mm = permute(intensity, [3 2 1]);
intensity_kzk_B7_30mm = intensity_kzk_B7_30mm(1:length(kzk_ele), length(kzk_lat):end, :);
intensity_kzk_B7_30mm = intensity_kzk_B7_30mm ./ max(intensity_kzk_B7_30mm(:));

% Calculating location of max intensity
[maxEle, maxLat, maxDepth] = intensitypeak(intensity_kzk_B7_30mm, kzk_ele, ...
                                           kzk_lat, kzk_depth);
fprintf(['The maximum intensity occurs at %.2f cm in elevation position, '...
         '%.2f cm in lateral position, and %.2f cm in depth position.\n'],...
         maxEle, maxLat, maxDepth)
fprintf('\n')

%% Intensity Plot
figure(1)
subplot(3, 1, 1)
imagesc(squeeze(intensity_kzk_B0_30mm(end, :, :))')
subplot(3, 1, 2)
imagesc(squeeze(intensity_kzk_B35_30mm(end, :, :))')
subplot(3, 1, 3)
imagesc(squeeze(intensity_kzk_B7_30mm(end, :, :))')

%% center trace plot
figure(2)
centertrace('kzk_diff_B_centertrace_c52_30mm.png', 'KZK Sim Center Traces - C5-2, 30 mm Focus',...
            intensity_kzk_B0_30mm, kzk_depth, 'KZK Sim - $\beta=0$',...
            intensity_kzk_B35_30mm, kzk_depth, 'KZK Sim - $\beta=3.5$',...
            intensity_kzk_B7_30mm, kzk_depth, 'KZK Sim - $\beta=7$')
        
%% KZK, B = 0 contour plots
% contour plot in elevation-lateral plane at various depths
% Depth planes in 3.0 cm, 3.2 cm, and 3.4 cm planes. These planes were chosen
% because both intensity fields were maximum in 3.2 cm depth plane.
figure(3);
contourplots('kzk_B0_30mm_depth.png', ['KZK Sim' nln '30 mm Focus, \beta=0' nln 'Depth Plane'],...
              intensity_kzk_B0_30mm, kzk_ele, kzk_lat, kzk_depth, 3,...
              [60 65 70], [0 0.15 -.5 0]);

% contour plot in depth-elevation plane at various lateral positions
% Lateral planes are 0.00 cm, 0.08 cm, and 0.16 cm planes. 0.00 cm plane
% was chosen because both intensity fields were maximum at
% 0.00 cm lateral position.
figure(4);
contourplots('kzk_B0_30mm_lateral.png', ['KZK Sim' nln '30 mm Focus, \beta=0' nln 'Lateral Plane'],...
             intensity_kzk_B0_30mm, kzk_ele, kzk_lat, kzk_depth, 2,...
             [1 5 9], [-.51 0 0 5.2]);

% contour plot in depth-lateral plane at various elevational positions
% Elevational planes are -0.22 cm, -0.12 cm, and 0.00 cm planes. These 
% planes were chosen because both intensity fields were max in 0.00 cm plane.
figure(5);
contourplots('kzk_B0_30mm_elevational.png', ['KZK Sim' nln '30 mm Focus, \beta=0' nln 'Elevational Plane'],...
             intensity_kzk_B0_30mm, kzk_ele, kzk_lat, kzk_depth, 1,...
             [40 45 51], [0 .35 0 5.2]); 
         
%% KZK, B = 3.5 contour plots
% contour plot in elevation-lateral plane at various depths
% Depth planes in 3.0 cm, 3.2 cm, and 3.4 cm planes. These planes were chosen
% because both intensity fields were maximum in 3.2 cm depth plane.
figure(6);
contourplots('kzk_B35_30mm_depth.png', ['KZK Sim' nln '30 mm Focus, \beta=3.5' nln 'Depth Plane'],...
              intensity_kzk_B35_30mm, kzk_ele, kzk_lat, kzk_depth, 3,...
              [60 65 70], [0 0.15 -.5 0]);

% contour plot in depth-elevation plane at various lateral positions
% Lateral planes are 0.00 cm, 0.08 cm, and 0.16 cm planes. 0.00 cm plane
% was chosen because both intensity fields were maximum at
% 0.00 cm lateral position.
figure(7);
contourplots('kzk_B35_30mm_lateral.png', ['KZK Sim' nln '30 mm Focus, \beta=3.5' nln 'Lateral Plane'],...
             intensity_kzk_B35_30mm, kzk_ele, kzk_lat, kzk_depth, 2,...
             [1 5 9], [-.51 0 0 5.2]);

% contour plot in depth-lateral plane at various elevational positions
% Elevational planes are -0.22 cm, -0.12 cm, and 0.00 cm planes. These 
% planes were chosen because both intensity fields were max in 0.00 cm plane.
figure(8);
contourplots('kzk_B35_30mm_elevational.png', ['KZK Sim' nln '30 mm Focus, \beta=3.5' nln 'Elevational Plane'],...
             intensity_kzk_B35_30mm, kzk_ele, kzk_lat, kzk_depth, 1,...
             [40 45 51], [0 .35 0 5.2]); 
         
%% KZK, B = 7 contour plots
% contour plot in elevation-lateral plane at various depths
% Depth planes in 3.0 cm, 3.2 cm, and 3.4 cm planes. These planes were chosen
% because both intensity fields were maximum in 3.2 cm depth plane.
figure(6);
contourplots('kzk_B7_30mm_depth.png', ['KZK Sim' nln '30 mm Focus, \beta=7' nln 'Depth Plane'],...
              intensity_kzk_B7_30mm, kzk_ele, kzk_lat, kzk_depth, 3,...
              [60 65 70], [0 0.15 -.5 0]);

% contour plot in depth-elevation plane at various lateral positions
% Lateral planes are 0.00 cm, 0.08 cm, and 0.16 cm planes. 0.00 cm plane
% was chosen because both intensity fields were maximum at
% 0.00 cm lateral position.
figure(7);
contourplots('kzk_B7_30mm_lateral.png', ['KZK Sim' nln '30 mm Focus, \beta=7' nln 'Lateral Plane'],...
             intensity_kzk_B7_30mm, kzk_ele, kzk_lat, kzk_depth, 2,...
             [1 5 9], [-.51 0 0 5.2]);

% contour plot in depth-lateral plane at various elevational positions
% Elevational planes are -0.22 cm, -0.12 cm, and 0.00 cm planes. These 
% planes were chosen because both intensity fields were max in 0.00 cm plane.
figure(8);
contourplots('kzk_B7_30mm_elevational.png', ['KZK Sim' nln '30 mm Focus, \beta=7' nln 'Elevational Plane'],...
             intensity_kzk_B7_30mm, kzk_ele, kzk_lat, kzk_depth, 1,...
             [40 45 51], [0 .35 0 5.2]); 
         
%% Difference plot
% B=3.5 vs. linear
% should be made into a function.
intensity_diff = intensity_kzk_B35_30mm-intensity_kzk_B0_30mm;

figure(12)
plot_depths = [60 65 70];
subplot_index = 1;
for depthPos = plot_depths
    subplot(1, 3, subplot_index)
    subplot_index = subplot_index + 1;
    imagesc(kzk_lat, kzk_ele, squeeze(intensity_diff(:, :, depthPos)))
    xlabel('Lateral Position (cm)')
    ylabel('Elevational Position (cm)')
    title(sprintf(['Difference Plot' nln '30 mm Focus' nln 'Depth Plane - %.2f cm'], kzk_depth(depthPos)))
    colorbar
    axis([0 0.5 -0.5 0])
end
suptitle('Linear vs. \beta = 3.5')
print -dpng kzk_B35_diffplot_30mm_depth.png

figure(13)
plot_lat = [1 2 3];
subplot_index = 1;
for latPos = plot_lat
    subplot(1, 3, subplot_index)
    subplot_index = subplot_index + 1;
    imagesc(kzk_ele, kzk_depth, squeeze(intensity_diff(:, latPos, :))')
    xlabel('Elevational Position (cm)')
    ylabel('Depth Position (cm)')
    title(sprintf(['Difference Plot' nln '30 mm Focus' nln 'Lateral Plane - %.2f cm'], kzk_lat(latPos)))
    colorbar
end
print -dpng kzk_B35_diffplot_30mm_lateral.png

% B=7 vs. linear
intensity_diff = intensity_kzk_B7_30mm-intensity_kzk_B0_30mm;

figure(14)
plot_depths = [60 65 70];
subplot_index = 1;
for depthPos = plot_depths
    subplot(1, 3, subplot_index)
    subplot_index = subplot_index + 1;
    imagesc(kzk_lat, kzk_ele, squeeze(intensity_diff(:, :, depthPos)))
    xlabel('Lateral Position (cm)')
    ylabel('Elevational Position (cm)')
    title(sprintf(['Difference Plot' nln '30 mm Focus' nln 'Depth Plane - %.2f cm'], kzk_depth(depthPos)))
    colorbar
    axis([0 0.5 -0.5 0])
end
print -dpng kzk_B7_diffplot_30mm_depth.png

figure(15)
plot_lat = [1 2 3];
subplot_index = 1;
for latPos = plot_lat
    subplot(1, 3, subplot_index)
    subplot_index = subplot_index + 1;
    imagesc(kzk_ele, kzk_depth, squeeze(intensity_diff(:, latPos, :))')
    xlabel('Elevational Position (cm)')
    ylabel('Depth Position (cm)')
    title(sprintf(['Difference Plot' nln '30 mm Focus' nln 'Lateral Plane - %.2f cm'], kzk_lat(latPos)))
    colorbar
end
suptitle('Linear vs. \beta = 7')
print -dpng kzk_B7_diffplot_30mm_lateral.png