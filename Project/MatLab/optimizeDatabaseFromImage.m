function optimizeDatasetFromImage(originalImagePath, imageFolder, numImages, optimizedFolder)
    % Load and analyze the original image
    img = imread(originalImagePath);
    boxSize = 20;
    [height, width, ~] = size(img);
    numOfBoxesHeight = floor(height / boxSize);
    numOfBoxesWidth = floor(width / boxSize);

    % Get the average LAB colors from the image boxes
    avgLABColors = getImageBoxColors(img, numOfBoxesHeight, numOfBoxesWidth, boxSize);

    % Cluster the box colors to find the most representative ones
    [~, clusterCenters] = kmeans(avgLABColors, numImages, 'MaxIter', 200);

    % Find the closest matching images for each cluster center
    selectImagesForClusters(clusterCenters, imageFolder, optimizedFolder);
end

function avgLABColors = getImageBoxColors(img, numOfBoxesHeight, numOfBoxesWidth, boxSize)
    avgLABColors = zeros(numOfBoxesHeight * numOfBoxesWidth, 3);
    index = 1;

    for i = 1:numOfBoxesHeight
        for j = 1:numOfBoxesWidth
            box = img((i-1)*boxSize+1:i*boxSize, (j-1)*boxSize+1:j*boxSize, :);
            avgR = mean(box(:,:,1), 'all');
            avgG = mean(box(:,:,2), 'all');
            avgB = mean(box(:,:,3), 'all');
            labColor = rgb2lab([avgR, avgG, avgB] / 255);
            avgLABColors(index, :) = labColor;
            index = index + 1;
        end
    end
end

function selectImagesForClusters(clusterCenters, imageFolder, optimizedFolder)
    imageFiles = dir(fullfile(imageFolder, '*.png'));
    numImages = length(imageFiles);
    
    labColors = zeros(numImages, 3);
    imageNames = strings(numImages, 1);

    % Analyze all dataset images
    for i = 1:numImages
        img = imread(fullfile(imageFolder, imageFiles(i).name));
        img = imresize(img, [20, 20]);
        avgRGB = mean(reshape(img, [], 3), 1);
        lab = rgb2lab(avgRGB / 255);
        labColors(i, :) = lab;
        imageNames(i) = imageFiles(i).name;
    end

    % Match each cluster center with the closest image
    for k = 1:size(clusterCenters, 1)
        distances = vecnorm(labColors - clusterCenters(k, :), 2, 2);
        [~, closestIdx] = min(distances);
        closestImage = imageNames(closestIdx);
        
        % Copy the selected image to the optimized folder
        copyfile(fullfile(imageFolder, closestImage), fullfile(optimizedFolder, closestImage));
        
    end
end

