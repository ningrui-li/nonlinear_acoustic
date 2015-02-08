% script  used to create the 3D array of intensity values

addpath /luscinia/kah67/Nonlinear_Sims/3DSims/3d_functions
addpath /raidScratch/kah67/3DSims/Verasonics_Sims/
addpath /luscinia/kah67/102113_Verasonics_measurements/routines
load /luscinia/kah67/102113_Verasonics_measurements/20131018/focus30/11pwr/p0p0mm/pressure_waveforms_median

nX = size(lat,1);
nY = size(ele,1);
nTau = size(t,2);
rho0 = 1030;
c0 = 1540;

nRun=sizeOfFile('P.dat')/(nX*nY*nTau*8)
depth = zeros(1,nRun);
intensity = zeros(nRun, nX, nY);

for n=1:1:nRun
  fprintf('%d out of %d\n', n, nRun);
  pout=readGenoutSlice('P.dat',n-1,nX*nY*nTau);   
  tmp = reshape(pout,nTau,nX,nY);
  max_wave = c52wave(tmp,t);
  psquare = (1/size(max_wave,1)).*sum((max_wave.^2)./(rho0*c0).*(1/100).^2);
  psquare = squeeze(psquare);
  intensity(n,:,:)= psquare;
 %maxPressSquared(n) = max(psquare(round(nX/2), round(nY/2)));
end

% need to remove first two depth planes because depthStep has only N depth
% values, while readGenoutSlice will give N+2 depth planes.
intensity = intensity(3:end, :, :);

save -v7.3 c52_intensity_vals_30_linear_comparison nRun intensity
