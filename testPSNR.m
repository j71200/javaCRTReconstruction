close all
clear
clc


% imageName_str = 'lena_gray';
imageName_str = 'airplane_gray';
dispthese_debug('FileName: ', imageName_str);
inputImage = imread(['images/' imageName_str '.png']);
% inputImage_uint = uint64(imread(['images/' imageName_str '.png']));



load('mat/data_wm256_pt256x256.mat');

normHeight = 512;
normWidth = 512;

wmSize = 50; % 8KB
watermark = randi([0, 1], wmSize, 1);
patternSize = 32 * 32; % 必須大於大於 wmSize才行
patterns = sign(randn(patternSize, wmSize));

wmSignature1 = patterns * (2*watermark - 1);

[zigzagColMajor ~] = genaralZigzag(normHeight, normWidth);
wmSignature2 = zeros(normHeight, normWidth);
imageArea = length(zigzagColMajor);
middle_band_idx = zigzagColMajor(1+3*imageArea/8:3*imageArea/8 + patternSize);
wmSignature2(middle_band_idx) = wmSignature1;

wmSignature2_idct = idct2(wmSignature2);


embededImage = uint8(double(inputImage) + wmSignature2_idct);
% figure;
% imshow(embededImage)




% =================
% Extract watermark
% =================
embededImage_dct = dct2(embededImage);
cw = embededImage_dct(middle_band_idx);

extractedWM = patterns' * cw;
extractedWM = extractedWM > 0;

wmDiff = extractedWM - watermark;
bitErrorRate = 100 * nnz(wmDiff) / length(watermark)

psnr(embededImage, inputImage)





