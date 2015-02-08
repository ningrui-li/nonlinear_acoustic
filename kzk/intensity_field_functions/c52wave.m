function max_waveform = c52wave(press_wave, t)
% function that captures only 4 cycles of the waveform used to compute the PII
pushFreqMHz = 2.37; %C52
pwave = press_wave(:, round(end/2), round(end/2));
centerfreq = GetFreqUsingFFT(pwave,t,pushFreqMHz);

%fs=5e9; %C52 sampling rate -- need to divid by 10 because of averaging
fs = (5e9)/10;
f=(1:size(press_wave,1))/size(press_wave,1)*fs;
fft_p2 = fft(press_wave(:, round(end/2), round(end/2)));
dTs = 1/fs;
dT = 1/centerfreq;
num_cycles = (1/(dTs*centerfreq))*4;

max_box = 0;
%moving boxcar averager to find max area
for k = 1:length(pwave)-round(num_cycles)
    box = mean((abs(pwave(k:k+round(num_cycles),:,:))));
    if box > max_box
        max_box = box;
        start = k;
    end
end

max_waveform = press_wave(start:start+round(num_cycles), :, :);
end
