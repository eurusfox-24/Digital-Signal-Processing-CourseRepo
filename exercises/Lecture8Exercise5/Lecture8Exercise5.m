
%% Lecture 8 - Exercise 5
% Topic: Edge Detection - Sobel and Canny
% Compare different Canny sigma values
% Test edge detection with and without noise smoothing

clear;
clc;
close all;

%% Create results folder
outputFolder = 'Lecture8_Exercise5_Results';

if ~exist(outputFolder, 'dir')
    mkdir(outputFolder);
end

%% Part 1: Load original image

I = imread('cameraman.tif');

%% Part 2: Sobel and Canny edge detection

% Sobel edge detection
E_sobel = edge(I, 'sobel');

% Canny edge detection
E_canny = edge(I, 'canny');

% Display comparison
fig1 = figure('Name', 'Sobel vs Canny');

subplot(1,3,1);
imshow(I);
title('Original Image');

subplot(1,3,2);
imshow(E_sobel);
title('Sobel Edges');

subplot(1,3,3);
imshow(E_canny);
title('Canny Edges');

saveas(fig1, fullfile(outputFolder, ...
    'Lecture8_Exercise5_Sobel_vs_Canny.png'));

%% Part 3: Compare Canny sigma values

% Sigma controls Gaussian smoothing inside Canny
E_sigma1 = edge(I, 'canny', [], 1);
E_sigma2 = edge(I, 'canny', [], 2);
E_sigma3 = edge(I, 'canny', [], 3);

fig2 = figure('Name', 'Canny Sigma Comparison');

subplot(1,3,1);
imshow(E_sigma1);
title('Canny Sigma = 1');

subplot(1,3,2);
imshow(E_sigma2);
title('Canny Sigma = 2');

subplot(1,3,3);
imshow(E_sigma3);
title('Canny Sigma = 3');

saveas(fig2, fullfile(outputFolder, ...
    'Lecture8_Exercise5_Canny_Sigma_Comparison.png'));

%% Part 4: Edge detection on a noisy image

% Generate Gaussian noise
rng(1);
I_noisy = imnoise(I, 'gaussian', 0, 0.01);

% Canny without additional smoothing
E_noisy = edge(I_noisy, 'canny', [], 1);

% Smooth image first using Gaussian filter
I_smooth = imgaussfilt(I_noisy, 1.5);

% Canny after smoothing
E_smooth = edge(I_smooth, 'canny', [], 1);

fig3 = figure('Name', 'Noise and Smoothing');

subplot(2,2,1);
imshow(I_noisy);
title('Gaussian Noise');

subplot(2,2,2);
imshow(I_smooth);
title('Smoothed Image');

subplot(2,2,3);
imshow(E_noisy);
title('Canny Before Smoothing');

subplot(2,2,4);
imshow(E_smooth);
title('Canny After Smoothing');

saveas(fig3, fullfile(outputFolder, ...
    'Lecture8_Exercise5_Noise_Smoothing.png'));

%% Part 5: Count detected edge pixels

% nnz counts the number of nonzero pixels
% In a binary edge map, these are the detected edge pixels

Method = {
    'Sobel';
    'Canny Default';
    'Canny Sigma 1';
    'Canny Sigma 2';
    'Canny Sigma 3';
    'Noisy Canny';
    'Smoothed Canny'
};

EdgeCount = [
    nnz(E_sobel);
    nnz(E_canny);
    nnz(E_sigma1);
    nnz(E_sigma2);
    nnz(E_sigma3);
    nnz(E_noisy);
    nnz(E_smooth)
];

results = table(Method, EdgeCount);

disp('Edge Detection Results:');
disp(results);

% Save table to CSV
writetable(results, fullfile(outputFolder, ...
    'Lecture8_Exercise5_Edge_Counts.csv'));

%% Part 6: Plot edge count comparison

fig4 = figure('Name', 'Edge Pixel Counts');

bar(EdgeCount);
set(gca, 'XTick', 1:length(Method));
set(gca, 'XTickLabel', Method);
xtickangle(35);

ylabel('Number of Edge Pixels');
title('Edge Detection Comparison');
grid on;

saveas(fig4, fullfile(outputFolder, ...
    'Lecture8_Exercise5_Edge_Count_Chart.png'));

%% Part 7: Save individual images

imwrite(E_sobel, fullfile(outputFolder, ...
    'Lecture8_Exercise5_Sobel.png'));

imwrite(E_canny, fullfile(outputFolder, ...
    'Lecture8_Exercise5_Canny.png'));

imwrite(E_sigma1, fullfile(outputFolder, ...
    'Lecture8_Exercise5_Canny_Sigma1.png'));

imwrite(E_sigma2, fullfile(outputFolder, ...
    'Lecture8_Exercise5_Canny_Sigma2.png'));

imwrite(E_sigma3, fullfile(outputFolder, ...
    'Lecture8_Exercise5_Canny_Sigma3.png'));

imwrite(E_noisy, fullfile(outputFolder, ...
    'Lecture8_Exercise5_Canny_Noisy.png'));

imwrite(E_smooth, fullfile(outputFolder, ...
    'Lecture8_Exercise5_Canny_Smoothed.png'));

%% Finished

disp('Lecture 8 - Exercise 5 completed!');
disp(['Results saved in: ', outputFolder]);
