clc;
clear all;
close all;

f1 = 5;
f2 = 18;
N  = 2000; % Number of Samples
Fs = 1000; % sampling frequency
t = ((-N/2):(N/2)-1)/Fs; % start from -1
y = 1*sin(2*pi*f1*t) + 0.6*cos(2*pi*f2*t); % sinosoidal wave
figure('Name','Sinosoidal wave with different sampling frequencies');
subplot(3,2,1);
plot(t,y);
title('Sampling Frequency 1000 hz'), xlim([-1 1]), ylim([-1.5 1.5]), xlabel('Time (in sec)'), ylabel('Amplitude')
grid on;

%% Calculating power spectral density using Wiener Khintchine Theorem (Finding the PSD using ACF)
[r1,lags1] = xcorr(y,'biased');
tau1 = lags1/Fs;

% Taking fourier transform of acf will result in PSD.
Rxxdft1 = abs(fftshift(fft(r1)))/N; % divind by N to normalize

% interval = 1000/3999 = 0.2500
% -500 + interval and so on
freq1 = -Fs/2:Fs/length(r1):Fs/2-(Fs/length(r1)); % normalized x axis or normalization of frequency axis, to have  a good plot
subplot(3,2,2);
plot(freq1, Rxxdft1);
title({'Power Spectral Density using Wiener Khintchine Theorem'}), xlabel('Frequency f (in Hz)'),ylabel('Spectral Power')
grid on;

%% Changing the sampling frequency to 500 HZ

Fs = 500; % sampling frequency
t = ((-N/2):(N/2)-1)/Fs;
y = 1*sin(2*pi*f1*t) + 0.6*sin(2*pi*f2*t); % sinosoidal wave
subplot(3,2,3);
plot(t,y);
title('Sampling Frequency 500 hz'), xlim([-2 2]), ylim([-1.5 1.5]), xlabel('Time (in sec)'), ylabel('Amplitude')
grid on;

% calculating power spectral density using Wiener Khintchine Theorem
[r1,lags1] = xcorr(y,'biased');
tau1 = lags1/Fs;
Rxxdft1 = abs(fftshift(fft(r1)))/N; % divind by N to normalize
freq1 = -Fs/2:Fs/length(r1):Fs/2-(Fs/length(r1)); % normalized x axis
subplot(3,2,4);
plot(freq1, Rxxdft1); % Match the length
title({'Power Spectral Density using Wiener Khintchine Theorem'}), xlabel('Frequency f (in Hz)'),ylabel('Spectral Power')
grid on;


%% Changing the sampling frequency to 200 Hz

Fs = 200; % sampling frequency
t = ((-N/2):(N/2)-1)/Fs;
y = 1*sin(2*pi*f1*t) + 0.6*sin(2*pi*f2*t); % sinosoidal wave
subplot(3,2,5);
plot(t,y);
title('Sampling Frequency 200 hz'), xlim([-2 2]), ylim([-1.5 1.5]), xlabel('Time (in sec)'), ylabel('Amplitude')
grid on;

% calculating power spectral density using Wiener Khintchine Theorem
[r1,lags1] = xcorr(y,'biased');
tau1 = lags1/Fs;
Rxxdft1 = abs(fftshift(fft(r1)))/N; % divind by N to normalize
freq1 = -Fs/2:Fs/length(r1):Fs/2-(Fs/length(r1)); % normalized x axis
subplot(3,2,6);
plot(freq1, Rxxdft1);
title({'Power Spectral Density using Wiener Khintchine Theorem'}), xlabel('Frequency f (in Hz)'),ylabel('Spectral Power')
grid on;

%% Effect of changing the number of samples and the sampling frequency on Power Specral Density 
% 
% (i) If we decrease the sampling frequency in time domain keeping the number
% of samples constant, the distance between the sample points in the
% frequency domain decreases. 
% Therefore, by decreasing sampling frequency in time domain, we can
% obtain much sharper plot of the power spectral density.
%
% (ii) If we increase the number of samples keeping the sampling frequency in
% time domain constant, the distance between the sample points in the
% frequency domain decreases. Therefore by 
% increasing the number of samples, we can obtain much sharper plot 
% of the power spectral density.


