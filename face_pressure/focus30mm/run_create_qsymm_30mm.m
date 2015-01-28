clear; clf;
load /luscinia/nl91/lab/nonlinearity/focus70mm/pressure_waveforms_median_untilted.mat

pressure = createQuarterSymmetry(pressure);
pressure = single(pressure);

save /luscinia/nl91/lab/nonlinearity/focus70mm/pressure_waveforms_median_qsymmetric_single_precision_interpolated_axes.mat