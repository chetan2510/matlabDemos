close all;
clc;
clear all;
% ----------------------------------
% STEP 1: Generating the sine wave  
% ----------------------------------

f1 = 1;
N  = 1000; % Number of Samples
Fs = 200; % Sampling Frequency in Hz % Sampling Time(Ts) = 1/Fs = 1/200 = 0.004 sec
t = ((-N/2):(N/2)-1)/Fs; % Time axis from -2.5 sec to 2.495  sec
y = sin(2*pi*f1*t); % generates the sine wave


subplot(4,2,1); % to generate a plot for 8 graphs
plot(t, y, 'g');
title("Sine wave");
xlabel("Time, [s]");
ylabel("Amplitude");
ylim([-1.5 1.5]), xlim([-2.5 2.5])
grid;

subplot(4,2,2);
plot(t, y, 'g');
title("Sine wave");
xlabel("Time, [s]");
ylabel("Amplitude");
ylim([-1.5 1.5]), xlim([-2.5 2.5])
grid;

% ------------------------------------------------------------------------------------
% Theory: These window functions are useful for noise measurements where better frequency
% resolution with moderate side lobes are required.
% Windowing the data makes sure that the ends match up while keeping 
% everything reasonably smooth; this greatly reduces the sort of "spectral leakage"

% As you can see in the plot the Hamming window's side lobes tends to reach zero
% which helps in cancelling the nearest side lobe.

% link: https://download.ni.com/evaluation/pxi/Understanding%20FFTs%20and%20Windowing.pdf

% ------------------------------
% STEP 2: Generating the windows
% ------------------------------

% IMPORTANT!!
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
windowLength = 3; % ( 3 seconds ), shown the exampe of 4 seconds in the tutorial!!

rectWindow = [zeros(1, 1*Fs) rectwin(windowLength*Fs)'  zeros(1, 1*Fs)];  % Rectangular Window
hammingWindow = [zeros(1, 1*Fs) hamming(windowLength*Fs)'  zeros(1, 1*Fs)]; % Hamming Window

% Hamming window plot
subplot(4,2,3);
plot(t, hammingWindow, 'r');
title("Hamming window");
xlabel("time");
ylabel("amplitude");
ylim([-1.5 1.5]), xlim([-2.5 2.5])

grid;

% Rectangular window plot
subplot(4,2,4);
plot(t, rectWindow, 'r');
title("Rectangular Window");
xlabel("time");
ylabel("amplitude");
ylim([-1.5 1.5]), xlim([-2.5 2.5])
grid;

% ------------------------------------------------------------
% STEP 3: Applying the windows on the respective sine wave
% ------------------------------------------------------------


hammedSignal = y.*hammingWindow; % using hamming window on sinosodal signal
subplot(4,2,5);
plot(t, hammedSignal, 'r');
title("Hammed signal");
xlabel("time");
ylabel("amplitude");
ylim([-1.5 1.5]), xlim([-2.5 2.5])
grid;


rectSignal = y.*rectWindow; % using rectangular window on sinosodal signal
subplot(4,2,6);
plot(t, rectSignal, 'r');
title("Rectanged signal");
xlabel("time");
ylabel("amplitude");
ylim([-1.5 1.5]), xlim([-2.5 2.5])
grid;

% ------------------------------------------------------------
% STEP 4: Finding the autocorrelation of the windowed signal
% ------------------------------------------------------------

% IMPORTANT CONCEPT:
% To normalise the y axis we are passing the 'biased' as one of the
% argument
[correlationOfHammedSignal, hammedLags] = xcorr(hammedSignal, 'biased');
[correlationOfRectSignal, rectLags] = xcorr(rectSignal, 'biased');

% IMPORTANT CONCEPT:
% to normalise the tau we have to multiply by 1/Fs 
tauH = hammedLags*1/Fs;
tausR = rectLags*1/Fs;

% correlated hammed signal plotting
subplot(4,2,7);
plot(tauH, correlationOfHammedSignal, 'r');
title("Auto correlated Hammed signal");
xlabel("\taus");
ylabel("x(t) * x(t)");

% correlated rectanged signal plotting


%% IMPORTANT NOTE!!
% Please note, now we cannot find the amplitude by (Amplitude)^2/2 as
% the window length has been changed which is resulting into 
% lesser components of the wave hence resulting into fewer 
% components for ACF.
subplot(4,2,8);
plot(tausR, correlationOfRectSignal, 'r');
title("Auto correlated Rectaged signal");
xlabel("\taus");
ylabel("x(t) * x(t)");

