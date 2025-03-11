function meanSCIELAB = compareSCIELAB(originalImage, mosaicImage)
    % Ensure images have the same size
    [original, mosaic] = preprocessImages(originalImage, mosaicImage);
    
    % Convert RGB to LAB color space
    originalLab = rgb2lab(original);
    mosaicLab = rgb2lab(mosaic);
    
    % Calculate the color difference (Delta E)
    deltaE = sqrt(sum((originalLab - mosaicLab).^2, 3));
    
    % Compute the mean S-CIELAB value
    meanSCIELAB = mean(deltaE(:));
end