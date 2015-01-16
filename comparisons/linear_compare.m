clear; clf;

%% Field II and KZK (linear) sim comparisons - 30 mm focus

% Field
load /luscinia/nl91/nonlinear_acoustic/field/field_c52_30mm/dyna-I-f2.36-F2.8-FD0.030-a0.45.mat
intensity_field_30mm = reshape(intensity, 51, 61, 105);
intensity_field_30mm = flip(intensity_field_30mm, 3);
intensity_field_30mm = intensity_field_30mm ./ max(intensity_field_30mm(:));
intensity_field_30mm_depth = 0:.5:52;


% KZK
load /luscinia/nl91/scratch/c52/focus30mm/quarter_symmetric/c52_intensity_vals_30_qsymm_intensity.mat
intensity_kzk_30mm = permute(intensity, [3 2 1]);
intensity_kzk_30mm = intensity_kzk_30mm(1:(floor(length(ele)/2)+1), (floor(length(lat)/2)+1):length(lat), :);
intensity_kzk_30mm = intensity_kzk_30mm ./ max(intensity_kzk_30mm(:));
intensity_kzk_30mm_depth = depthStep;

figure(1)
subplot(2, 1, 1)
imagesc(squeeze(intensity_field_30mm(end, :, :))')
subplot(2, 1, 2)
imagesc(squeeze(intensity_kzk_30mm(end, :, :))')

% center trace plot
figure(2)
centertrace('field_kzk_centertrace_c52_30mm.png', 'Field vs. KZK Center Trace - C5-2, 30 mm Focus',...
            intensity_field_30mm, intensity_field_30mm_depth, 'Field II, C5-2, 30 mm Focus',...
            intensity_kzk_30mm, intensity_kzk_30mm_depth, 'KZK, C5-2, 30 mm Focus')

% contour plot in lateral-elevation plane at various depths
figure(3)
contour(flip(lat(1:61)), flip(ele(51:end)), squeeze(intensity_kzk_30mm(:, :, 61)))
axis([-2 0 0 6])

















        

