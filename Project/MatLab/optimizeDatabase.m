function optimizeDatabase(sourceFolder, targetFolder, numImages)
    % Create target folder if it doesn't exist
    if ~exist(targetFolder, 'dir')
        mkdir(targetFolder);
    end

    % Get list of all image files in the source folder
    imageFiles = dir(fullfile(sourceFolder, '*.png')); % Adjust for other formats if needed
    numAvailableImages = numel(imageFiles);

    if numAvailableImages == 0
        error('No images found in the source folder.');
    end

    % If fewer images than requested, just copy all
    if numAvailableImages <= numImages
        fprintf('Only %d images found. Copying all to the target folder.\n', numAvailableImages);
        for i = 1:numAvailableImages
            copyfile(fullfile(sourceFolder, imageFiles(i).name), fullfile(targetFolder, imageFiles(i).name));
        end
        return;
    end

    % Initialize LAB color matrix
    labColors = zeros(numAvailableImages, 3);

    % Calculate average LAB color for each image
    for i = 1:numAvailableImages
        img = imread(fullfile(sourceFolder, imageFiles(i).name));
        avgRGB = mean(img, [1, 2]);
        labColor = rgb2lab(avgRGB / 255);
        labColors(i, :) = labColor;
    end

    % Cluster colors to reduce redundancy
    fprintf('Clustering images to %d distinct colors...\n', numImages);
    [~, clusterCenters] = kmeans(labColors, numImages, 'MaxIter', 200);

    % Find closest image to each cluster center
    selectedImages = false(1, numAvailableImages);
    for i = 1:numImages
        distances = vecnorm(labColors - clusterCenters(i, :), 2, 2);
        [~, closestIdx] = min(distances);
        selectedImages(closestIdx) = true;
    end

    % Copy selected images to the target folder
    fprintf('Saving selected images to %s...\n', targetFolder);
    for i = 1:numAvailableImages
        if selectedImages(i)
            copyfile(fullfile(sourceFolder, imageFiles(i).name), fullfile(targetFolder, imageFiles(i).name));
        end
    end

    fprintf('Database optimization complete! %d images saved.\n', numImages);
end
