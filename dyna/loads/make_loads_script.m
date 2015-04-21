%% make_loads_script
% Example script for calling kzk_make_loads to create the loads file from
% the intensity fields.
clear; clf;


element_vol = .02*.02*.025;
a = {'0.005', '0.3', '0.45', '1.0', '1.5'};
B = {'0', '3.5', '7'};

cd focus70mm

addpath /luscinia/nl91/nonlinear_acoustic/dyna/loads/

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
                 'c52_70mm_intensity_field_field_ii_pressure_input.mat'', %f)'],...
                 char(beta), char(alpha), char(beta), str2num(char(alpha))))
             
        % call the kzk_make_loads function to make PointLoads file
        eval(sprintf(['kzk_make_loads(''dyna-kzk.mat'', %f)'],...
                 element_vol))
   
        cd ..
    end
    cd ..
end

cd ..
