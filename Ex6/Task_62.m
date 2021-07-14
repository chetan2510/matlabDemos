clear all; close all;clc

syms tau

%Possible outcomes
x = [-1 0 1];

%Probabilities of occurance of outcomes when i,j= 1,2,3

a = (1/3)*(1 + 2*(exp(-abs(tau)))); % at i==j

b = (1/3)*(1 - (exp(-abs(tau)))); % at i=!j

%We know by page 43
% when probability of one event occuring is 1/3 in part (a)


acf = 0

for i = 1:3
    for j = 1:3
        if i == j
            acf = acf + x(i)*x(j)*a*(1/3);
        else
            acf = acf + x(i)*x(j)*b*(1/3);
        end
    end
end

acf

fplot(tau,acf);
xlabel('\tau') 
ylabel('Sxx')
title('ACF Sxx(\tau)')


