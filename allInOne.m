clear
clc

wholeProcessStart_str = dispTime(0);

% parpool

load('mat/primeList_502_bigd.mat');

divisor = 64;
modulus_bigd = primeList_502_bigd(1:divisor);
inputImage_uint = uint64(imread('images/airplane_gray.png'));
ZERO_BIGD = java.math.BigDecimal('0');


% ==========
% KeyGen
% ==========
% RSA-576 (174 digits)
p_bigd = java.math.BigDecimal('398075086424064937397125500550386491199064362342526708406385189575946388957261768583317');
q_bigd = java.math.BigDecimal('472772146107435302536223071973048224632914695302097116459852171130520711256363590397527');
[n_bigd, g_bigd, lambda_bigd, mu_bigd] = javaPaillierKeygen(p_bigd, q_bigd);


disp('====================');
disp('Reconstructing Image');
disp('====================');
disp(['Start at ' dispTime(0)]);

recon_airplane_bigd = javaCRTReconstruct(inputImage_uint, modulus_bigd);

save('mat/allInOne_1_rec_image.mat');
disp(['End at ' dispTime(0)]);


disp('========================');
disp('Reconstructing Watermark');
disp('========================');
disp(['Start at ' dispTime(0)]);

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
wmSignature2_idct_trick_uint = wmSignature2_idct_trick - trickShift + 1;
wmSignature2_idct_trick_uint = uint64(wmSignature2_idct_trick_uint);

reconWmSignature2_idct_trick_bigd = javaCRTReconstruct(wmSignature2_idct_trick_uint, modulus_bigd);

save('mat/allInOne_2_rec_watermark.mat');
disp(['End at ' dispTime(0)]);



disp('=============');
disp('Encrypt Image');
disp('=============');
disp(['Start at ' dispTime(0)]);

reconImage_bigd = recon_airplane_bigd;
groupNums = length(reconImage_bigd);

ZERO_BIGD = java.math.BigDecimal('0');
encryptedImage_bigd = ZERO_BIGD;
for idx = 1:groupNums-1
	encryptedImage_bigd = [encryptedImage_bigd ZERO_BIGD];
end

r_bigd = java.math.BigDecimal('3');
totalElapsedTime = 0;

% idx = 1;
for idx = 1:groupNums
% parfor idx = 1:groupNums
	tic
	m_bigd = reconImage_bigd(idx);
	encryptedImage_bigd(idx) = javaPaillierEncrypt(m_bigd, n_bigd, g_bigd, r_bigd);
	elapsedTime = toc;
	totalElapsedTime = totalElapsedTime + elapsedTime;

	dispthese_debug('EncIM: idx =', idx, '; time =', elapsedTime, '; total =', totalElapsedTime);
end

save('mat/allInOne_3_enc_image.mat');
disp(['End at ' dispTime(0)]);


disp('=================');
disp('Encrypt Watermark');
disp('=================');
disp(['Start at ' dispTime(0)]);

reconWatermark_bigd = reconWmSignature2_idct_trick_bigd;
groupNums = length(reconWatermark_bigd);

ZERO_BIGD = java.math.BigDecimal('0');
encryptedWatermark_bigd = ZERO_BIGD;
for idx = 1:groupNums-1
	encryptedWatermark_bigd = [encryptedWatermark_bigd ZERO_BIGD];
end

r_bigd = java.math.BigDecimal('3');
totalElapsedTime = 0;

% idx = 1;
for idx = 1:groupNums
% parfor idx = 1:groupNums
	tic
	m_bigd = reconWatermark_bigd(idx);
	encryptedWatermark_bigd(idx) = javaPaillierEncrypt(m_bigd, n_bigd, g_bigd, r_bigd);
	elapsedTime = toc;
	totalElapsedTime = totalElapsedTime + elapsedTime;

	dispthese_debug('EncWM: idx =', idx, '; time =', elapsedTime, '; total =', totalElapsedTime);
end

save('mat/allInOne_4_enc_watermark.mat');
disp(['End at ' dispTime(0)]);


disp('===================');
disp('Embedding Watermark');
disp('===================');
disp(['Start at ' dispTime(0)]);

nSquare_bigd = n_bigd.pow(2);
embededEncryptedImage_bigd = ZERO_BIGD;
for idx = 1:groupNums-1
	embededEncryptedImage_bigd = [embededEncryptedImage_bigd ZERO_BIGD];
end

parfor idx = 1:groupNums
% for idx = 1:groupNums
	tempProduct_bigd = encryptedImage_bigd(idx).multiply(encryptedWatermark_bigd(idx));
	embededEncryptedImage_bigd(idx) = tempProduct_bigd.remainder(nSquare_bigd);
end
save('mat/allInOne_5_emb_watermark.mat');
disp(['End at ' dispTime(0)]);

disp('=============');
disp('Decrypt Image');
disp('=============');
disp(['Start at ' dispTime(0)]);

reconEmbededImage_bigd = ZERO_BIGD;
for idx = 1:groupNums-1
	reconEmbededImage_bigd = [reconEmbededImage_bigd ZERO_BIGD];
end

% parfor 
totalElapsedTime = 0;
for idx = 1:groupNums
	tic
% parfor idx = 1:groupNums
	reconEmbededImage_bigd(idx) = javaPaillierDecrypt(embededEncryptedImage_bigd(idx), n_bigd, lambda_bigd, mu_bigd);
	elapsedTime = toc;
	totalElapsedTime = totalElapsedTime + elapsedTime;
	dispthese_debug('DecIM: idx =', idx, '; time =', elapsedTime, '; total =', totalElapsedTime);
end
save('mat/allInOne_6_dec_image.mat');
disp(['End at ' dispTime(0)]);


disp('=============');
disp('Recover Image');
disp('=============');
disp(['Start at ' dispTime(0)]);

embededImage_uint = javaCRTInvReconstruct(reconEmbededImage_bigd, modulus_bigd, normHeight, normWidth);

save('mat/allInOne_7_recover_image.mat');
disp(['End at ' dispTime(0)]);


wholeProcessEnd_str = dispTime(0);
