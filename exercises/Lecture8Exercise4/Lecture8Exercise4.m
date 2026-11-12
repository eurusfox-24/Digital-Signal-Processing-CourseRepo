
%% Lecture 8 - Exercise 4
% Topic: Filtering, Denoising and 2D FFT
% Compare Mean, Gaussian and Median filters

clear;
clc;
close all;

%% Create results folder
outputFolder = 'Lecture8_Exercise4_Results';

if ~exist(outputFolder, 'dir')
    mkdir(outputFolder);
end

%% Part 1: Load original image

I = imread('cameraman.tif');

% Recreate the noise from Exercise 2
% Use a fixed seed for reproducible results
rng(1);

Ig = imnoise(I, 'gaussian', 0, 0.01);
Isp = imnoise(I, 'salt & pepper', 0.05);

%% Part 2: Apply filters to Gaussian noise

% Mean filter (3x3)
meanKernel = ones(3) / 9;
Ig_mean = imfilter(Ig, meanKernel, 'replicate');

% Gaussian filter (sigma = 1.5)
Ig_gaussian = imgaussfilt(Ig, 1.5);

% Median filter (3x3)
Ig_median = medfilt2(Ig, [3 3]);

%% Part 3: Apply filters to Salt & Pepper noise

Isp_mean = imfilter(Isp, meanKernel, 'replicate');

Isp_gaussian = imgaussfilt(Isp, 1.5);

Isp_median = medfilt2(Isp, [3 3]);

%% Part 4: Compare Gaussian noise filtering

fig1 = figure('Name', 'Gaussian Noise Filtering');

subplot(2,2,1);
imshow(Ig);
title('Gaussian Noise');

subplot(2,2,2);
imshow(Ig_mean);
title('Mean Filter');

subplot(2,2,3);
imshow(Ig_gaussian);
title('Gaussian Filter');

subplot(2,2,4);
imshow(Ig_median);
title('Median Filter');

saveas(fig1, fullfile(outputFolder, ...
    'Lecture8_Exercise4_Gaussian_Filter_Comparison.png'));

%% Part 5: Compare Salt & Pepper filtering

fig2 = figure('Name', 'Salt and Pepper Filtering');

subplot(2,2,1);
imshow(Isp);
title('Salt & Pepper Noise');

subplot(2,2,2);
imshow(Isp_mean);
title('Mean Filter');

subplot(2,2,3);
imshow(Isp_gaussian);
title('Gaussian Filter');

subplot(2,2,4);
imshow(Isp_median);
title('Median Filter');

saveas(fig2, fullfile(outputFolder, ...
    'Lecture8_Exercise4_Salt_Pepper_Filter_Comparison.png'));

%% Part 6: Calculate PSNR

% PSNR measures similarity to the original image.
% Higher PSNR means better reconstruction quality.

PSNR_Gaussian = [
    psnr(Ig_mean, I);
    psnr(Ig_gaussian, I);
    psnr(Ig_median, I)
];

PSNR_SaltPepper = [
    psnr(Isp_mean, I);
    psnr(Isp_gaussian, I);
    psnr(Isp_median, I)
];

Filter = {'Mean'; 'Gaussian'; 'Median'};

% Create comparison table
results = table(Filter, PSNR_Gaussian, PSNR_SaltPepper);

disp('PSNR Comparison Table:');
disp(results);

% Save results as CSV
writetable(results, fullfile(outputFolder, ...
    'Lecture8_Exercise4_PSNR_Results.csv'));

%% Part 7: Plot PSNR comparison

fig3 = figure('Name', 'PSNR Comparison');

bar([PSNR_Gaussian, PSNR_SaltPepper]);

set(gca, 'XTickLabel', Filter);
ylabel('PSNR (dB)');
xlabel('Filter Type');
title('PSNR Comparison');
legend('Gaussian Noise', 'Salt & Pepper Noise');
grid on;

saveas(fig3, fullfile(outputFolder, ...
    'Lecture8_Exercise4_PSNR_Comparison.png'));

%% Part 8: 2D FFT Spectrum

% Blur the original image
Iblur = imgaussfilt(I, 2);

% Compute FFT
F_original = fftshift(fft2(double(I)));
F_blurred = fftshift(fft2(double(Iblur)));

% Log magnitude spectrum
S_original = log(1 + abs(F_original));
S_blurred = log(1 + abs(F_blurred));

fig4 = figure('Name', '2D FFT Spectrum');

subplot(2,2,1);
imshow(I);
title('Original Image');

subplot(2,2,2);
imshow(Iblur);
title('Blurred Image');

subplot(2,2,3);
imshow(S_original, []);
title('Original FFT Spectrum');

subplot(2,2,4);
imshow(S_blurred, []);
title('Blurred FFT Spectrum');

saveas(fig4, fullfile(outputFolder, ...
    'Lecture8_Exercise4_FFT_Spectrum.png'));

%% Part 9: Save individual filtered images

imwrite(Ig_mean, fullfile(outputFolder, ...
    'Lecture8_Exercise4_GaussianNoise_Mean.png'));

imwrite(Ig_gaussian, fullfile(outputFolder, ...
    'Lecture8_Exercise4_GaussianNoise_Gaussian.png'));

imwrite(Ig_median, fullfile(outputFolder, ...
    'Lecture8_Exercise4_GaussianNoise_Median.png'));

imwrite(Isp_mean, fullfile(outputFolder, ...
    'Lecture8_Exercise4_SaltPepper_Mean.png'));

imwrite(Isp_gaussian, fullfile(outputFolder, ...
    'Lecture8_Exercise4_SaltPepper_Gaussian.png'));

imwrite(Isp_median, fullfile(outputFolder, ...
    'Lecture8_Exercise4_SaltPepper_Median.png'));

%% Finished

disp('Lecture 8 - Exercise 4 completed!');
disp(['Results saved in: ', outputFolder]);
