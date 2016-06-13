close all
clear
clc

% 16
% 32
% 64
% 128
% 256
% 512

scaleRatio = 512/512;
repeatTimes = 1;

elapsedKeyGen = zeros(repeatTimes, 1);
elapsedReconstruct = zeros(repeatTimes, 1);
elapsedEncryption = zeros(repeatTimes, 1);
elapsedDecryption = zeros(repeatTimes, 1);
elapsedInvRecon = zeros(repeatTimes, 1);

disp(['scaleRatio: ' num2str(scaleRatio)]);
for repeatIdx = 1:repeatTimes
	disp(['repeat: ' num2str(repeatIdx)]);
	a = clock;
	disp(['Start at ' num2str(a(2)) '/' num2str(a(3)) ' ' num2str(a(4)) ':' num2str(a(5))]);



	inputImage = imread('images/lena_gray.png');
	smallInputImage = imresize(inputImage, scaleRatio);
	[height, width] = size(smallInputImage);
	totalPixels = height * width;

	% ========================
	% KeyGen
	% ========================
	% RSA-768 (232 digits)
	ticKeyGen = tic;
	p_bigd = java.math.BigDecimal('33478071698956898786044169848212690817704794983713768568912431388982883793878002287614711652531743087737814467999489');
	q_bigd = java.math.BigDecimal('36746043666799590428244633799627952632279158164343087642676032283815739666511279233373417143396810270092798736308917');

	[n_bigd, g_bigd, lambda_bigd, mu_bigd] = javaPaillierKeygen(p_bigd, q_bigd);
	elapsedKeyGen = toc(ticKeyGen);

	vPlaintext = reshape(smallInputImage, totalPixels, 1);


	% ========================
	% Genertate watermark
	% ========================
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

	% wmSignature2_idct_trick = round(wmSignature2_idct);
	% trickShift = min(min(wmSignature2_idct_trick));
	% wmSignature2_idct_trick_uint = wmSignature2_idct_trick - trickShift + 1;
	% wmSignature2_idct_trick_uint = uint64(wmSignature2_idct_trick_uint);

	% reconWmSignature2_idct_trick_bigd = javaCRTReconstruct(wmSignature2_idct_trick_uint, modulus_bigd);

	trickShift = min(min(wmSignature2_idct));
	wmSignature2_idct_trick = wmSignature2_idct - trickShift;
	wmSignature2_idct_trick = round(wmSignature2_idct_trick) + 1;


	% ========================
	% Reconstruction image
	% ========================
	load('mat/primeList_502_bigd.mat');

	reconFactor = 84;
	vModului_bigd = primeList_502_bigd(1:reconFactor);

	ticReconstruct = tic;
	cReconData_bigd = expParaCRTReconstruct(vPlaintext, vModului_bigd);
	elapsedReconstruct = toc(ticReconstruct);

	% ========================
	% Reconstruction watermark
	% ========================
	vWmSignature2_idct_trick = reshape(wmSignature2_idct_trick, normWidth*normHeight, 1);
	cReconWatermark_bigd = expParaCRTReconstruct(vWmSignature2_idct_trick, vModului_bigd);

	% ========================
	% Encrypting image
	% ========================
	ticEncryption = tic;
	cCiphertext_bigd = expParaPaillierEncryption(cReconData_bigd, n_bigd, g_bigd);
	elapsedEncryption = toc(ticEncryption);

	% ========================
	% Encrypting watermark
	% ========================
	cEncryptedWatermark_bigd = expParaPaillierEncryption(cReconWatermark_bigd, n_bigd, g_bigd);


	% ========================
	% Embedding watermark
	% ========================
	cEncEmbImage_bigd = cell(length(cCiphertext_bigd), 1);
	parfor idx = 1:length(cCiphertext_bigd)
		cEncEmbImage_bigd{idx} = cCiphertext_bigd{idx}.multiply(cEncryptedWatermark_bigd{idx});
		cEncEmbImage_bigd{idx} = cEncEmbImage_bigd{idx}.remainder(n_bigd.pow(2));
	end

	% ========================
	% Decryption
	% ========================
	ticDecryption = tic;
	cDecryptedMessage_bigd = expParaPaillierDecryption(cEncEmbImage_bigd, n_bigd, lambda_bigd, mu_bigd);
	elapsedDecryption = toc(ticDecryption);

	% ========================
	% Inverse-reconstruction
	% ========================
	ticInvRecon = tic;
	vRecoveredMessage = expParaCRTInvReconstruct(cDecryptedMessage_bigd, vModului_bigd, totalPixels);
	elapsedInvRecon = toc(ticInvRecon);


	% ========================
	% Examining
	% ========================
	recoveredImage = uint8(vRecoveredMessage);
	recoveredImage = reshape(recoveredImage, height, width);
	% figure
	% imshow(recoveredImage)
	psnr(recoveredImage, smallInputImage)
	% if nnz(double(recoveredImage) - double(smallInputImage)) ~= 0
	% 	warning('recoveredImage is not equals to smallInputImage on scaleRatio %f.', scaleRatio);
	% end



	% ========================
	% To be deleted
	% ========================
	% [elapsedKeyGen(repeatIdx), elapsedReconstruct(repeatIdx), elapsedEncryption(repeatIdx), elapsedDecryption(repeatIdx), elapsedInvRecon(repeatIdx)] = expParaEncryption(scaleRatio);
	% [elapsedKeyGen(repeatIdx), elapsedEncryption(repeatIdx), elapsedDecryption(repeatIdx)] = expParaEncryptionNoRecon(scaleRatio);
end

save('mat/expImportant.mat');


elapsedKeyGen
elapsedReconstruct
elapsedEncryption
elapsedDecryption
elapsedInvRecon




