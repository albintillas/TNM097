function visualizeImageLAB(originalFolder, optimizedFolder)
    originalLabColors = getImageLABColors(originalFolder);
    optimizedLabColors = getImageLABColors(optimizedFolder);

    figure;
    subplot(1, 2, 1);
    scatter3(originalLabColors(:, 1), originalLabColors(:, 2), originalLabColors(:, 3), 36, originalLabColors(:, 4:6) / 255, 'filled');
    title('Original Image LAB Distribution');
    xlabel('L*'); ylabel('A*'); zlabel('B*');
    grid on;

    subplot(1, 2, 2);
    scatter3(optimizedLabColors(:, 1), optimizedLabColors(:, 2), optimizedLabColors(:, 3), 36, optimizedLabColors(:, 4:6) / 255, 'filled');
    title('Optimized Image LAB Distribution');
    xlabel('L*'); ylabel('A*'); zlabel('B*');
    grid on;
end

function labColors = getImageLABColors(folderPath)
    imageFiles = dir(fullfile(folderPath, '*.png'));
    numImages = length(imageFiles);
    labColors = zeros(numImages, 6);

    for i = 1:numImages
        img = imread(fullfile(folderPath, imageFiles(i).name));
        img = imresize(img, [20, 20]);  % Resize to small size for speed
        avgRGB = mean(reshape(img, [], 3), 1);

        % Convert RGB to LAB
        lab = rgb2lab(avgRGB / 255);
        
        % Store LAB and RGB
        labColors(i, :) = [lab, avgRGB];
    end
end
