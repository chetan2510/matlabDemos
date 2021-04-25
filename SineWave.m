% % How to plot a sine wave. Important !!!!
% 
% % Number of points in a analog signal
% numberOfSamples = 1000; 
% 
% % Is the number of points you are observing per second
% samplingFrequency = 200;
% 
% %  1000/200 = 5
% %  an = a + (n-1)*d
% %  5 = 0 + (1000 -1 )* d
% %  d = 0.005
% t = (0:numberOfSamples - 1)*1/samplingFrequency;
% 
% % Wrong method
% % an = a + (n-1)*d
% % 1000 = 0 + (n -1)*1/200;
% % so number of samples are increased 
% % timeSecondWay = (0:1/samplingFrequency:numberOfSamples);
% freq = 2;
% 
% y = sin(2*pi*freq*t);
% 
% plot(t, y, 'b');
% title("My sine plot");
% xlabel("Time axis");
% ylabel("Amplitude");
% 
