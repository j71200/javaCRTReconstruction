clear
clc

load('mat/_data_wm256_pt256x256.mat');
load('mat/primeList_502_bigd.mat');
divisor = 84;
modulus_bigd = primeList_502_bigd(1:divisor);


normHeight = 512;
normWidth = 512;

wmSize = 50; % 8KB
watermark = randi([0, 1], wmSize, 1);
% patternSize = 64 * 64; % 必須大於大於 wmSize才行
patternSize = 256 * 256; % 必須大於大於 wmSize才行
% patternSize = 400 * 400; % 必須大於大於 wmSize才行
patterns = sign(randn(patternSize, wmSize));


wmSignature1 = patterns * (2*watermark - 1);

% Step 2-(c)
[zigzagColMajor ~] = genaralZigzag(normHeight, normWidth);
wmSignature2 = zeros(normHeight, normWidth);
imageArea = length(zigzagColMajor);
middle_band_idx = zigzagColMajor(1+3*imageArea/8:3*imageArea/8 + patternSize);
wmSignature2(middle_band_idx) = wmSignature1;

% Step 2-(d)
wmSignature2_idct = idct2(wmSignature2);


wmSignature2_idct_trick = round(wmSignature2_idct);
trickShift = min(min(wmSignature2_idct_trick));
wmSignature2_idct_trick_uint = wmSignature2_idct_trick - trickShift + 1;
wmSignature2_idct_trick_uint = uint64(wmSignature2_idct_trick_uint);

tic
reconWmSignature2_idct_trick_bigd = javaCRTReconstruct(wmSignature2_idct_trick_uint, modulus_bigd);
toc

