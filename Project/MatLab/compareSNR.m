function snrValue = compareSNR(originalImage, mosaicImage)
    % Ensure images have the same size
    [original, mosaic] = preprocessImages(originalImage, mosaicImage);
    
    % Compute the signal power and noise power
    signalPower = sum(original(:).^2);
    noisePower = sum((original(:) - mosaic(:)).^2);
    
    % Calculate SNR in dB
    snrValue = 10 * log10(signalPower / noisePower);
end

