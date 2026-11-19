
%% Lecture 10 - Lab 7: Image Denoising Comparison
% Traditional Wiener Filter vs AI-Based DnCNN
% Image Processing Assignment

clc;
clear;
close all;

%% 1. Setup: Load Image and Add Gaussian Noise

% Load original grayscale image
originalImage = im2double(imread('cameraman.tif'));

% Set random seed for reproducible results
rng(42);

% Define Gaussian noise standard deviation
noiseSigma = 0.04;

% Add Gaussian noise
noisyImage = imnoise(originalImage, 'gaussian', ...
                     0, noiseSigma^2);

%% 2. Traditional Denoising - Wiener Filter

% Apply adaptive Wiener filter using 5x5 neighborhood
traditionalFiltered = wiener2(noisyImage, [5 5], ...
                              noiseSigma^2);

%% 3. AI-Based Denoising - DnCNN

% Load pretrained DnCNN network
% Requires Deep Learning Toolbox and DnCNN model
net = denoisingNetwork('DnCNN');

% Apply AI-based denoising
aiFiltered = denoiseImage(noisyImage, net);

%% 4. Display Image Comparison

fig1 = figure('Name', ...
    'Lecture 10 Lab 7 - Denoising Comparison', ...
    'Position', [100 100 1400 400]);

subplot(1,4,1);
imshow(originalImage);
title('Original Image');

subplot(1,4,2);
imshow(noisyImage);
title('Gaussian Noise');

subplot(1,4,3);
imshow(traditionalFiltered);
title('Wiener Filter');

subplot(1,4,4);
imshow(aiFiltered);
title('AI - DnCNN');

% Save comparison figure
exportgraphics(fig1, ...
    'Lecture_10_Lab_7_Denoising_Comparison.png', ...
    'Resolution', 300);

%% 5. Calculate Image Quality Metrics

% MSE (Mean Squared Error)
mseNoisy = immse(noisyImage, originalImage);
mseTraditional = immse(traditionalFiltered, originalImage);
mseAI = immse(aiFiltered, originalImage);

% PSNR (Peak Signal-to-Noise Ratio)
psnrNoisy = psnr(noisyImage, originalImage);
psnrTraditional = psnr(traditionalFiltered, originalImage);
psnrAI = psnr(aiFiltered, originalImage);

% SSIM (Structural Similarity Index)
ssimNoisy = ssim(noisyImage, originalImage);
ssimTraditional = ssim(traditionalFiltered, originalImage);
ssimAI = ssim(aiFiltered, originalImage);

%% 6. Display Metrics in Command Window

fprintf('\n===== IMAGE QUALITY COMPARISON =====\n\n');

Method = {'Noisy Image'; 'Wiener Filter'; 'AI DnCNN'};

MSE = [mseNoisy; mseTraditional; mseAI];

PSNR = [psnrNoisy; psnrTraditional; psnrAI];

SSIM = [ssimNoisy; ssimTraditional; ssimAI];

resultsTable = table(Method, MSE, PSNR, SSIM);

disp(resultsTable);

% Save results as CSV
writetable(resultsTable, ...
    'Lecture_10_Lab_7_Denoising_Metrics.csv');

%% 7. Visualize Quality Metrics

fig2 = figure('Name', ...
    'Lecture 10 Lab 7 - Quality Metrics', ...
    'Position', [100 100 1200 400]);

% MSE Comparison
subplot(1,3,1);
bar(MSE);
set(gca, 'XTickLabel', Method);
xtickangle(20);
ylabel('MSE');
title('MSE - Lower is Better');
grid on;

% PSNR Comparison
subplot(1,3,2);
bar(PSNR);
set(gca, 'XTickLabel', Method);
xtickangle(20);
ylabel('PSNR (dB)');
title('PSNR - Higher is Better');
grid on;

% SSIM Comparison
subplot(1,3,3);
bar(SSIM);
set(gca, 'XTickLabel', Method);
xtickangle(20);
ylabel('SSIM');
title('SSIM - Higher is Better');
grid on;

% Save quality metrics figure
exportgraphics(fig2, ...
    'Lecture_10_Lab_7_Quality_Metrics.png', ...
    'Resolution', 300);

%% 8. Final Evaluation

% Compare the two denoising methods
[~, bestPSNRIndex] = max(PSNR(2:3));
[~, bestSSIMIndex] = max(SSIM(2:3));

fprintf('\n===== FINAL EVALUATION =====\n');

fprintf('Best PSNR: %s\n', Method{bestPSNRIndex + 1});
fprintf('Best SSIM: %s\n', Method{bestSSIMIndex + 1});

fprintf('\nAll figures and metrics saved successfully.\n');
