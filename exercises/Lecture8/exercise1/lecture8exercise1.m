
%% Lecture 8 - Exercise 1
% Image Representation, Quantization and Aliasing

clear;
clc;
close all;

%% Create results folder
outputFolder = 'Lecture8_Exercise1_Results';

if ~exist(outputFolder, 'dir')
    mkdir(outputFolder);
end

%% Part 1: Grayscale image and pixel inspection

I = imread('cameraman.tif');

disp('Image size:');
disp(size(I));

disp('Image data type:');
disp(class(I));

disp('Pixel value at (100,120):');
disp(I(100,120));

fig1 = figure;

subplot(1,2,1);
imshow(I);
title('Original Grayscale Image');

subplot(1,2,2);
imshow(I(100:107,120:127), 'InitialMagnification', 'fit');
title('8x8 Pixel Region');

saveas(fig1, fullfile(outputFolder, ...
    'Lecture8_Exercise1_Grayscale_Pixels.png'));

%% Part 2: RGB and grayscale comparison

P = imread('peppers.png');

R = P(:,:,1);
G = rgb2gray(P);

fig2 = figure;

subplot(1,3,1);
imshow(P);
title('Original RGB');

subplot(1,3,2);
imshow(R);
title('Red Channel');

subplot(1,3,3);
imshow(G);
title('Grayscale');

saveas(fig2, fullfile(outputFolder, ...
    'Lecture8_Exercise1_RGB_Grayscale.png'));

%% Part 3: Image Quantization

bits = [8 4 2 1];

fig3 = figure;

for k = 1:length(bits)

    step = 256 / (2^bits(k));

    Q = uint8(floor(double(I) / step) * step);

    subplot(1,4,k);
    imshow(Q);

    title(sprintf('%d-bit', bits(k)));

end

saveas(fig3, fullfile(outputFolder, ...
    'Lecture8_Exercise1_Quantization.png'));

%% Part 4: Aliasing and Downsampling

% Without anti-aliasing
A1 = I(1:8:end, 1:8:end);

% With anti-aliasing
A2 = imresize(I, 1/8, 'bilinear', ...
    'Antialiasing', true);

fig4 = figure;

subplot(1,2,1);
imshow(A1, 'InitialMagnification', 'fit');
title('Without Anti-Aliasing');

subplot(1,2,2);
imshow(A2, 'InitialMagnification', 'fit');
title('With Anti-Aliasing');

saveas(fig4, fullfile(outputFolder, ...
    'Lecture8_Exercise1_Aliasing.png'));

%% Completion message

disp('Lecture 8 - Exercise 1 completed!');
disp(['Images saved in: ', outputFolder]);
