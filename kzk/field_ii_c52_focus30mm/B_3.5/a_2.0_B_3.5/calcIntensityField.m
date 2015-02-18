%% Kristina's method for calculating intensity planes
addpath /luscinia/kah67/Nonlinear_Sims/3DSims/3d_functions
addpath /luscinia/kah67/102113_Verasonics_measurements/routines
addpath ../../../intensity_field_functions/
load /luscinia/kah67/102113_Verasonics_measurements/20131018/focus30/11pwr/p0p0mm/pressure_waveforms_median
load depthVals.mat


nX = size(lat,1);
nY = size(ele,1);
nTau = size(t,2);

rho0 = 1030;
c0 = 1540;

nRun=sizeOfFile('P.dat')/(nX*nY*nTau*8)

intensity = zeros(nRun, nX, nY);

for n=1:1:nRun
  fprintf('%d out of %d\n', n, nRun)
  pout=readGenoutSlice('P.dat',n-1,nX*nY*nTau);   
  tmp = reshape(pout,nTau,nX,nY);
  max_wave = c52wave(tmp,t);
  psquare = (1/size(max_wave,1)).*sum((max_wave.^2)./(rho0*c0).*(1/100).^2);
  psquare = squeeze(psquare);
  intensity(n,:,:)= psquare;
 %maxPressSquared(n) = max(psquare(round(nX/2), round(nY/2)));
end

depth = depthStep;

save c52_30mm_intensity_field_field_ii_pressure_input.mat intensity lat ele depth nRun
