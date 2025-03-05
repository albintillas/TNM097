function cellArray = index_Lab(orgPath, numberofImages)
%INDEX_LAB Summary of this function goes here
%   Detailed explanation goes here


cellArray = cell(numberofImages,2);

    for imCounter = 0:(numberofImages - 1)
    
    path = orgPath + imCounter + ".png";   
    image = imread(path);
    imageName = "airplane_" + imCounter;
    
    [meanR, meanG, meanB] =  calcRGB(image);
    
    color_Lab = rgb2lab(cat(3,meanR/255,meanG/255,meanB/255));
    
    cellArray{imCounter + 1, 1} = imageName;
    cellArray{imCounter + 1, 2} = [color_Lab(:,:,1), color_Lab(:,:,2), color_Lab(:,:,3)];
    
    end


end

