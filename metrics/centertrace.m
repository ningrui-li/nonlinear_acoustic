function [] = centertrace(OutputName, PlotTitle, varargin)
% function [] = centertrace(OutputName, intensity1, int1_depth, int1_name, intensity2, int2_depth, int2_name, ...)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% INPUT:
% OutputName (String) - file name of output center trace plot
% PlotTitle (String) - title of plot 
% intensity1 - 3D intensity field following conventions used in fem tools where
% axial extends into -z (with z = 0 at transducer face), lateral extends
% into +y, and elev extends into -x. Assume first dimension is elevation, 
% second dimension is lateral, and the third dimension is depth.
% int1_depth - vector of depth values (cm) at which intensity values are
% calculated (ex. 0:-0.5:-30)
% int1_name (String) - name of intensity field (ex. 'KZK Sim C5-2 30mm Focus')
%
% There can be a variable number of intensity inputs, as long as all of the
% intensity inputs contain the 3D intensity matrix, the vector of depth
% values, and the name (in that order).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% OUTPUT:
% PNG file depicting plot is saved to CWD with file name OutputName.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% EXAMPLE:
% centertrace('intensity_centertrace.png', 'Intensity vs. Depth', kzk_intensity,
% kzk_depth, 'KZK Sim, C5-2, 30 mm Focus', field_intensity, field_depth, 
% 'Field II Sim, 'C5-2', 30 mm Focus')

if ~ischar(OutputName)
    error('OutputName must be a string.')
end

if ~ischar(PlotTitle)
    error('PlotTitle must be a string.')
end

if mod(length(varargin), 3) ~= 0
    error(['Each intensity field input requires three components: the ', ...
         'intensity matrix, the depth vector, and the intensity field name'])
end

for i = 1:3:length(varargin)
    if size(varargin{i}, 3) ~= length(varargin{i+1})
        error(['Depth vector not same length as depth dimension in ', ...
             sprintf('intensity field input %d.', i)])
    end
end

% cell array of various line style and color options for plotting
plottingLineStyles = {'-', '--', '-.', ':'};
plottingLineColors = {'b', 'k', 'r', 'g', 'c', 'm'};

% number of intensity plot lines in total
intensityPlotCount = length(varargin)/3;

for i = 1:intensityPlotCount
    depth = squeeze(varargin{3*(i-1)+2});
    intensityAlongCenterTrace = varargin{3*(i-1)+1}(end, 1, :);
    intensityAlongCenterTrace = squeeze(intensityAlongCenterTrace);
    % The following piece of weird arithmetric logic is because in order to
    % get indices in terms of MATLAB conventions, we need to subtract 1 from
    % our number, perform the mod operation, then re-add the 1.
    
    % For example, working in mod 3, this allows us to have something like:
    % 1->1, 2->2, 3->3, 4->1, 5->2, 6->3, 7->1, ...
    lineStyleIndex = mod(i-1, length(plottingLineStyles)) + 1;
    lineColorIndex = mod(i-1, length(plottingLineColors)) + 1;
    lineStyle = plottingLineStyles{lineStyleIndex};
    lineColor = plottingLineColors{lineColorIndex};
    plot(depth, intensityAlongCenterTrace, char([lineColor lineStyle]))
    
    if i == 1
        hold on
    end
end
hold off

title(PlotTitle)
xlabel('Depth (cm)')
ylabel('Intensity')
% Axis settings assume depth values are extremely similar between plotted 
% intensity data sets. Also assumes intensity values are correctly normalized
% to be between 0 and 1.
axis([min(varargin{2}) max(varargin{2}) 0 1])
legendTitles = '';
for i = 1:intensityPlotCount
    legendTitles = [legendTitles '''' varargin{3*(i-1)+3}  ''', '];
end
eval(sprintf('legend(%s 0)', legendTitles))

eval(sprintf('print -dpng %s', OutputName'))
end