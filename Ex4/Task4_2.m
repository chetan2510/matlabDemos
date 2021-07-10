clc;
clear all;
close all;

f1 = 1;
N  = 1000; % Number of Samples
Fs = 200; % Sampling Frequency in Hz % Sampling Time(Ts) = 1/Fs = 1/200 = 0.004 sec
t = ((-N/2):(N/2)-1)/Fs; % Time axis from -2.5 sec to 2.495  sec
y = 1*sin(2*pi*f1*t) + 0.05.*(randn(size(t))); % sine wave

% IMPORTANT NEW!!
% In this case we are taking window length smaller than signal length, 
% This is to display the edges of the rectangular window and the hamming window.
% You should always match the length of the windows
% an = a + (n-1)*d
% zero padding , window length, zero padding
% [zeros(1, 200) hamming(601)'  zeros(1, 199)]  [-2.5 to -1.505, -1.5 to 1.5, 1.505 to 2.495] 
% we can simplify the length by:
% or zeros(1, 200) hamming(600)'  zeros(1, 200) [-2.5 to -1.505, -1.5 to 1.495, 1.5 to 2.495] 
% rectwin(windowLength*Fs + 1) including = 1.5

% Please note it is not dynamic it has been carefully choosen
% according to the window position
windowLength = 3; % ( 3 seconds ) show the exampe of 4 seconds!!

rectWindow = [zeros(1, 1*Fs) rectwin(windowLength*Fs)'  zeros(1, 1*Fs)];  % Rectangular Window
hammingWindow = [zeros(1, 1*Fs) hamming(windowLength*Fs)'  zeros(1, 1*Fs)]; % Hamming Window

%% Rectangular Window ACF & PSD
figure('Name','Rectangular Window ACF & PSD');
subplot(3,2,1)
plot(t,y),title('Sine Wave'),ylim([-1.5 1.5]), xlim([-2.5 2.5]), xlabel('Time (in sec)'), ylabel('Amplitude')
grid on

subplot(3,2,2)
plot(t,rectWindow),title('Rectangular Window'),ylim([-1.5 1.5]), xlim([-2.5 2.5]), xlabel('Time (in sec)'), ylabel('Amplitude')
grid on

sig1 = y.*rectWindow;
subplot(3,2,3)
plot(t,sig1),title('Windowed Signal'),ylim([-1.5 1.5]), xlim([-2.5 2.5]), xlabel('Time (in sec)'), ylabel('Amplitude')
grid on

[r1,lags1] = xcorr(sig1,'biased');
tau1 = lags1/Fs;

subplot(3,2,4)
plot(tau1,r1),title('ACF using Rectangular Window'), xlabel('Time difference \tau (in sec)'), ylabel('Amplitude')
grid on

% Power Spectral Density using Wiener Khintchine Theorem with Rectangular window
Rxxdft1 = abs(fftshift(fft(r1)))/N;
freq1 = -Fs/2:Fs/length(r1):Fs/2-(Fs/length(r1));
subplot(3,2,5)
plot(freq1,Rxxdft1),title({'Power Spectral Density using Wiener Khintchine Theorem ', 'with Rectangular window'}), xlabel('Frequency f (in Hz)'),ylabel('Spectral Power')
grid on

% Power Spectral Density using fftsquaring with Rectangular window
ftsquareMethod = abs(fftshift(fft(sig1)))/N;
ftsquareMethod = (ftsquareMethod.*ftsquareMethod);
freq2 = -Fs/2:Fs/length(sig1):Fs/2-(Fs/length(sig1));
subplot(3,2,6)
plot(freq2, ftsquareMethod)
title('fourier sqaure method'), title({'Power Spectral Density using FTS squared theorem ', 'with Rectangular window'}), xlabel('Frequency f (in Hz)'),ylabel('Spectral Power')
grid on

%% Hamming Window ACF & PSD
figure('Name','Hamming Window ACF & PSD');
subplot(3,2,1)
plot(t,y),title('Signal with Noise'),ylim([-1.5 1.5]), xlim([-2.5 2.5]), xlabel('Time (in sec)'), ylabel('Amplitude')
grid on
subplot(3,2,2)
plot(t,hammingWindow),title('Hamming Window'),ylim([-1.5 1.5]), xlim([-2.5 2.5]), xlabel('Time (in sec)'), ylabel('Amplitude')
grid on

sig2 = y.*hammingWindow;
subplot(3,2,3)
plot(t,sig2),title('Windowed Signal'),ylim([-1.5 1.5]), xlim([-2.5 2.5]), xlabel('Time (in sec)'), ylabel('Amplitude')
grid on

[r2,lags2] = xcorr(sig2,'biased');
tau2 = lags2/Fs;

subplot(3,2,4)
plot(tau2,r2),title('ACF using Hamming Window'), xlabel('Time difference \tau (in sec)'), ylabel('Amplitude')
grid on

% Power Spectral Density using Wiener Khintchine Theorem with Hamming window

Rxxdft2 = abs(fftshift(fft(r2)))/N;
freq2 = -Fs/2:Fs/length(r2):Fs/2-(Fs/length(r2));

subplot(3,2,5)
plot(freq2,Rxxdft2),title({'Power Spectral Density using Wiener Khintchine Theorem ', 'with Hamming window'}), xlabel('Frequency f (in Hz)'),ylabel('Spectral Power')
grid on

% Power Spectral Density using ftsquared with Hamming window
ftsquareMethod = abs(fftshift(fft(sig2)))/N;
ftsquareMethod = (ftsquareMethod.*ftsquareMethod);
freq2 = -Fs/2:Fs/length(sig2):Fs/2-(Fs/length(sig2));
subplot(3,2,6)
plot(freq2, ftsquareMethod)
title('fourier sqaure method'), title({'Power Spectral Density using FTS squared theorem ', 'with Hamming window'}), xlabel('Frequency f (in Hz)'),ylabel('Spectral Power')
grid on;










