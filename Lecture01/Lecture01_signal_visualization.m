clear;
clc;
close all;

%% Task 1 - Creating Sine wave
t = 0:0.001:1;
A = 1;
f = 5;

y = A * sin(2*pi*f*t);
plot(t, y);

title('5 Hz Sine Wave');
xlabel('Time (seconds)');
ylabel('Amplitude');
grid on;

%% Task 2 - Frequency Comparison
y2 = sin(2*pi*2*t);
y5 = sin(2*pi*5*t);
y10 = sin(2*pi*10*t);
figure;

subplot(3,1,1);
plot(t, y2);
title('2 Hz Sine Wave');
grid on;

subplot(3,1,2);
plot(t, y5);
title('5 Hz Sine Wave');
grid on;

subplot(3,1,3);
plot(t, y10);
title('10 Hz Sine Wave');
grid on;

saveas(gcf, 'frequency_comparison.png');

%% Task 3 - Amplitude Comparison

f_amp = 5;
y_amp05 = 0.5 * sin(2*pi*f_amp*t);
y_amp1 = 1 * sin(2*pi*f_amp*t);
y_amp2 = 2 * sin(2*pi*f_amp*t);
figure;

subplot(3,1,1);
plot(t, y_amp05);
title('Amplitude = 0.5');
grid on;

subplot(3,1,2);
plot(t, y_amp1);
title('Amplitude = 1');
grid on;

subplot(3,1,3);
plot(t, y_amp2);
title('Amplitude = 2');
grid on;

saveas(gcf, 'amplitude_comparison.png');
%% Task 4 - Clean and Noisy Signal

clean_signal = sin(2*pi*5*t);
noise = 0.3 * randn(size(t));
noisy_signal = clean_signal + noise;

figure;

subplot(2,1,1);
plot(t, clean_signal);
title('Clean Signal');
grid on;

subplot(2,1,2);
plot(t, noisy_signal);
title('Noisy Signal');
grid on;

saveas(gcf, 'clean_vs_noisy_signal.png');
