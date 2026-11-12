
%% Lecture 8 - Exercise 6
% Topic: Thresholding, Morphology and Segmentation
% Detect, clean, label and measure coins

clear;
clc;
close all;

%% Part 1: Create results folder

outputFolder = 'Lecture8_Exercise6_Results';

if ~exist(outputFolder, 'dir')
    mkdir(outputFolder);
end

%% Part 2: Load original image

I = imread('coins.png');

%% Part 3: Otsu thresholding

% Calculate the automatic threshold
threshold = graythresh(I);

% Convert grayscale image to binary
BW = imbinarize(I, threshold);

% Display threshold value
fprintf('Otsu threshold: %.4f\n', threshold);

%% Part 4: Morphological operations

% Create disk-shaped structuring element
se = strel('disk', 5);

% Opening removes small objects and noise
BW_open = imopen(BW, se);

% Fill holes inside detected objects
BW_fill = imfill(BW_open, 'holes');

% Remove objects smaller than 100 pixels
BW_clean = bwareaopen(BW_fill, 100);

%% Part 5: Display thresholding and cleaning

fig1 = figure('Name', 'Thresholding and Morphology');

subplot(2,3,1);
imshow(I);
title('Original Image');

subplot(2,3,2);
imshow(BW);
title('Otsu Threshold');

subplot(2,3,3);
imshow(BW_open);
title('Morphological Opening');

subplot(2,3,4);
imshow(BW_fill);
title('Fill Holes');

subplot(2,3,5);
imshow(BW_clean);
title('Remove Small Objects');

saveas(fig1, fullfile(outputFolder, ...
    'Lecture8_Exercise6_Morphology_Comparison.png'));

%% Part 6: Label connected objects

% Label connected components
[L, numCoins] = bwlabel(BW_clean);

% Convert labels to different colors
L_color = label2rgb(L, 'jet', 'k', 'shuffle');

fig2 = figure('Name', 'Labeled Coins');

subplot(1,2,1);
imshow(I);
title('Original Coins');

subplot(1,2,2);
imshow(L_color);
title('Labeled Coins');

saveas(fig2, fullfile(outputFolder, ...
    'Lecture8_Exercise6_Labeled_Coins.png'));

%% Part 7: Measure coin properties

% Extract area, centroid and eccentricity
stats = regionprops(BW_clean, ...
    'Area', 'Centroid', 'Eccentricity');

% Extract coin areas
areas = [stats.Area]';

% Create coin IDs
CoinID = (1:numCoins)';

% Create result table
results = table(CoinID, areas, ...
    'VariableNames', {'CoinID', 'AreaPixels'});

disp('Detected Coin Areas:');
disp(results);

% Save measurements as CSV
writetable(results, fullfile(outputFolder, ...
    'Lecture8_Exercise6_Coin_Areas.csv'));

%% Part 8: Calculate statistics

fprintf('\nTotal detected coins: %d\n', numCoins);

if numCoins > 0

    meanArea = mean(areas);
    stdArea = std(areas);

    [largestArea, largestCoin] = max(areas);

    fprintf('Mean coin area: %.2f pixels\n', meanArea);
    fprintf('Standard deviation: %.2f pixels\n', stdArea);

    fprintf('Largest coin: Coin %d\n', largestCoin);
    fprintf('Largest area: %.2f pixels\n', largestArea);

else
    disp('No coins detected.');
end

%% Part 9: Display coin IDs

fig3 = figure('Name', 'Coin Identification');

imshow(I);
title('Detected Coins with IDs');
hold on;

for k = 1:numCoins

    center = stats(k).Centroid;

    text(center(1), center(2), num2str(k), ...
        'Color', 'yellow', ...
        'FontSize', 12, ...
        'FontWeight', 'bold', ...
        'HorizontalAlignment', 'center');

end

hold off;

saveas(fig3, fullfile(outputFolder, ...
    'Lecture8_Exercise6_Coin_IDs.png'));

%% Part 10: Plot coin areas

fig4 = figure('Name', 'Coin Area Comparison');

bar(CoinID, areas);

xlabel('Coin ID');
ylabel('Area (Pixels)');
title('Detected Coin Areas');
grid on;

saveas(fig4, fullfile(outputFolder, ...
    'Lecture8_Exercise6_Coin_Area_Chart.png'));

%% Part 11: Save individual images

imwrite(BW, fullfile(outputFolder, ...
    'Lecture8_Exercise6_Otsu_Threshold.png'));

imwrite(BW_open, fullfile(outputFolder, ...
    'Lecture8_Exercise6_Opening.png'));

imwrite(BW_fill, fullfile(outputFolder, ...
    'Lecture8_Exercise6_Holes_Filled.png'));

imwrite(BW_clean, fullfile(outputFolder, ...
    'Lecture8_Exercise6_Cleaned_Mask.png'));

imwrite(L_color, fullfile(outputFolder, ...
    'Lecture8_Exercise6_Color_Labeled.png'));

%% Finished

disp('Lecture 8 - Exercise 6 completed!');
disp(['Results saved in: ', outputFolder]);
