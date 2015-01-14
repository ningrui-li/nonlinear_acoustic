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

%plot(depth, 

end






