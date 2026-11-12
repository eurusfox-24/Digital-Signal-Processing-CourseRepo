
%% Lecture 8 - Exercise 7: Final Mini Project
% Topic: Complete Image Processing Pipeline
% Rice Grain Detection and Measurement

clear;
clc;
close all;

%% Part 1: Create results folder

outputFolder = 'Lecture8_Exercise7_Results';

if ~exist(outputFolder, 'dir')
    mkdir(outputFolder);
end

%% Part 2: Load original rice image

I = imread('rice.png');

% Convert to double for image calculations
I_double = im2double(I);

%% Part 3: Degrade image

% Make results reproducible
rng(1);

% Create uneven lighting ramp
[rows, cols] = size(I);

[X, Y] = meshgrid(linspace(0,1,cols), ...
                  linspace(0,1,rows));

lighting = 0.4 + 0.6 * X;

% Apply uneven lighting
I_light = I_double .* lighting;

% Add Gaussian noise
I_gaussian = imnoise(I_light, 'gaussian', 0, 0.01);

% Add Salt & Pepper noise
I_degraded = imnoise(I_gaussian, 'salt & pepper', 0.02);

%% Part 4: Display degradation results

fig1 = figure('Name', 'Image Degradation');

subplot(2,2,1);
imshow(I);
title('Original Rice Image');

subplot(2,2,2);
imshow(I_light);
title('Uneven Lighting');

subplot(2,2,3);
imshow(I_gaussian);
title('Gaussian Noise');

subplot(2,2,4);
imshow(I_degraded);
title('Final Degraded Image');

saveas(fig1, fullfile(outputFolder, ...
    'Lecture8_Exercise7_Degradation.png'));

%% Part 5: Denoising

% Median filter removes Salt & Pepper noise
I_median = medfilt2(I_degraded, [3 3]);

% Gaussian filter reduces Gaussian noise
I_denoised = imgaussfilt(I_median, 1);

fig2 = figure('Name', 'Denoising');

subplot(1,3,1);
imshow(I_degraded);
title('Degraded Image');

subplot(1,3,2);
imshow(I_median);
title('Median Filter');

subplot(1,3,3);
imshow(I_denoised);
title('Median + Gaussian');

saveas(fig2, fullfile(outputFolder, ...
    'Lecture8_Exercise7_Denoising.png'));

%% Part 6: Background correction

% Convert to uint8 for morphological operations
I_denoised_uint8 = im2uint8(I_denoised);

% Estimate background using morphological opening
se = strel('disk', 15);

background = imopen(I_denoised_uint8, se);

% Subtract estimated background
I_corrected = imsubtract(I_denoised_uint8, background);

% Improve contrast
I_corrected = imadjust(I_corrected);

fig3 = figure('Name', 'Background Correction');

subplot(1,3,1);
imshow(I_denoised_uint8);
title('Before Correction');

subplot(1,3,2);
imshow(background);
title('Estimated Background');

subplot(1,3,3);
imshow(I_corrected);
title('Corrected Image');

saveas(fig3, fullfile(outputFolder, ...
    'Lecture8_Exercise7_Background_Correction.png'));

%% Part 7: Thresholding and cleanup

% Automatic Otsu thresholding
BW = imbinarize(I_corrected);

% Remove objects smaller than 50 pixels
BW_clean = bwareaopen(BW, 50);

% Fill internal holes
BW_clean = imfill(BW_clean, 'holes');

fig4 = figure('Name', 'Segmentation');

subplot(1,3,1);
imshow(I_corrected);
title('Corrected Image');

subplot(1,3,2);
imshow(BW);
title('Otsu Threshold');

subplot(1,3,3);
imshow(BW_clean);
title('Cleaned Binary Image');

saveas(fig4, fullfile(outputFolder, ...
    'Lecture8_Exercise7_Segmentation.png'));

%% Part 8: Label rice grains

[L, numGrains] = bwlabel(BW_clean);

% Color each detected grain
L_color = label2rgb(L, 'jet', 'k', 'shuffle');

fig5 = figure('Name', 'Rice Grain Detection');

subplot(1,2,1);
imshow(I);
title('Original Rice Image');

subplot(1,2,2);
imshow(L_color);
title('Detected Rice Grains');

saveas(fig5, fullfile(outputFolder, ...
    'Lecture8_Exercise7_Detected_Grains.png'));

%% Part 9: Measure grain properties

stats = regionprops(BW_clean, ...
    'Area', 'Centroid');

areas = [stats.Area]';

GrainID = (1:numGrains)';

% Create table
results = table(GrainID, areas, ...
    'VariableNames', {'GrainID', 'AreaPixels'});

disp('Rice Grain Measurements:');
disp(results);

% Save table
writetable(results, fullfile(outputFolder, ...
    'Lecture8_Exercise7_Grain_Measurements.csv'));

%% Part 10: Calculate statistics

fprintf('\n===== RICE GRAIN ANALYSIS =====\n');

fprintf('Total grains detected: %d\n', numGrains);

if numGrains > 0

    meanArea = mean(areas);
    stdArea = std(areas);

    fprintf('Mean grain area: %.2f pixels\n', meanArea);
    fprintf('Standard deviation: %.2f pixels\n', stdArea);

else
    disp('No grains detected.');
end

%% Part 11: Plot grain area histogram

fig6 = figure('Name', 'Grain Area Histogram');

if numGrains > 0
    histogram(areas, 15);
end

xlabel('Grain Area (Pixels)');
ylabel('Number of Grains');
title('Rice Grain Area Distribution');
grid on;

saveas(fig6, fullfile(outputFolder, ...
    'Lecture8_Exercise7_Area_Histogram.png'));

%% Part 12: Display numbered grains

fig7 = figure('Name', 'Numbered Rice Grains');

imshow(I);
title('Detected Grains with IDs');
hold on;

for k = 1:numGrains

    center = stats(k).Centroid;

    text(center(1), center(2), num2str(k), ...
        'Color', 'yellow', ...
        'FontSize', 7, ...
        'HorizontalAlignment', 'center');

end

hold off;

saveas(fig7, fullfile(outputFolder, ...
    'Lecture8_Exercise7_Numbered_Grains.png'));

%% Part 13: Save individual images

imwrite(I_light, fullfile(outputFolder, ...
    'Lecture8_Exercise7_Uneven_Lighting.png'));

imwrite(I_degraded, fullfile(outputFolder, ...
    'Lecture8_Exercise7_Degraded_Image.png'));

imwrite(I_denoised, fullfile(outputFolder, ...
    'Lecture8_Exercise7_Denoised_Image.png'));

imwrite(I_corrected, fullfile(outputFolder, ...
    'Lecture8_Exercise7_Corrected_Image.png'));

imwrite(BW_clean, fullfile(outputFolder, ...
    'Lecture8_Exercise7_Binary_Mask.png'));

imwrite(L_color, fullfile(outputFolder, ...
    'Lecture8_Exercise7_Labeled_Grains.png'));

%% Finished

disp('Lecture 8 - Exercise 7 completed!');
disp(['Results saved in: ', outputFolder]);
