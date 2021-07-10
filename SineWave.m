% How to plot a sine wave. Important !!!!

% Number of points in a analog signal
numberOfSamples = 1000; 

% Is the number of points you are observing per second
samplingFrequency = 200;

% SIG#SYS#STOCHASTIC

% 1/200 = 0.005
%  1000/200 = 5
% AP
%  an = a + (n-1)*d
%  an = 0 + (1000 - 1) *1/200
%  an = 999/200 = 4.995
%  0. 0.005, 0.010.......
t = (0:numberOfSamples-1)*1/samplingFrequency;
%  What will be the end of the array t 999/200= 4.995

subplot(2, 1 , 1)
freq = 2;
y = sin(2*pi*freq*t);
plot(t, y, 'r');
% title("My sine plot");
% xlabel("Time axis");
% ylabel("Amplitude");
% 
subplot(2, 1 , 2)
freq = 1;
yf = sin(2*pi*freq*t);
plot(t, yf, 'b');