function renamePictures(folderPath)
    % RENAME_AIRPLANE_IMAGES Renames airplane images in ascending order.
    % 
    % Usage: rename_airplane_images('path_to_folder')
    
    if nargin < 1 || ~isfolder(folderPath)
        error('Please provide a valid folder path.');
    end
    
    % Get a list of all PNG files in the folder
    imageFiles = dir(fullfile(folderPath, 'airplane_*.png'));
    
    % Sort the files alphabetically (ensures consistent order)
    [~, idx] = sort({imageFiles.name});
    imageFiles = imageFiles(idx);
    
    % Loop through each file and rename
    for i = 1:length(imageFiles)
        oldName = imageFiles(i).name;
        newName = sprintf('airplane_%d.png', i - 1);
        
        % Rename the file
        movefile(fullfile(folderPath, oldName), fullfile(folderPath, newName));
        
        fprintf('Renamed: %s -> %s\n', oldName, newName);
    end
    
    fprintf('All files renamed successfully!\n');
end