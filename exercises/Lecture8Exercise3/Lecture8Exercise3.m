
%% Lecture 8 - Exercise 3
% Topic: Contrast, Histogram and Geometry

clear;
clc;
close all;

%% Create results folder
outputFolder = 'Lecture8_Exercise3_Results';

if ~exist(outputFolder, 'dir')
    mkdir(outputFolder);
end

%% Part 1: Load image and plot histogram

I = imread('pout.tif');

fig1 = figure('Name', 'Original Image and Histogram');

subplot(1,2,1);
imshow(I);
title('Original Image');

subplot(1,2,2);
imhist(I);
title('Original Histogram');

saveas(fig1, fullfile(outputFolder, ...
    'Lecture8_Exercise3_Histogram.png'));

%% Part 2: Contrast and gamma correction

% Contrast stretching
J = imadjust(I, stretchlim(I), []);

% Gamma correction
B = imadjust(I, [], [], 0.5);
D = imadjust(I, [], [], 2);

% Histogram equalization
K = histeq(I);

fig2 = figure('Name', 'Contrast and Gamma');

images = {I, J, B, D, K};
titles = {'Original', 'Contrast Stretch', ...
    'Gamma 0.5', 'Gamma 2', 'Histogram Equalization'};

for k = 1:5
    subplot(1,5,k);
    imshow(images{k});
    title(titles{k});
end

saveas(fig2, fullfile(outputFolder, ...
    'Lecture8_Exercise3_Contrast_Gamma.png'));

%% Part 3: Geometry and interpolation

% Extract a 40 x 40 pixel patch
C = imread('cameraman.tif');
patch = C(60:99, 60:99);

% Enlarge by factor of 4
nearest = imresize(patch, 4, 'nearest');
bicubic = imresize(patch, 4, 'bicubic');

fig3 = figure('Name', 'Interpolation Comparison');

subplot(1,3,1);
imshow(patch, 'InitialMagnification', 'fit');
title('Original 40x40 Patch');

subplot(1,3,2);
imshow(nearest);
title('Nearest Neighbor');

subplot(1,3,3);
imshow(bicubic);
title('Bicubic');

saveas(fig3, fullfile(outputFolder, ...
    'Lecture8_Exercise3_Interpolation.png'));

%% Part 4: Save individual images

imwrite(J, fullfile(outputFolder, ...
    'Lecture8_Exercise3_Contrast_Stretch.png'));

imwrite(B, fullfile(outputFolder, ...
    'Lecture8_Exercise3_Gamma_05.png'));

imwrite(D, fullfile(outputFolder, ...
    'Lecture8_Exercise3_Gamma_2.png'));

imwrite(K, fullfile(outputFolder, ...
    'Lecture8_Exercise3_Histogram_Equalization.png'));

%% Finished

disp('Lecture 8 - Exercise 3 completed!');
disp(['Images saved in: ', outputFolder]);
