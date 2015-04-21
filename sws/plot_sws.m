clear; clf;
close all;

load focus70mm_sws
load /pisgah/nl91/scratch/data/E3.0kPa/foc70mm/B_0.0/a_0.005/F3.5/EXCDUR_300us/res_sim.mat

for alpha = 1:length(a)
    figure(alpha)
    plot(axial(depths), squeeze(sws(alpha, 1, :)), 'k-')
    hold on
    plot(axial(depths), squeeze(sws(alpha, 2, :)), 'b--')
    plot(axial(depths), squeeze(sws(alpha, 3, :)), 'r:')
    hold off

    title(sprintf('SWS vs. Depth for \\alpha=%.3f dB/cm/MHz', a(alpha)), 'FontSize', 18)
    xlabel('Depth (mm)', 'FontSize', 14)
    ylabel('SWS (m/s)', 'FontSize', 14)
    legend('\beta=0.0', '\beta=3.5', '\beta=7.0', 0)
end