clear all;
clc;
close all;
% ------------------------------------------
% STEP 1: Generating the sine wave with noise 
% ------------------------------------------

f1 = 1;
N  = 1000; % Number of Samples
Fs = 200; % Sampling Frequency in Hz % Sampling Time(Ts) = 1/Fs = 1/200 = 0.004 sec
t = ((-N/2):(N/2)-1)/Fs; % Time axis from -2.5 sec to 2.495  sec
y = sin(2*pi*f1*t); % generates the sine wave

noise = 0.05.*(randn(size(y)));

% Adding noise to the signal
y = y + noise;

figure1=figure('Position', [200, 200, 2024, 2200]); % to have a bigger plot on

subplot(4,2,1); % to generate a plot for 8 graphs
plot(t, y, 'g');
title("Sine wave");
xlabel("Time, [s]");
ylabel("Amplitude");
grid;

subplot(4,2,2);
plot(t, y, 'g');
title("Sine wave");
xlabel("Time, [s]");
ylabel("Amplitude");
grid;

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
grid;

% Rectangular window plot
subplot(4,2,4);
plot(t, rectWindow, 'b');
title("Rectangular Window");
xlabel("time");
ylabel("amplitude");
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
grid;


rectSignal = y.*rectWindow; % using rectangular window on sinosodal signal
subplot(4,2,6);
plot(t, rectSignal, 'r');
title("Rectanged signal");
xlabel("time");
ylabel("amplitude");
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
subplot(4,2,8);
plot(tausR, correlationOfRectSignal, 'b');
title("Auto correlated Rectaged signal");
xlabel("\taus");
ylabel("x(t) * x(t)");

% Calculating the Pdf of noise

% Step 1: Sortig the noise
sortedNoise = sort(noise);
lengthOfSortedNoise = length(sortedNoise);

% Step 2: Finding the maximum and minimum value of noise
maxValueInNoise = max(sortedNoise);
minValueInNoise = min(sortedNoise);

% Step 3: Creating the x-axis
xaxis = linspace(minValueInNoise, maxValueInNoise, length(noise)*0.5);
lenghtOfXAxis = length(xaxis);

% Step 4: Creating pdf array, initializing the values with zero
pdf = zeros(size(xaxis));
% Step 5: Calculating the probability

for i = 1:lenghtOfXAxis - 1
    randomVariableLength = 0;
    for j = 1: lengthOfSortedNoise
        if(sortedNoise(j) > xaxis(i) && sortedNoise(j) < xaxis(i + 1))
            randomVariableLength = randomVariableLength + 1; %incrementing the length of the random variable
        end
    end
    pdf(i) = randomVariableLength/lengthOfSortedNoise; % calculates probability of the random variable
end

pdf(i+1) = length(find(sortedNoise > xaxis(i) & sortedNoise < xaxis(i)))/ lengthOfSortedNoise;
figure2=figure('Position', [200, 200, 2024, 2200]); % to have a bigger plot on
stem(xaxis, pdf);
xlim([-0.2 0.2]);
title("PDF of noise");
xlabel("Random Noise");
ylabel("Probability");
