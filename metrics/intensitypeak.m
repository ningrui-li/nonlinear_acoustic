function [maxEle, maxLat, maxDepth] = intensitypeak(intensity, ele, lat, depth)
% function [maxEle, maxLat, maxDepth] = intensitypeak(intensity, ele, lat, depth)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% INPUT:
% intensity - 3D matrix of intensity field values. The first dimension should
% be elevational, the second dimension should be lateral, and the third
% dimension should be depth.
% ele - 1D vector containing elevational position values (cm)
% lat - 1D vector containing lateral position values (cm)
% depth - 1D vector containing depth position values (cm)
%
% The position vectors should correspond to the intensity field such that
% intensity(1, 1, 1) is the intensity value at elevational position ele(1),
% lateral position lat(1), and depth position depth(1).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% OUTPUT:
% maxEle - elevational position of maximum intensity value
% maxLat - lateral position of max intensity value
% maxDepth - depth position of max intensity value
% These three variables give the 3D coordinates of the location of the
% maximum intensity value in the field.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% EXAMPLE:
% [maxEle, maxLat, maxDepth] = intensitypeak(kzk_intensity, kzk_ele, kzk_lat, kzk_depth);

if size(intensity, 1) ~= length(ele)
    error(['ERROR: The length of first dimension of the intensity matrix ',...
           'is not equal to the length of the elevational position vector. ',...
           'Please confirm that the intensity matrix has dimensions in ', ...
           'the order: elevational, lateral, depth.'])
end

if size(intensity, 2) ~= length(lat)
    error(['ERROR: The length of second dimension of the intensity matrix ',...
           'is not equal to the length of the lateral position vector. ',...
           'Please confirm that the intensity matrix has dimensions in ', ...
           'the order: elevational, lateral, depth.'])
end

if size(intensity, 3) ~= length(depth)
    error(['ERROR: The length of third dimension of the intensity matrix ',...
           'is not equal to the length of the depth position vector. ',...
           'Please confirm that the intensity matrix has dimensions in ', ...
           'the order: elevational, lateral, depth.'])
end

% Find 1D index of max intensity, then use ind2sub to convert to 3D
% indices.
[maxEleIndex, maxLatIndex, maxDepthIndex] = ind2sub(size(intensity),...
                               find(intensity == max(intensity(:))));
% Get position values (cm) from vector indices
maxEle = ele(maxEleIndex);
maxLat = lat(maxLatIndex);                         
maxDepth = depth(maxDepthIndex);          
end

