function [sws] = calc_sws(alpha, beta, depth, printPlot)
%% calc_sws.m
% Estimates shear wave speed at a particular depth using the time-to-peak
% algorithm.
% printPlot is a optional boolean input that determines whether or not the
% SWS estimation plots should be saved as .png files. (default = false)

nln = 10;

if nargin < 4 
    printPlot = 0;
end
    
eval(sprintf('load /pisgah/nl91/scratch/data/E3.0kPa/foc70mm/B_%.1f/a_%.3f/F3.5/EXCDUR_300us/res_sim.mat', beta, alpha));

lat_start = 2;           % lateral position start index for SWS estimation
lat_end = length(lat)-4; % lateral position end index for SWS estimation

% throw out last couple of lateral positions
lat = lat(lat_start:lat_end);

% time to peak (s) for each lateral tracking position
ttp = zeros(1, length(lat)); 

% calculate time to peak at each lateral position for the given depth
for later = lat_start:lat_end
    displacements = squeeze(arfidata(depth, later, :));
    ttp(later-lat_start+1) = t(find(displacements == max(displacements(:)), 1));
end

% convert from mm to m
lat = lat * 1e-3;
           
linear_regression = polyfit(ttp, lat, 1);
sws = linear_regression(1);

if printPlot
    figure
    plot(ttp*1e3, lat, 'k-') % note conversion from s to ms for time to peak
    xlabel('Time to Peak (ms)', 'FontSize', 14)
    ylabel('Lateral Tracking Position (mm)', 'FontSize', 14)
    title(sprintf(['SWS Estimation at Depth of %.1f mm', nln, ...
                   '(\\alpha=%.3f dB/cm/MHz, \\beta=%.1f)'],...
                   axial(depth), alpha, beta), 'FontSize', 18)
               
    eval(sprintf('print -dpng sws_ttp_a%.3f_B%.1f_depth%.1f.png', alpha, beta, axial(depth)))
end


