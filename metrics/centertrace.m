function [] = centertrace(OutputName, depth, varargin)
% function [] = centertrace(OutputName, intensity1, i1_depth, i1_name, intensity2, i2_depth, i2_name, ...)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% INPUT:
% OutputName - file name of output center trace plot
% intensity1 - 3D intensity field following conventions used in fem tools where
% axial extends into -z, lateral extends into +y, and elev extends into -x
% i1_depth - vector of depth values at which intensity values are
% calculated (ex. 0:-0.5:-30)
% i1_name (String) - name of intensity field (ex. 'KZK Sim C5-2 30mm Focus')
% There can be a variable number of intensity inputs, as long as all of the
% intensity inputs contain the 3D intensity matrix, the vector of depth
% values, and the name (in that order).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% OUTPUT:
% PNG of plot is saved to CWD with name OutputName.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% EXAMPLE:
% centertrace('intensity_centertrace.png', kzk_intensity, kzk_depth, 'KZK
% Sim, C5-2, 30 mm Focus', field_intensity, field_depth, 'Field II Sim,
% 'C5-2', 30 mm Focus')



end

