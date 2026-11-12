
%% Lecture 8 - Exercise 2
% Topic: Image Degradation
% Gaussian Noise, Salt & Pepper Noise, Motion Blur,
% and Uneven Lighting

clear;
clc;
close all;

%% Create output folder
outputFolder = 'Lecture8_Exercise2_Results';

if ~exist(outputFolder, 'dir')
    mkdir(outputFolder);
end

%% Part 1: Load original image
I = imread('cameraman.tif');

%% Part 2: Apply different degradations

% Gaussian noise
Ig = imnoise(I, 'gaussian', 0, 0.01);

% Salt and pepper noise
Isp = imnoise(I, 'salt & pepper', 0.05);

% Motion blur
PSF = fspecial('motion', 15, 30);
Ib = imfilter(I, PSF, 'replicate');

% Uneven lighting
[rows, cols] = size(I);

[X, Y] = meshgrid(linspace(0,1,cols), ...
    linspace(0,1,rows));

lighting = 0.4 + 0.6 * X;
Il = uint8(double(I) .* lighting);

%% Part 3: Display comparison

fig1 = figure('Name', 'Image Degradation');

subplot(2,3,1);
imshow(I);
title('Original Image');

subplot(2,3,2);
imshow(Ig);
title('Gaussian Noise');

subplot(2,3,3);
imshow(Isp);
title('Salt & Pepper Noise');

subplot(2,3,4);
imshow(Ib);
title('Motion Blur');

subplot(2,3,5);
imshow(Il);
title('Uneven Lighting');

%% Part 4: Save comparison figure

saveas(fig1, fullfile(outputFolder, ...
    'Lecture8_Exercise2_Degradation_Comparison.png'));

%% Part 5: Save individual images

imwrite(Ig, fullfile(outputFolder, ...
    'Lecture8_Exercise2_Gaussian_Noise.png'));

imwrite(Isp, fullfile(outputFolder, ...
    'Lecture8_Exercise2_Salt_Pepper_Noise.png'));

imwrite(Ib, fullfile(outputFolder, ...
    'Lecture8_Exercise2_Motion_Blur.png'));

imwrite(Il, fullfile(outputFolder, ...
    'Lecture8_Exercise2_Uneven_Lighting.png'));

%% Finished

disp('Lecture 8 - Exercise 2 completed!');
disp(['Images saved in: ', outputFolder]);
