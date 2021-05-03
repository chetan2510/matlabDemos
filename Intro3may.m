%Introductory MATLAB Q/A Session_3rd May 2021

N = 500;

%Continous domain to digital domain, we need samplers, Fs
Fs = 100;

% Signal Attributes
f = 1;
%-250 to 250 (needed)
%start ? -125

%end ? 125
%500/2 = 250, 250/Fs = 2.5
t = (-N/2 : N/2)*(1/Fs);

%Signal
y = cos(2*pi*f*t);

plot(t, y)
xlabel('Time')
ylabel('Cos Wave')



