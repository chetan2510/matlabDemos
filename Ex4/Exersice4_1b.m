clc;
clear all;
close all;

%% Effect of Sampling frequecny on Power Spectral Density when it is less than Nyquist Smapling frequency
%
% When sampling frequency (Fs) becomes less than the Nyquist smapling
% frequency (Fs < 2*Fmax), the higher frequency component will disappear
% and newer/artificial frequency components will appear in the
% power spectral density plot  due to aliasing effect.

% Aliasing effect states that, there is a relationship between sampling frequency
% (Fs), maximum signal frequency (Fmax) and the new/artificial frequency component
% that appeared in the power spectral density (F), i.e., F = Fs - Fmax
% For example: if Fs = 25 and Fmax = 18, then F = Fs -Fmax = 25 - 18 = 7.

% So, to obtain sharp PSD curve, we have to increase number of samples or
% decrease sampling frequecy in time domain but it should not be less than
%  Nyquist sampling frequency.

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
% Artificial frequency will appear at [ samplingFrequency - maximumFrequencyOfFunction] => 30 -18 => 12

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
% Artificial frequency will appear at [ samplingFrequency - maximumFrequencyOfFunction] => 25 -18 => 7
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
% Artificial frequency will appear at [samplingFrequency - maximumFrequencyOfFunction] => 18 -18 => 0
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










