%Ensures the images are the same size
function [resizedOriginal, resizedMosaic] = preprocessImages(original, mosaic)
    % Convert to double precision
    original = im2double(original);
    mosaic = im2double(mosaic);
    
    % Get the minimum common size
    minHeight = min(size(original, 1), size(mosaic, 1));
    minWidth = min(size(original, 2), size(mosaic, 2));
    
    % Crop images to the same size
    resizedOriginal = original(1:minHeight, 1:minWidth, :);
    resizedMosaic = mosaic(1:minHeight, 1:minWidth, :);
end
