function [TrainX, TrainY, TestX, TestY] = TestTrainSplit(filepath, prop_test, size)
%Converts data with pixel values of square size x size image to
%matrices
%Returns train/test matrices which contain the pixel value information
%A column of the test matrices is the pixel value information in row-major
%order for 1 example. 
%First column of table is label

data = table2array(readtable(filepath))';
data = data(:, randperm(width(data))); %Shuffling data
num_train = width(data) - floor(width(data)*prop_test);
 
TrainX = data(2:size+1,1:num_train) ./ 255; %Dividing by 255 to normalize
TrainY = data(1,1:num_train);

TestX = data(2:size+1,num_train+1:end) ./ 255;
TestY = data(1,num_train+1:end);

end