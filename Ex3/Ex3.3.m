%% Ex3.3
clear all; clc
N = 1000; % Number of samples
f1 = 1; % Frequency of the sinewave
FS = 200; % sampling frequency
t = (-N/2:N/2-1)*1/FS; % time axis will begin from -1.5 to 1.5
x = sin(2*pi*f1*t); % generates the sine wave
noise = 0.05.*(randn(size(x)));
x = x + noise;

figure('Name','Sampling Random Process x(eta,t)')
subplot(3,2,1); 
plot(t, x, 'g');
title("Random process x(eta,t)");
xlabel("Time, [s]");
ylabel("Amplitude");
grid;

subplot(3,2,2)
% Dirac pulses is an infinite impulses train. Sampling with Dirac pulses is
% an element multiplication of signal to impulse train. Here delta dirac
% pulse is taken to avoid the infinitesmally reaching impulses.
%A Dirac sampled function is an impulse train with an envelope of the
%signal sampled. The graph of such a function seems digitalized.

%%
%IMPULSE TRAIN
% Sampling Frequency of dirac pulse: A pulse after every 10 instants
fs = 10;       
% As the signal is sampled, the pulse is taken as long as the signal.
% Element multiplication beyond the length of signal with impulse train is
% zero.
dirac = zeros (size (t));
%For 'delta' dirac pulse train, indexes of the dirac vector from 1st till end with
%space of 10 instants (to account for 10Hz frequency) is taken unity
dirac (1: fs : end) = 1;
stem(t, dirac);
ylim([-0.5 1.5]);
title('Dirac Pulses')
xlabel('time')
ylabel('Amplitude')
grid on;
%%
%DIRAC PULSE SAMPLING
y= x.*dirac;
% y(y==0)=nan; %to remove zero values within

subplot(3,2,[3:4])
stem(t,y)
title('Sampled Random Process y(eta,t) (stem graph)')
xlabel('time')
ylabel('Amplitude')
grid on;

subplot(3,2,[5:6])
plot(t,y, 'k')
title('Sampled Random Process y(eta,t)')
xlabel('time')
ylabel('Amplitude')
grid on;
%%
% Windows and windowed signals
figure('Name','ACF of y(eta,t) ')
subplot(4,2,[1:2])
plot(t,y,'m');
title('Sampled Random Process y(eta,t)')
xlabel('time')
ylabel('Amplitude')

windowLength = 3;

% % Hamming Window
ham = [zeros(1, 1*FS) hamming(windowLength*FS)'  zeros(1, 1*FS)]; % Generates hamming window of length same as no of samples as t
subplot(4,2,3);
plot(t, ham, 'r');
title("Hamming window");
xlabel("time");
ylabel("amplitude");
xlim([-2.5 2.5])
grid;
% % Rectangular window

rect = [zeros(1, 1*FS) rectwin(windowLength*FS)'  zeros(1, 1*FS)];% Generates rectangular window of length same as no of smaples as t
subplot(4,2,4);
plot(t, rect, 'b');
ylim([-2 2])
title("Rectangular Window");
xlabel("time");
ylabel("amplitude");
xlim([-2.5 2.5])
grid;

%Hammed signal
hammedSignal = y.*ham; 
subplot(4,2,5);
plot(t, hammedSignal, 'r');
title("Hammed signal");
xlabel("time");
ylabel("amplitude");
xlim([-2.5 2.5])
grid;

%Rectangled Signal
rectSignal = y.*rect; 
subplot(4,2,6);
plot(t, rectSignal, 'r');
title("Rectanged signal");
xlabel("time");
ylabel("amplitude");
xlim([-2.5 2.5])
grid;
%%
% ACF
[correlationOfHammedSignal, hammedLags] = xcorr(hammedSignal, 'biased');
[correlationOfRectSignal, rectLags] = xcorr(rectSignal, 'biased');

tauH = hammedLags*1/FS;
tausR = rectLags*1/FS;

% ACF by Hamming window
subplot(4,2,7);
plot(tauH, correlationOfHammedSignal, 'r');
title("Auto correlated Hammed signal");
xlabel("\taus");
ylabel("x(t) * x(t)");

% ACF by Rectangular Window
subplot(4,2,8);
plot(tausR, correlationOfRectSignal, 'b');
title("Auto correlated Rectangled signal");
xlabel("\taus");
ylabel("x(t) * x(t)");

% correlationOfHammedSignal(correlationOfHammedSignal==0)=nan;
% correlationOfRectSignal(correlationOfRectSignal==0)=nan;
%%
% Comparision plot
figure('Name', 'ACF via Hamming Window vs ACF via Rectangular Window');
stem(tauH, correlationOfHammedSignal,'b');
hold on
stem(tausR, correlationOfRectSignal,'*');
legend('ACF by Hamming Window','ACF by Rectangular Window')
xlabel("\taus")
ylabel("Sxx(\taus)")
grid on;


% % -------------------------------------------------------------------------