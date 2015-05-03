%% make_loads_script
% Example script for calling kzk_make_loads to create the loads file from
% the intensity fields.
clear; clf;


element_vol = .02*.02*.025;
a = {'0.005', '0.3', '0.45', '1.0', '1.5'};
B = {'0', '3.5', '7'};

addpath /luscinia/nl91/nonlinear_acoustic/dyna/loads/

%% 70 mm focal depth
cd focus70mm
axialLim = 52;   % mm
eleLim = 6;      % mm
latLim = 25;     % mm
Fnum = 3.5;    
focalDepth = 70; % mm
for beta = B
    % go into each nonlinear coefficient (B) subdirectory
    eval(sprintf('cd B_%s', char(beta)));
    
    for alpha = a
        % go into each attenuation coefficient (a) subdirectory
        eval(sprintf('cd a_%s', char(alpha)));
        
        % call the kzk_to_dyna file to make interpolate intensity field and
        % make pseudo-dyna*.mat file
        eval(sprintf(['kzk_to_dyna(''/luscinia/nl91/nonlinear_acoustic/kzk/',...
                 'field_ii_c52_focus70mm/B_%s/a_%s_B_%s/',...
                 'c52_70mm_intensity_field_field_ii_pressure_input.mat'', %f, %d, %d, %d, %.1f, %d)'],...
                 char(beta), char(alpha), char(beta), str2num(char(alpha)), latLim, eleLim, axialLim, Fnum, focalDepth))
             
        % call the kzk_make_loads function to make PointLoads file
        eval(sprintf(['kzk_make_loads(''dyna-kzk.mat'', %f)'],...
                 element_vol))
   
        cd ..
    end
    cd ..
end

cd ..

%% 30 mm focal depth
a = {'0.005'};
B = {'0', '3.5', '7'};
axialLim = 52;   % mm
eleLim = 6;      % mm
latLim = 12;     % mm
Fnum = 2.6;    
focalDepth = 30; % mm

cd focus30mm

for beta = B
    % go into each nonlinear coefficient (B) subdirectory
    eval(sprintf('cd B_%.1f', str2num(char(beta))));
    
    for alpha = a
        % go into each attenuation coefficient (a) subdirectory
        eval(sprintf('cd a_%.3f', str2num(char(alpha))));
        
        % call the kzk_to_dyna file to make interpolate intensity field and
        % make pseudo-dyna*.mat file
        eval(sprintf(['kzk_to_dyna(''/luscinia/nl91/nonlinear_acoustic/kzk/',...
                 'field_ii_c52_focus30mm/B_%s/a_%s_B_%s/',...
                 'c52_30mm_intensity_field_field_ii_pressure_input.mat'', %f, %d, %d, %d, %.1f, %d)'],...
                 char(beta), char(alpha), char(beta), str2num(char(alpha)), latLim, eleLim, axialLim, Fnum, focalDepth))
             
        % call the kzk_make_loads function to make PointLoads file
        eval(sprintf(['kzk_make_loads(''dyna-kzk.mat'', %f)'],...
                 element_vol))
   
        cd ..
    end
    cd ..
end

cd ..