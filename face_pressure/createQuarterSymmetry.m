function [pressure_qsym] = createQuarterSymmetry(pressure)
% function [pressure_qsym] = createQuarterSymmetry(pressure)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% INPUT:
% pressure - 3D matrix of pressure values with dimensions 
% time x lateral x elevational (in that order)
% OUTPUT:
% pressure_qsym - 3D matrix of pressure values that are quarter symmetric 
% along lateral and elevational axes for each time plane. The quarter
% symmetry is implemented by averaging pressure values at analogous positions
% of each quadrant.
    
pressure_qsym = pressure;
    
% note that t, lat, and ele do not give the positional and time
% information of the pressure points. they are just the LENGTHS of the
% matrix dimensions.

% t, lat, and ele ARE NOT the same t, lat, and ele of
% the pressure_waveforms_median_untilted.mat file. 
    
t   = size(pressure, 1);
lat = size(pressure, 2);
ele = size(pressure, 3);
    
% starting from time value 2681 because pressure planes are approximately
% negligible before this time step. 
% probably need to replace this with a non-hardcoded value.
for time = 2681:t
    if (~isequal(squeeze(pressure(time, :, :)), zeros(lat, ele)))
        for later = 1:floor(lat/2)
            for elev = 1:floor(ele/2)
                % take quarter symmetric points from each time plane and
                % average them. then replace the values of those 4 points
                % with their calculated average.

                % matlab whyyyyyyyyyyyyyyyyyyyyyyyyy
                % do you have arrays starting from index 1 instead of 0 :(
                pressureMean = mean([pressure(time, later,       elev),...
                                     pressure(time, lat-later+1, elev),...
                                     pressure(time, later,       ele-elev+1),... 
                                     pressure(time, lat-later+1, ele-elev+1)]);


                pressure_qsym(time, later,       elev) = pressureMean;
                pressure_qsym(time, lat-later+1, elev) = pressureMean;
                pressure_qsym(time, later,       ele-elev+1) = pressureMean;
                pressure_qsym(time, lat-later+1, ele-elev+1) = pressureMean;
            end
        end
            
        % interpolate along lateral axis pressure values by averaging
        % pressure values at locations directly adjacent to each axis
        % location.
        eleCenterAxis = round(ele/2);
        for later = 1:lat
            pressure_qsym(time, later, eleCenterAxis) = mean([pressure_qsym(time, later, eleCenterAxis+1),...
                                                              pressure_qsym(time, later, eleCenterAxis-1)]);
        end
        
        % interpolate along elevational axis pressure values
        latCenterAxis = round(lat/2);
        for elev = 1:ele
            pressure_qsym(time, latCenterAxis, elev) = mean([pressure_qsym(time, latCenterAxis+1, elev),...
                                                             pressure_qsym(time, latCenterAxis-1, elev)]);
        end
        
        % interpolate center pressure value (where center lateral
        % and center elevational axes intersect)
        pressure_qsym(time, eleCenterAxis, latCenterAxis) = mean([pressure_qsym(time, latCenterAxis+1, eleCenterAxis+1),...
                                                                  pressure_qsym(time, latCenterAxis-1, eleCenterAxis+1),...
                                                                  pressure_qsym(time, latCenterAxis+1, eleCenterAxis-1),...
                                                                  pressure_qsym(time, latCenterAxis-1, eleCenterAxis-1)]);
    end
    
    if (mod(time, 500) == 0)
        fprintf('%d time planes completed out of %d\n', time, t)
    end
end

end