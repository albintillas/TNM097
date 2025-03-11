function meanDistance = compareEuclidean(originalImage, mosaicImage)
    % Ensure images have the same size
    [original, mosaic] = preprocessImages(originalImage, mosaicImage);
    
    % Calculate Euclidean distance pixel by pixel
    distanceMatrix = sqrt(sum((original - mosaic).^2, 3));
    
    % Compute the mean distance
    meanDistance = mean(distanceMatrix(:));
end