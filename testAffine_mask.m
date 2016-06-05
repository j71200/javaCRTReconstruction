close all
clear
clc
isShow = false;
isAdjust = false;


isShow = true;
% isAdjust = true;

selectBeta = 2;

alpha = 128;
para = 30;


% imageName_str = 'airplane_gray';
% imageName_str = 'baboon_gray';
imageName_str = 'fruits_gray';
% imageName_str = 'lena_gray';
% imageName_str = 'peppers_gray';


dispthese_debug('FileName: ', imageName_str);
inputImage = imread(['images/' imageName_str '.png']);
inputImage_uint = uint64(inputImage);


% ========================
% Normalize Original Image
% ========================
normHeight = 512;
normWidth = 512;

[normInputImage_uint, normInputImageFTableX, normInputImageFTableY, normInputImageFTableF_uint, SYXMatrix, meanVector] = normalizeImage(inputImage_uint, normHeight, normWidth, false, 2);

if isShow
	figure
	imshow(uint8(normInputImage_uint))
	title(['size: ' num2str(size(normInputImage_uint))])
end


% ==================
% Generate watermark
% ==================
load('mat/data_wm256_pt256x256.mat');

wmSize = 50; % 8KB
watermark = randi([0, 1], wmSize, 1);
patternSize = alpha * alpha; % 必須大於大於 wmSize才行
patterns = sign(randn(patternSize, wmSize));

wmSignature1 = patterns * (2*watermark - 1);

[zigzagColMajor ~] = genaralZigzag(normHeight, normWidth);
wmSignature2 = zeros(normHeight, normWidth);
imageArea = length(zigzagColMajor);
middle_band_idx = zigzagColMajor(1+3*imageArea/8:3*imageArea/8 + patternSize);
wmSignature2(middle_band_idx) = wmSignature1;

wmSignature2_idct = idct2(wmSignature2);

% mask
maskImage_dbl = double(normInputImage_uint > 0);
normWMSignature = wmSignature2_idct .* maskImage_dbl;

[ normWMFTableX, normWMFTableY, normWMFTableF ] = image2ftable(normWMSignature);

normWMFTableXY = [normWMFTableX normWMFTableY];
regWMFTableXY = (SYXMatrix^(-1) * normWMFTableXY')';
regWMFTableX = regWMFTableXY(:, 1);
regWMFTableY = regWMFTableXY(:, 2);
regWMFTableX = regWMFTableX + meanVector(1);
regWMFTableY = regWMFTableY + meanVector(2);
regWMFTableF = normWMFTableF;

trickShift = min(regWMFTableF);
regWMFTableF_trick = regWMFTableF - trickShift;

regWMSignature_trick_uint = fTable2image(regWMFTableX, regWMFTableY, regWMFTableF_trick);

% regWMSignature = uint8(regWMSignature_uint);
size(regWMSignature_trick_uint)
regWMSignature_trick_uint

% ===================
% Embedding watermark
% ===================
embededImage_uint = uint64(double(inputImage) + double(regWMSignature_trick_uint) + trickShift);
embededImage = uint8(embededImage_uint);
figure;
imshow(embededImage)

sfdji

% ============
% Attack Image
% ============
attackType = 3;
%1 - Shift down without Crop
%2 - Shift right without Crop
%3 - Rotate without Crop
%4 - Scale without Crop
%5 - Shearing in x without Crop
%6 - Shearing in y without Crop
%7 - Shearing in x&y without Crop
%8 - JPEG Compression
paraList = zeros(8, 1);
paraList(1) = 200;
paraList(2) = 200;
% paraList(3) = 30;
paraList(3) = para;
paraList(4) = 1.5;
paraList(5) = 1;
paraList(6) = 1;
paraList(7) = 1;
paraList(8) = 50;

attackedImage_uint = attackGrayUint(uint64(embededImage), attackType, paraList(attackType));

attackedImage = uint8(attackedImage_uint);
if isShow
	figure;
	imshow(attackedImage);
end

% =========================================
% Normalize and De-normalize Attacked Image
% =========================================

[normAttackImage_uint, normAttackImageFTableX, normAttackImageFTableY, normAttackImageFTableF_uint, SYXMatrix_att, meanVector_att] = normalizeImage(attackedImage_uint, normHeight, normWidth, false, selectBeta);

if isShow
	figure
	imshow(uint8(normAttackImage_uint))
	title(['size: ' num2str(size(normAttackImage_uint))])
end


normAttackImageFTableXY = [normAttackImageFTableX normAttackImageFTableY];
regAttackImageFTableXY = (SYXMatrix^(-1) * normAttackImageFTableXY')';
regAttackImageFTableX = regAttackImageFTableXY(:, 1);
regAttackImageFTableY = regAttackImageFTableXY(:, 2);
regAttackImageFTableX = regAttackImageFTableX + meanVector(1);
regAttackImageFTableY = regAttackImageFTableY + meanVector(2);
regAttackImageFTableF_uint = normAttackImageFTableF_uint;

regAttackedImage_uint = fTable2image(regAttackImageFTableX, regAttackImageFTableY, regAttackImageFTableF_uint);

regAttackedImage = uint8(regAttackedImage_uint);

if isShow
	figure
	imshow(regAttackedImage)
end

% Adjust
if isAdjust
	% regAttackedImage = regAttackedImage(:, 2:end-1);
	regAttackedImage = regAttackedImage(2:end-1, 2:end-1);
end

% =================
% Extract watermark
% =================
embededImage_dct = dct2(regAttackedImage);
cw = embededImage_dct(middle_band_idx);

extractedWM = patterns' * cw;
extractedWM = extractedWM > 0;

wmDiff = extractedWM - watermark;
bitErrorRate = 100 * nnz(wmDiff) / length(watermark)

if isShow
	size(regAttackedImage)
end

PSNR_WM_ORI = psnr(embededImage, inputImage)
PSNR_REG_WM = psnr(regAttackedImage, embededImage)




