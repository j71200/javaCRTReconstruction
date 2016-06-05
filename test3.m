close all
clear
clc

imageName_str = 'airplane_gray';
% dispthese_debug('FileName: ', imageName_str);

wholeProcessStart_str = dispTime(0);

load('mat/primeList_502_bigd.mat');

inputImage = imread(['images/' imageName_str '.png']);
inputImage_dbl = double(inputImage);

figure;
imshow(inputImage);

load('mat/data_wm256_pt256x256.mat');

normHeight = 512;
normWidth = 512;

wmSize = 50; % 8KB
watermark = randi([0, 1], wmSize, 1);
patternSize = 256 * 256; % 必須大於大於 wmSize才行
patterns = sign(randn(patternSize, wmSize));

wmSignature1 = patterns * (2*watermark - 1);

[zigzagColMajor ~] = genaralZigzag(normHeight, normWidth);
wmSignature2 = zeros(normHeight, normWidth);
imageArea = length(zigzagColMajor);
middle_band_idx = zigzagColMajor(1+3*imageArea/8:3*imageArea/8 + patternSize);
wmSignature2(middle_band_idx) = wmSignature1;

wmSignature2_idct = idct2(wmSignature2);


wmSignature2_idct_trick = round(wmSignature2_idct);
trickShift = min(min(wmSignature2_idct_trick));


% disp('===================');
% disp('Embedding Watermark');
% disp('===================');
embededImage_dbl = inputImage_dbl + wmSignature2_idct;
embededImage = uint8(embededImage_dbl);

figure;
imshow(embededImage);

attackedImage = zeros(normHeight, normWidth, 'uint8');
attackedImage(:, 1:256) = embededImage(:, 257:512);



figure;
imshow(attackedImage);

% disp('=================');
% disp('Extract Watermark');
% disp('=================');
attackedImage_dct = dct2(attackedImage);
cw = attackedImage_dct(middle_band_idx);

extractedWM = patterns' * cw;
extractedWM = extractedWM > 0;

wmDiff = extractedWM - watermark;
bitErrorRate = 100 * nnz(wmDiff) / length(watermark)

