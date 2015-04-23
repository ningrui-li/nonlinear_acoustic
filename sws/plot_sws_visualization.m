clear; clf;

focus = 70;
beta = 3.5;
alpha = 0.300;

eval(sprintf('load /pisgah/nl91/scratch/data/E3.0kPa/foc%dmm/B_%.1f/a_%.3f/F3.5/EXCDUR_300us/res_sim.mat', focus, beta, alpha));

colors = ['b', 'm', 'c', 'r' ,'g', 'y', 'k'];
colorCounter = 1;

figure(1)
for i = 5:15:length(lat)
    eval(sprintf('plot(t*1e3, squeeze(arfidata(281, i, :)), ''%s-'')', colors(colorCounter)))
    colorCounter = colorCounter + 1;
    if i == 5
        hold on
    end
end
hold off

title(['Axial Displacements at Various Lateral Positions', 10, ...
       '70 mm focus, \alpha = 0.3 dB/cm/MHz, \beta = 3.5'], 'FontSize', 20)
xlabel('Time (ms)', 'FontSize', 16)
ylabel('Axial Displacement (mm)', 'FontSize', 16)

h = legend(sprintf('%.1f mm', lat(5)), ...
 	       sprintf('%.1f mm', lat(20)), ...
           sprintf('%.1f mm', lat(35)), ...
           sprintf('%.1f mm', lat(50)), ...
           sprintf('%.1f mm', lat(65)), ...
           sprintf('%.1f mm', lat(80)), ...
           sprintf('%.1f mm', lat(95)), 0);
set(h, 'FontSize', 14)
print -dpng axial_displacements_v_tracking_pos.png