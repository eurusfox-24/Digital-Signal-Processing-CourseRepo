% Task 1 - Create the Original Signal

f = 10;                 % Signal frequency in Hz
t = 0:0.001:1;          % Time vector from 0 to 1 second
x = sin(2*pi*f*t);      % 10 Hz sine wave

% Plot the signal
figure;
plot(t, x, 'LineWidth', 1.5);

title('Original 10 Hz Sine Wave');
xlabel('Time (seconds)');
ylabel('Amplitude');

grid on;
legend('10 Hz sine wave');

% Save the figure
saveas(gcf, 'original_signal.png');

% Task 2 - Sampling at 15 Hz

fs = 15;                % Sampling frequency
ts = 0:1/fs:1;          % Sample times
xs = sin(2*pi*f*ts);    % Sampled signal

figure;
plot(t, x, 'LineWidth', 1.5);
hold on;

stem(ts, xs, 'filled');

title('10 Hz Signal Sampled at 15 Hz');
xlabel('Time (seconds)');
ylabel('Amplitude');

legend('Original signal', 'Sampled points');
grid on;

saveas(gcf, 'sampling_15Hz.png');

% Sampling at 20 Hz

fs = 20;
ts = 0:1/fs:1;
xs = sin(2*pi*f*ts);

figure;
plot(t, x, 'LineWidth', 1.5);
hold on;

stem(ts, xs, 'filled');

title('10 Hz Signal Sampled at 20 Hz');
xlabel('Time (seconds)');
ylabel('Amplitude');

legend('Original signal', 'Sampled points');
grid on;

saveas(gcf, 'sampling_20Hz.png');

% Sampling at 25 Hz

fs = 25;
ts = 0:1/fs:1;
xs = sin(2*pi*f*ts);

figure;
plot(t, x, 'LineWidth', 1.5);
hold on;

stem(ts, xs, 'filled');

title('10 Hz Signal Sampled at 25 Hz');
xlabel('Time (seconds)');
ylabel('Amplitude');

legend('Original signal', 'Sampled points');
grid on;

saveas(gcf, 'sampling_25Hz.png');

% Sampling at 50 Hz

fs = 50;
ts = 0:1/fs:1;
xs = sin(2*pi*f*ts);

figure;
plot(t, x, 'LineWidth', 1.5);
hold on;

stem(ts, xs, 'filled');

title('10 Hz Signal Sampled at 50 Hz');
xlabel('Time (seconds)');
ylabel('Amplitude');

legend('Original signal', 'Sampled points');
grid on;

saveas(gcf, 'sampling_50Hz.png');

% Sampling at 100 Hz

fs = 100;
ts = 0:1/fs:1;
xs = sin(2*pi*f*ts);

figure;
plot(t, x, 'LineWidth', 1.5);
hold on;

stem(ts, xs, 'filled');

title('10 Hz Signal Sampled at 100 Hz');
xlabel('Time (seconds)');
ylabel('Amplitude');

legend('Original signal', 'Sampled points');
grid on;

saveas(gcf, 'sampling_100Hz.png');