% Creating an array
array = [1 2 2; 10 8 8; 8 7 9];
% clc and clear all

% String initialisation
string = 'Hello World';

% Print
disp(array);

%  For loop
% for i =1:10
%     disp(i);
%     
% end

% Subtract
a = [1 2 3; 9 8 7];
b = [5 8 9; 8 7 4];
sub = a - b;


% Transposing
a = a';

w = 1:10;
divide = 1/3;
value = 2^2;
disp(size(w));

% linspace move from 0 to 100 with 200 points in between
% an = a + (n-1)*d)
% 100 = 0 + (200-1)*d
% 100/199 = d => 0.5025
x = linspace(0, 100, 200);
y = sin(x);
n = cos(x);

% rows, collumns, position
subplot(2, 1 , 1)
plot(x, y, 'r');
title("Sine wave")
xlabel("Time")
ylabel("Amplitude")

% X axis and then Y axis, can play with the axis
axis([0 100 -4 4])

% rows, collumns, position
subplot(2, 1 , 2)
plot(x, n, 'b');
title("Cos wave")
xlabel("Time")
ylabel("Amplitude")






