function DataPreparation(directoryPath, labels, imageSize)
%   This function takes as input a directory path, a set of labels and a desired image size. 
%   It iterates over each subdirectory of the given directory, where each subdirectory represents a different category of images. 
%   For each image, it converts the image to grayscale if it's a color image, resizes the image to the desired size, 
%   and then reshapes the image into a 1D vector. 
%   It stores these image vectors along with their corresponding labels in a data cell. 
%   Finally, it converts the data cell into a table and writes the table to a CSV file.
%   The resulting CSV file contains one row for each image, where the first column is the label of the image, 
%   and the remaining columns represent the pixel values of the image.



    % Get a list of Subdirectories
    subdirs = dir(directoryPath);
    subdirs = subdirs(~ismember({subdirs.name}, {'.', '..'}));  % Exclude '.' and '..'

    % Preallocate data
    numImages = 0;
    for i = 1:length(subdirs)
        subdirPath = fullfile(directoryPath, subdirs(i).name);
        imageFiles = dir(fullfile(subdirPath, '*.png'));
        numImages = numImages + length(imageFiles);
    end
    dataCell = cell(numImages, imageSize*imageSize + 1);  % "+1" to account for labels

    imageIndex = 1;
    for i = 1:length(subdirs)
        subdirPath = fullfile(directoryPath, subdirs(i).name);
        imageFiles = dir(fullfile(subdirPath, '*.png'));

        for j = 1:length(imageFiles)
            imagePath = fullfile(subdirPath, imageFiles(j).name);
            image = imread(imagePath);
            
            if size(image, 3) == 3
                image = rgb2gray(image);
            end
            
            resizedImage = imresize(image, [imageSize, imageSize]);
            imageVector = double(reshape(resizedImage, 1, []));
            
            dataCell(imageIndex, 2:end) = num2cell(imageVector);
            
            dataCell(imageIndex, 1) = labels(i);
            
            imageIndex = imageIndex + 1;
        end
    end
    
    % Create table
    dataTable = cell2table(dataCell, 'VariableNames', ['Label', cellstr(strcat('Pixel', string(1:imageSize*imageSize)))]);
    
    % Write the table to a CSV file
    csvFilePath = fullfile(directoryPath, 'image_data.csv');
    writetable(dataTable, csvFilePath);
end