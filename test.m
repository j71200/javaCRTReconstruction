clear('all');
clc

% % ==========
% % Randomly
% % ==========
% inputImage = imread('images/airplane_gray.png');

% [height, width] = size(inputImage);

% k = ceil(height*width/211);

% convertedImage = zeros(211, k, 'uint8');

% convertedImage(1:height*width) = inputImage';

% convertedImage = convertedImage';

% imshow(convertedImage)



% ==========
% Randomly
% ==========
% inputImage = imread('images/airplane_gray.png');

% [height, width] = size(inputImage);

% k = ceil(height*width/211);

% convertedImage = zeros(211, k, 'uint8');

% randIdx = rand(height*width, 1);
% [~, randIdx] = sort(randIdx);
% convertedImage(randIdx) = inputImage';

% convertedImage = convertedImage';

% imshow(convertedImage)



% ==========
% Row major
% ==========
% inputImage = imread('images/airplane_gray.png');

% [height, width] = size(inputImage);

% k = ceil(height*width/211);

% convertedImage = zeros(211, k, 'uint8');

% convertedImage(1:height*width) = inputImage';

% convertedImage = convertedImage';

% imshow(convertedImage)






