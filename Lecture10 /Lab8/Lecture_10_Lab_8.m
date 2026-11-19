
%% Lecture 10 Lab 8
% Hybrid Traditional Image Processing + AI Classification

close all;
clear;
clc;

%% Section 1: Load Image and Pre-trained CNN

disp('=== Lecture 10 Lab 8 ===');

% Load sample image
targetImage = imread('peppers.png');

% Load pre-trained SqueezeNet
% Requires Deep Learning Toolbox and SqueezeNet support package
disp('Loading SqueezeNet...');

net = squeezenet;

disp('SqueezeNet loaded successfully.');

% Get network input size
inputSize = net.Layers(1).InputSize;

% Display original image
figure('Name', 'Lecture 10 Lab 8 - Original Image');
imshow(targetImage);
title('Original Image - peppers.png');

% Save figure
exportgraphics(gcf, 'Lecture 10 Lab 8 Figure 1.png');

%% Section 2: Traditional Processing - K-Means Segmentation

disp('Performing K-Means color segmentation...');

% Convert RGB image to LAB color space
imgLab = rgb2lab(targetImage);

% Extract color channels a* and b*
ab = imgLab(:,:,2:3);
ab = im2single(ab);

% Apply K-Means clustering
numClusters = 2;
pixelLabels = imsegkmeans(ab, numClusters);

% Create mask for Cluster 2
mask = pixelLabels == 2;

% Isolate selected cluster
isolatedObject = targetImage;
isolatedObject(repmat(~mask, [1 1 3])) = 0;

% Display segmentation results
figure('Name', 'Lecture 10 Lab 8 - Segmentation');

subplot(1,3,1);
imshow(targetImage);
title('Original Image');

subplot(1,3,2);
imshow(mask);
title('K-Means Mask');

subplot(1,3,3);
imshow(isolatedObject);
title('Isolated Object');

% Save figure
exportgraphics(gcf, 'Lecture 10 Lab 8 Figure 2.png');

%% Section 3: AI Classification Using SqueezeNet

disp('Running AI image classification...');

% Resize original image for CNN
resizedOriginal = imresize(targetImage, ...
    [inputSize(1), inputSize(2)]);

% Resize segmented image for CNN
resizedObject = imresize(isolatedObject, ...
    [inputSize(1), inputSize(2)]);

% Classify original image
[labelOriginal, scoresOriginal] = classify(net, resizedOriginal);

% Classify segmented image
[labelSegmented, scoresSegmented] = classify(net, resizedObject);

% Calculate confidence scores
confidenceOriginal = max(scoresOriginal) * 100;
confidenceSegmented = max(scoresSegmented) * 100;

% Display results
figure('Name', 'Lecture 10 Lab 8 - AI Classification');

subplot(1,2,1);
imshow(resizedOriginal);
title(sprintf('Original: %s (%.2f%%)', ...
    char(labelOriginal), confidenceOriginal));

subplot(1,2,2);
imshow(resizedObject);
title(sprintf('Segmented: %s (%.2f%%)', ...
    char(labelSegmented), confidenceSegmented));

% Save figure
exportgraphics(gcf, 'Lecture 10 Lab 8 Figure 3.png');

%% Section 4: Hybrid Pipeline Overview

figure('Name', 'Lecture 10 Lab 8 - Hybrid Pipeline');

subplot(2,2,1);
imshow(targetImage);
title('1. Original Image');

subplot(2,2,2);
imshow(mask);
title('2. K-Means Mask');

subplot(2,2,3);
imshow(isolatedObject);
title('3. Segmented Object');

subplot(2,2,4);
imshow(resizedObject);
title(sprintf('4. AI: %s (%.2f%%)', ...
    char(labelSegmented), confidenceSegmented));

% Save figure
exportgraphics(gcf, 'Lecture 10 Lab 8 Figure 4.png');

%% Section 5: Results and Comparison

fprintf('\n====================================\n');
fprintf('Lecture 10 Lab 8 - Results\n');
fprintf('====================================\n');

fprintf('Original image classification: %s\n', ...
    char(labelOriginal));

fprintf('Original image confidence: %.2f%%\n\n', ...
    confidenceOriginal);

fprintf('Segmented image classification: %s\n', ...
    char(labelSegmented));

fprintf('Segmented image confidence: %.2f%%\n', ...
    confidenceSegmented);

% Create comparison table
Method = ["Original Image"; "Hybrid Segmented Image"];

Classification = [string(labelOriginal); ...
                  string(labelSegmented)];

Confidence_Percent = [confidenceOriginal; ...
                      confidenceSegmented];

resultsTable = table(Method, Classification, ...
    Confidence_Percent);

disp(' ');
disp('Classification Comparison:');
disp(resultsTable);

% Save comparison to CSV
writetable(resultsTable, ...
    'Lecture 10 Lab 8 Results.csv');

disp(' ');
disp('Lab 8 completed successfully.');
disp('Figures and CSV results saved.');
