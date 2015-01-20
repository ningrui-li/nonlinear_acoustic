function [] = contourplots(OutputName, PlotTitle, intensity, ele, lat, depth, PlotPlane, planes, axisLimits)
% function [] = contourplots(OutputName, PlotTitle, IntensityPlane, RowValues, ColValues)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% INPUT:
% OutputName (String) - file name of output center trace plot
% PlotTitle (String) - title of plot 
% intensity - 3D intensity field that the contour plot will be made from.
% Assumes matrix dimensions are elevation x lateral x depth, with a quarter
% symmetric field.
% ele - vector of elevation position values (in cm), using Field II conventions
% lat - vector of lateral positon values (in cm), using Field II conventions
% depth - vector of depth position values (in cm), using Field II conventions
% PlotPlane - integer to specify dimension plane of contour plot.
% Should be 1 for elevation plane, 2 for lateral plane, and 3 for depth
% plane.
% planes - specifies which planes and how many planes should be plotted.
% For example, if PlotPlane is 3 and planes = [51 61 71], then depth planes
% will be plotted at depths of depth(51), depth(61), and depth(71).
% axisLimits - optional input vector specifying axis limits for the plots.
% This vector should be in the form [xmin xmax ymin ymax]. If not given, 
% MATLAB Will automatically choose axis limits.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% OUTPUT:
% PNG file depicting plot is saved to CWD with file name OutputName.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% EXAMPLE:
% contourplots('intensity_contourplot.png', 'Contour Plot of Intensity Plane at Depth = 30 mm',...
% kzk_30mm_intensity, kzk_elevation_vals, kzk_lateral_vals, kzk_depth_vals,... 
% 3, [51 61 71]);

%% Depth plane plots
% looking to plot contour levels at -6 dB, -12 dB, and -18 dB
dbLevels = [-6 -12 -18];

subplotCount = 1;
subplotHandles = zeros(1, length(planes));

% variable with a reasonably large number so that each contour line only
% gets one label associated with it. This is to reduce the amount of labeling
% on the contour plot, making it easier to read.
reallyLargeContourLabelSpacing = 1e7;
if PlotPlane == 1
    for plane = planes
        subplotHandles(subplotCount) = subplot(length(planes), 1, subplotCount);
        intensity_plane = squeeze(intensity(plane, :, :));
        intensity_plane = intensity_plane';
        intensity_plane = db(intensity_plane);

        [C, h] = contour(lat, depth, intensity_plane, dbLevels);
        
        clabel(C, h, 'LabelSpacing', reallyLargeContourLabelSpacing);
        title(sprintf('%s (%.2f cm)', PlotTitle, ele(plane)))
        % consider figuring out some way to automatically set axes limits
        % based on outer contour line boundaries
        xlabel('Lateral Position (cm)')
        
        ylabel('Depth Position (cm)')
        subplotCount = subplotCount + 1;
    end    
elseif PlotPlane == 2
    for plane = planes
        subplotHandles(subplotCount) = subplot(length(planes), 1, subplotCount);
        intensity_plane = squeeze(intensity(:, plane, :));
        intensity_plane = intensity_plane';
        intensity_plane = db(intensity_plane);
        
        [C, h] = contour(ele, depth, intensity_plane, dbLevels);
        
        clabel(C, h, 'LabelSpacing', reallyLargeContourLabelSpacing);
        title(sprintf('%s (%.2f cm)', PlotTitle, lat(plane)))
        xlabel('Elevational Position (cm)')
        ylabel('Depth Position (cm)')
        
        subplotCount = subplotCount + 1;
    end 
else
    for plane = planes
        subplotHandles(subplotCount) = subplot(length(planes), 1, subplotCount);
        intensity_plane = squeeze(intensity(:, :, plane));
        intensity_plane = db(intensity_plane);
        
        [C, h] = contour(lat, ele, intensity_plane, dbLevels);
        
        clabel(C, h, 'LabelSpacing', reallyLargeContourLabelSpacing);
        title(sprintf('%s (%.2f cm)', PlotTitle, depth(plane)))
        xlabel('Lateral Position (cm)')
        ylabel('Elevational Position (cm)')        
        
        subplotCount = subplotCount + 1;
    end
end
% link axes of all subplots. Changing axis limits of one subplot will also
% change the axis limits of all other subplots.
linkaxes(subplotHandles, 'xy')
% This is needed because axis limits are currently set in the comparisons
% scripts, rather than being hard-coded into this function.

if nargin > 8
    axis(axisLimits)
end

eval(sprintf('print -dpng %s', OutputName'))

end