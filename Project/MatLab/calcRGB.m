function [meanR, meanG, meanB] = calcRGB(inputFile)
%CALCRGB 
% Calculates the mean value for each of the RGB-channels for a picture
%   Detailed explanation goes here:


image = inputFile;

    if size(image, 3) ~= 3

    error('The input image must be an RGB image.');
    end
    
    % Extract individual color channels
    R = image(:,:,1);
    G = image(:,:,2);
    B = image(:,:,3);
    
    % Compute the average value for each channel
    meanR = mean(R(:));
    meanG = mean(G(:));
    meanB = mean(B(:));


end

