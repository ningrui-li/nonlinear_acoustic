KZK Initial Pressure Inputs - C5-2, 30 mm Focus
===============================================
The quarter-symmetric pressure inputs are located at `/luscinia/nl91/lab/nonlinearity/focus30mm/pressure_waveforms_median_qsymmetric.mat`.

These pressure inputs were generated from experimentally measured pressure signals made with the C5-2 using a hydrophone. The raw pressure input waveforms can be found in `/luscinia/kah67/102113_Verasonics_measurements/20131018/focus30/11pwr/p0p0mm/pressure_waveforms_median.mat`. 

These pressure inputs were slightly tilted, so they were first untilted using `untilt30mmPressureDataAnalytic.m` in `/luscinia/nl91/lab/nonlinearity/focus30mm/`. The tilt corrected pressure data was then massaged into a quarter-symmetric form by averaging the 4 corresponding positions of each quarter and setting the pressure values at each of those locations equal to the average. This was done using the MATLAB function `createQuarterSymmetry.m` in the same directory. Note that the `createQuarterSymmetry.m` function interpolates for the pressure values along the center axes in order to make sure that there are no huge discontinuities in the pressure data. This is done in the MATLAB script `run_create_qsymm_30mm.m`.

Finally, the pressure data was converted from double-precision to single-precision values in order to reduce the amount of data as well as decrease processing time.
