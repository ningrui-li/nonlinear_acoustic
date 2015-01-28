clear; clf;

load pressure_waveforms_median_untilted.mat

pressure = createQuarterSymmetry(pressure);
pressure = single(pressure);

save pressure_waveforms_median_qsymmetric_single_precision_interpolated_axes.mat