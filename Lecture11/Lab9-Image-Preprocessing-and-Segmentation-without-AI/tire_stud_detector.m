clear; clc; close all;

imageFiles = {'studded_tire.jpeg', 'summer_tire.jpg'};

for i = 1:numel(imageFiles)

    % Step 1: Read and resize
    I = imread(imageFiles{i});
    I = imresize(I, 0.5);

    % Step 2: Convert to grayscale
    if size(I, 3) == 3
        Igray = rgb2gray(I);
    else
        Igray = I;
    end

    % Step 3: Create a tire mask
    threshold = 180;
    tireMask = Igray < threshold;

    % Remove small unwanted objects
    tireMask = bwareaopen(tireMask, 500);

    % Fill holes inside the tire mask
    tireMask = imfill(tireMask, 'holes');

    % Step 4: Detect candidate studs

    % Brightness threshold
    brightThreshold = 200;

    % Find bright pixels inside the tire
    cand = (Igray > brightThreshold) & tireMask;

    % Remove very small noise
    cand = bwareaopen(cand, 3);

    % Apply morphological opening
    se = strel('disk', 1);
    cand = imopen(cand, se);

    % Step 5: Connected Component Analysis
    CC = bwconncomp(cand);

    stats = regionprops(CC, 'Area', 'Perimeter', 'Eccentricity');

    studMask = false(size(cand));
    studCount = 0;

    % Stud filtering criteria
    minA = 4;
    maxA = 120;
    minCirc = 0.6;
    maxEcc = 0.85;

    for k = 1:numel(stats)

        area = stats(k).Area;
        perimeter = stats(k).Perimeter;
        eccentricity = stats(k).Eccentricity;

        % Calculate circularity
        if perimeter > 0
            circularity = 4 * pi * area / (perimeter^2);
        else
            circularity = 0;
        end

        % Check if component looks like a stud
        if area >= minA && area <= maxA && ...
                circularity >= minCirc && eccentricity <= maxEcc

            studMask(CC.PixelIdxList{k}) = true;
            studCount = studCount + 1;

        end
    end

    fprintf('%s: %d possible studs detected\n', ...
        imageFiles{i}, studCount);

    % Step 6: Classify the tire

    studThreshold = 10;

    if studCount > studThreshold
        isStudded = true;
        classification = 'STUDDED TIRE';
    else
        isStudded = false;
        classification = 'NON-STUDDED TIRE';
    end

    fprintf('%s -> %s (%d studs detected)\n', ...
        imageFiles{i}, classification, studCount);

    % Step 7: Final visualization

    figure;

    subplot(1,3,1);
    imshow(I);
    title('Original Image');

    subplot(1,3,2);
    imshow(cand);
    title('Candidate Studs');

    subplot(1,3,3);
    imshow(I);
    hold on;

    visboundaries(studMask, 'Color', 'r', 'LineWidth', 0.7);

    title(sprintf('%s (Studs: %d)', classification, studCount));

    hold off;

end
