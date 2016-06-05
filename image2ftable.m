function [ fTableX, fTableY, fTableF_uint ] = image2ftable( inputImage_uint )
%img2ftable Summary of this function goes here
%   Detailed explanation goes here

[height width] = size(inputImage_uint);

[zzOrder, zzOrderMatrix] = genaralZigzag(height, width);

% fTableXMax = zeros(height*width, 1);
% fTableYMax = zeros(height*width, 1);
% fTableFMax_uint = uint64(zeros(height*width, 1));


xx = mod(zzOrder, height);
findZeroXX = find(xx==0);
xx(findZeroXX) = xx(findZeroXX) + height;
yy = ceil(zzOrder / height) + 1;

findInputImage = find(inputImage_uint);
nnzZZOrder = zzOrderMatrix(findInputImage);


fTableX = xx(nnzZZOrder);
fTableY = yy(nnzZZOrder);
fTableF_uint = inputImage_uint(findInputImage);



% counter = 0;
% for roundNum = 1:height*width
% 	zzIdx = zzOrder(roundNum);
% 	if inputImage_uint(zzIdx) > 0
% 		counter = counter + 1;
% 		if mod(zzIdx, height) ~= 0
% 			xx = mod(zzIdx, height);
% 		else
% 			xx = height;
% 		end
% 		yy = ceil(zzIdx / height) + 1;
		
% 		fTableXMax(counter) = xx;
% 		fTableYMax(counter) = yy;
% 		fTableFMax_uint(counter) = inputImage_uint(zzIdx);
% 	end
% end

% fTableX = fTableXMax(1:counter);
% fTableY = fTableYMax(1:counter);
% fTableF_uint = fTableFMax_uint(1:counter);

end

