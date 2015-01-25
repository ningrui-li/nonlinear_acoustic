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

figure(1)
subplot(2, 1, 1)
imagesc(squeeze(intensity_field_70mm(end, :, :))')
subplot(2, 1, 2)
imagesc(squeeze(intensity_kzk_70mm(end, :, :))')

%% center trace plot
figure(2)
centertrace('field_kzk_centertrace_c52_70mm.png', 'Field vs. KZK Center Trace - C5-2, 70 mm Focus',...
            intensity_field_70mm, intensity_field_70mm_depth, 'Field II, C5-2, 70 mm Focus',...
            intensity_kzk_70mm, intensity_kzk_70mm_depth, 'KZK, C5-2, 70 mm Focus')
        
%% KZK contour plots
% contour plot in elevation-lateral plane at various depths
% Depth planes in 3.75 cm, 5.10 cm, and 6.40 cm planes. These planes chosen
% because KZK intensity field is maximum in 3.75 cm plane and Field II
% intensity field is max in 6.40 cm plane.
figure(3);
contourplots('kzk_70mm_depth.png', 'KZK, 70 mm Focus - Depth Plane',...
              intensity_kzk_70mm, kzk_ele, kzk_lat, kzk_depth, 3,...
              [76 103 129], [0 0.45 -.4 0]);

% contour plot in depth-elevation plane at various lateral positions
% Lateral planes are 0.00 cm, 0.06 cm, and 0.14 cm planes. These planes chosen
% because KZK intensity field is maximum in 0.00 cm plane and Field II
% intensity field is max in 0.14 cm plane.
figure(4);
contourplots('kzk_70mm_lateral.png', 'KZK, 70 mm Focus - Lateral Plane',...
             intensity_kzk_70mm, kzk_ele, kzk_lat, kzk_depth, 2,...
             [1 4 8], [-.3 0 1 9]);

% contour plot in depth-lateral plane at various elevational positions
% Elevational planes are -0.14 cm, -0.06 cm, and 0.00 cm planes. These 
% planes were chosen because both Field II and KZK intensity fields are
% maximum in 0.00 cm plane.
figure(5);
contourplots('kzk_70mm_elevational.png', 'KZK, 70 mm Focus - Elevational Plane',...
             intensity_kzk_70mm, kzk_ele, kzk_lat, kzk_depth, 1,...
             [53 57 61], [0 .6 1 9]);
         
%% Field II contour plots
% contour plot in elevation-lateral plane at various depths
% Depth planes in 3.75 cm, 5.10 cm, and 6.40 cm planes.
figure(6);
contourplots('field2_70mm_depth.png', 'Field II, 70 mm Focus - Depth Plane',...
             intensity_field_70mm, field_ele, field_lat, field_depth, 3,...
             [76 103 129], [0 0.45 -.4 0]);

% contour plot in depth-elevation plane at various lateral positions
% Lateral planes are 0.00 cm, 0.06 cm, and 0.14 cm planes.
figure(7);
contourplots('field2_70mm_lateral.png', 'Field II, 70 mm Focus - Lateral Plane',...
             intensity_field_70mm, field_ele, field_lat, field_depth, 2,...
             [1 4 8], [-.3 0 1 9]);

% contour plot in depth-lateral plane at various elevational positions         
% Elevational planes are -0.14 cm, -0.06 cm, and 0.00 cm planes.
figure(8);
contourplots('field2_70mm_elevational.png', 'Field II, 70 mm Focus - Elevational Plane',...
             intensity_field_70mm, field_ele, field_lat, field_depth, 1,...
             [53 57 61], [0 .6 1 9]);