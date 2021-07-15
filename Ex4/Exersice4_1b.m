clc;
clear all;
close all;

%% Effect of Sampling frequecny on Power Spectral Density when it is less than Nyquist Sampling frequency

% Sampling is done to convert a continous time signal CT (t) to a discreet 
% time signal DT (nT).
% Sampling a continuous time signal leads to a repeated spectrum in
% frequency domain. And the spectrum is repeated every Fs Hz.
% When sampling frequency (Fs) becomes less than the Nyquist sampling
% frequency (Fs < 2*Fmax), the repeated frequency bands (that repeat every Fs Hz)
% in frequency domain will interfere
% with eachother, falsely plotted at frequency spectrum in PSD. This is called aliasing. 
% Such a sampled signal with false frequencies can not provide the 
% original signal on reconstructing the signal by its sampled version due
% to the involvement of additional frequencies.
% The consequence of Aliasing effect 
% is the need of Sampling theorem which prevents it. A minimum Fs
% is decided by it to prevent frequency bands repeating.

% Aliasing effect states that, there is a relationship between sampling frequency
% (Fs), maximum signal frequency (Fmax) and the repeated frequency component
% that appeared in the power spectral density (F), i.e., F = Fs - Fmax
% For example: if Fs = 25 and Fmax = 18, then F = Fs -Fmax = 25 - 18 = 7.

% Conclusion: For sampling a continous time signal, the minimum sampling
% frequency to be used is dictated by Sampling
% theorem and the maximum sampling frequency is dictated by the speed of
% the processor that can be afforded in real time applications. Ideally,
% the higher the sampling frequency the better the reconstruction of 
% original signal from its sampled version.

f1 = 5;
f2 = 18;
N  = 500; % Number of Samples
Fs = 50;
t = ((-N/2):(N/2)-1)/Fs;
y = 1*sin(2*pi*f1*t) + 0.6*cos(2*pi*f2*t); % sine wave
figure('Name','Sinosoidal wave with different sampling frequencies');
subplot(4,2,1);
plot(t,y);
title('Sampling Frequency 50 hz'), xlim([-2 2]), ylim([-1.5 1.5]), xlabel('Time (in sec)'), ylabel('Amplitude')
grid on;

%% Calculating power spectral density using Wiener Khintchine Theorem
[r1,lags1] = xcorr(y,'biased');
Rxxdft1 = abs(fftshift(fft(r1)))/N; % divind by N to normalize
freq1 = -Fs/2:Fs/length(r1):Fs/2-(Fs/length(r1)); % normalized x axis
subplot(4,2,2);
plot(freq1, Rxxdft1);
title({'Power Spectral Density using Wiener Khintchine Theorem'}), xlabel('Frequency f (in Hz)'),ylabel('Spectral Power')
grid on;


%% Changing the sampling frequency to 30
% Repeated frequency will appear at [ samplingFrequency - maximumFrequencyOfFunction] => 30 -18 => 12

Fs = 30; % Sampling Frequency in Hz % Sampling Time(Ts) = 1/Fs = 1/250 = 0.004 sec
t = ((-N/2):(N/2)-1)/Fs; % Time axis from -2 sec to 2 sec or, t = (-500:499)/250 = (-500:1:499)/250 = -2:0.004:1.996
y = 1*sin(2*pi*f1*t) + 0.6*sin(2*pi*f2*t); % sine wave
subplot(4,2,3);
plot(t,y);
title('Sampling Frequency 30 hz'), xlim([-2 2]), ylim([-1.5 1.5]), xlabel('Time (in sec)'), ylabel('Amplitude')
grid on;
[r1,lags1] = xcorr(y,'biased');
Rxxdft1 = abs(fftshift(fft(r1)))/N;
freq1 = -Fs/2:Fs/length(r1):Fs/2-(Fs/length(r1));
subplot(4,2,4);
plot(freq1, Rxxdft1);
title({'Power Spectral Density using Wiener Khintchine Theorem'}), xlabel('Frequency f (in Hz)'),ylabel('Spectral Power')
grid on;

%% Changing the sampling frequency to 25
% Repeated frequency will appear at [ samplingFrequency - maximumFrequencyOfFunction] => 25 -18 => 7
Fs = 25; % Sampling Frequency in Hz % Sampling Time(Ts) = 1/Fs = 1/250 = 0.004 sec
t = ((-N/2):(N/2)-1)/Fs; % Time axis from -2 sec to 2 sec or, t = (-500:499)/250 = (-500:1:499)/250 = -2:0.004:1.996
y = 1*sin(2*pi*f1*t) + 0.6*sin(2*pi*f2*t); % sine wave
subplot(4,2,5);
plot(t,y);
title('Sampling Frequency 25 hz'), xlim([-2 2]), ylim([-1.5 1.5]), xlabel('Time (in sec)'), ylabel('Amplitude')
grid on;
[r1,lags1] = xcorr(y,'biased');
Rxxdft1 = abs(fftshift(fft(r1)))/N;
freq1 = -Fs/2:Fs/length(r1):Fs/2-(Fs/length(r1));
subplot(4,2,6);
plot(freq1, Rxxdft1);
title({'Power Spectral Density using Wiener Khintchine Theorem'}), xlabel('Frequency f (in Hz)'),ylabel('Spectral Power')
grid on;


%% Changing the sampling frequency to 18
% Repeated frequency will appear at [samplingFrequency - maximumFrequencyOfFunction] => 18 -18 => 0
% Only the 5 hz frequency component will appear the 18 Hz component will
% disappear
Fs = 18; % Sampling Frequency in Hz % Sampling Time(Ts) = 1/Fs = 1/250 = 0.004 sec
t = ((-N/2):(N/2)-1)/Fs; % Time axis from -2 sec to 2 sec or, t = (-500:499)/250 = (-500:1:499)/250 = -2:0.004:1.996
y = 1*sin(2*pi*f1*t) + 0.6*sin(2*pi*f2*t); % sine wave
subplot(4,2,7);
plot(t,y);
title('Sampling Frequency 18 hz'), xlim([-2 2]), ylim([-1.5 1.5]), xlabel('Time (in sec)'), ylabel('Amplitude')
grid on;
[r1,lags1] = xcorr(y,'biased');
Rxxdft1 = abs(fftshift(fft(r1)))/N;
freq1 = -Fs/2:Fs/length(r1):Fs/2-(Fs/length(r1));
subplot(4,2,8);
plot(freq1, Rxxdft1);
title({'Power Spectral Density using Wiener Khintchine Theorem'}), xlabel('Frequency f (in Hz)'),ylabel('Spectral Power')
grid on;










