clear; clf;
close all;

cd /luscinia/nl91/nonlinear_acoustic/sws/

%% 70 mm focus

load focus70mm_sws
load /pisgah/nl91/scratch/data/E3.0kPa/foc70mm/B_0.0/a_0.005/F3.5/EXCDUR_300us/res_sim.mat

cd /luscinia/nl91/nonlinear_acoustic/sws/sws_v_depth/

for alpha = 1:length(a)
    figure(alpha)
    plot(axial(depths), squeeze(sws(alpha, 1, :)), 'k*-')
    hold on
    plot(axial(depths), squeeze(sws(alpha, 2, :)), 'bs--')
    plot(axial(depths), squeeze(sws(alpha, 3, :)), 'r.:')
    hold off

    title(sprintf(['SWS vs. Depth for \\alpha=%.3f dB/cm/MHz' 10 'Focal Depth = 70 mm'], a(alpha)), 'FontSize', 18)
    xlabel('Depth (mm)', 'FontSize', 15)
    ylabel('SWS (m/s)', 'FontSize', 15)
    legend('\beta=0.0', '\beta=3.5', '\beta=7.0', 0)
    eval(sprintf('print -dpng sws_v_depth_foc70_a_%.3f.png', a(alpha)))
end

%% 30 mm focus

load focus30mm_sws
load /pisgah/nl91/scratch/data/E3.0kPa/foc30mm/B_0.0/a_0.005/F3.5/EXCDUR_300us/res_sim.mat

cd /luscinia/nl91/nonlinear_acoustic/sws/sws_v_depth/

for alpha = 1:length(a)
    figure(alpha)
    plot(axial(depths), squeeze(sws(alpha, 1, :)), 'k*-')
    hold on
    plot(axial(depths), squeeze(sws(alpha, 2, :)), 'bs--')
    plot(axial(depths), squeeze(sws(alpha, 3, :)), 'r.:')
    hold off

    title(sprintf(['SWS vs. Depth for \\alpha=%.3f dB/cm/MHz' 10 'Focal Depth = 30 mm'], a(alpha)), 'FontSize', 18)
    xlabel('Depth (mm)', 'FontSize', 15)
    ylabel('SWS (m/s)', 'FontSize', 15)
    legend('\beta=0.0', '\beta=3.5', '\beta=7.0', 0)
    eval(sprintf('print -dpng sws_v_depth_foc30_a_%.3f.png', a(alpha)))
end
