function closestImages = findClosestImage(avgLABColors, imageLABMatrix)
% FINDCLOSESTIMAGES - Finds the closest matching image for each box based on LAB color distance
%
% avgLABColors: Matrix of LAB values for each image box [numBoxesY, numBoxesX, 3]
% imageLABMatrix: Cell array where first column is image names, second column is LAB values
%
% closestImages: Matrix of image names or indices for each box

    [numBoxesY, numBoxesX, ~] = size(avgLABColors);
    closestImages = cell(numBoxesY, numBoxesX);

    % Loop through each box
    for i = 1:numBoxesY
        for j = 1:numBoxesX
            minDistance = inf;
            closestImage = '';

            % Get LAB value of the current box
            boxLAB = squeeze(avgLABColors(i, j, :));

            % Loop through the image LAB matrix to find the closest match
            for k = 1:size(imageLABMatrix, 1)
                imageLAB = imageLABMatrix{k, 2};  % LAB value of the image

                % Calculate the Euclidean distance in LAB space
               %distance = sqrt(sum((boxLAB - imageLAB).^2));

               % Calculate Euclidean distance manually
                L_diff = boxLAB(1) - imageLAB(1);
                A_diff = boxLAB(2) - imageLAB(2);
                B_diff = boxLAB(3) - imageLAB(3);
                
                distance = sqrt(L_diff^2 + A_diff^2 + B_diff^2);

                % Update if a closer match is found
                if distance < minDistance
                    minDistance = distance;
                    closestImage = imageLABMatrix{k, 1};  % Store the image name
                end
            end

            % Save the closest image name or index
            closestImages{i, j} = closestImage;
        end
    end
end
