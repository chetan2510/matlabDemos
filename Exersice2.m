% Exersice 2 begins!!
close all;
clear all;
% Plotting the sine wave
N = 600;
freq = 1;
Fs = 200;
t = (-N/2:N/2-1)*1/Fs;
y = sin(2*pi*freq*t) + 0.05.*(randn(size(t)));

% figure = figure('Position', [250, 250, 2000, 2000]);
subplot(4,2,1);
plot(t,y);

subplot(4,2,2);
plot(t,y);


% link: https://download.ni.com/evaluation/pxi/Understanding%20FFTs
%20and%20Windowing.pdf


%  Generating the windows
% Imprtant to keep the length as number of samples
ham = hamming(length(t));
subplot(4,2,3);
plot(t, ham)

rect = rectwin(length(t));
subplot(4,2,4);
plot(t, rect)


% Now we have to apply the windows on the given signal
% Important concept
hammedSignal = y.*ham';
subplot(4,2,5);
plot(t, hammedSignal);

rectSignal = y.*rect';
subplot(4,2,6);
plot(t, rectSignal); 

% Finding the a.c.f
[acfOfHammesSignaal, lags] = xcorr(hammedSignal, 'biased');

% IMPORTANT, this is the way you have to normalize it
tau = lags*1/Fs;
subplot(4,2,7);
plot(tau, acfOfHammesSignaal, 'r');

% Finding the a.c.f
% As acf of the signal by itself
%  what will be the amplitude of the acf in this case?? = (A*A)/2
[acfOfRectSignaal, lags_r] = xcorr(rectSignal, 'biased');

% IMPORTANT, this is the way you have to normalize it
tau_r = lags_r*1/Fs;
subplot(4,2,8);
plot(tau_r, acfOfRectSignaal, 'r');



%  Finding PDF of the random noise:

% We have to sort the noise

noise = randn(size(t));
sortedNoise = sort(noise);
lenghtOfTheSortedNoise = length(sortedNoise);

maxValue = max(sortedNoise);
minValue = min(sortedNoise);

% Will create my time axis:
%  Hit an trial to decide the spacing on the x-axis
x_axis =linspace(minValue, maxValue, length(noise)*0.5);
lengthOf_axis = length(x_axis);


% Defining the array of the pdf
pdf = zeros(size(x_axis));


for i = 1:lengthOf_axis - 1
    randomvariableLength = 0;
    for j = 1: lenghtOfTheSortedNoise
        if(sortedNoise(j) > x_axis(i) && sortedNoise(j) < x_axis(i+1))
            randomvariableLength = randomvariableLength + 1;
        end
    end
    
    pdf(i) = randomvariableLength/lenghtOfTheSortedNoise;
end

pdf(i+1) = length(find(sortedNoise > x_axis(i) & sortedNoise < x_axis(i)))/lenghtOfTheSortedNoise;


figure2=figure('Position', [150, 150, 2024, 2200]);
stem(x_axis, pdf);










