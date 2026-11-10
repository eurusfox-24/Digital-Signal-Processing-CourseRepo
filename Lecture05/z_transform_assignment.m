
clear; clc; close all;

% Part 1: Original signal
x = [1 2 1];
n = 0:length(x)-1;

% Delay the signal by one sample
xDelayed = [0 x];
nDelayed = 0:length(xDelayed)-1;

% Plot original and delayed signals
figure;

subplot(2,1,1);
stem(n, x, 'filled');
title('Original Signal x[n]');
xlabel('Sample n');
ylabel('Amplitude');
grid on;

subplot(2,1,2);
stem(nDelayed, xDelayed, 'filled');
title('One-Sample Delay x[n-1]');
xlabel('Sample n');
ylabel('Amplitude');
grid on;



%% Part 2: System with one-sample delay

% Coefficients of H(z) = 0.5 + 0.5z^(-1)
b = [0.5 0.5];
a = 1;

% Add one zero to show the final output sample
xInput = [x 0];

% Apply the filter
y = filter(b, a, xInput);
nOutput = 0:length(y)-1;

% Plot input and output
figure;

subplot(2,1,1);
stem(nOutput, xInput, 'filled');
title('Input x[n]');
xlabel('Sample n');
ylabel('Amplitude');
grid on;

subplot(2,1,2);
stem(nOutput, y, 'filled');
title('Output y[n]');
xlabel('Sample n');
ylabel('Amplitude');
grid on;

% Display output values
disp('Output samples:');
disp(y);


%% Part 3: Modified filter (Question 6)

% New coefficients
b = [0.8 0.2];
a = 1;

% Apply modified filter
yModified = filter(b, a, xInput);

% Plot modified output
figure;

subplot(2,1,1);
stem(nOutput, xInput, 'filled');
title('Input x[n]');
xlabel('Sample n');
ylabel('Amplitude');
grid on;

subplot(2,1,2);
stem(nOutput, yModified, 'filled');
title('Modified Output - 80/20 Filter');
xlabel('Sample n');
ylabel('Amplitude');
grid on;

% Display modified output
disp('Modified output samples:');
disp(yModified);

