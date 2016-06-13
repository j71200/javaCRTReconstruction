close all
clear
clc

% 16
% 32
% 64
% 128
% 256
% 512

scaleRatio = 16/512;
repeatTimes = 10;

elapsedKeyGen = zeros(repeatTimes, 1);
elapsedReconstruct = zeros(repeatTimes, 1);
elapsedEncryption = zeros(repeatTimes, 1);
elapsedDecryption = zeros(repeatTimes, 1);
elapsedInvRecon = zeros(repeatTimes, 1);

disp(['scaleRatio: ' num2str(scaleRatio)]);
for idx = 1:repeatTimes
	disp(['repeat: ' num2str(idx)]);
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
	% Reconstruction image
	% ========================
	load('mat/primeList_502_bigd.mat');

	reconFactor = 84;
	vModului_bigd = primeList_502_bigd(1:reconFactor);

	ticReconstruct = tic;
	cReconData_bigd = expParaCRTReconstruct(vPlaintext, vModului_bigd);
	elapsedReconstruct = toc(ticReconstruct);


	% ========================
	% Encryption
	% ========================
	ticEncryption = tic;
	cCiphertext_bigd = expParaPaillierEncryption(cReconData_bigd, n_bigd, g_bigd);
	elapsedEncryption = toc(ticEncryption);


	% ========================
	% Decryption
	% ========================
	ticDecryption = tic;
	cDecryptedMessage_bigd = expParaPaillierDecryption(cCiphertext_bigd, n_bigd, lambda_bigd, mu_bigd);
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
	% [elapsedKeyGen(idx), elapsedReconstruct(idx), elapsedEncryption(idx), elapsedDecryption(idx), elapsedInvRecon(idx)] = expParaEncryption(scaleRatio);
	% [elapsedKeyGen(idx), elapsedEncryption(idx), elapsedDecryption(idx)] = expParaEncryptionNoRecon(scaleRatio);
end


elapsedKeyGen
elapsedReconstruct
elapsedEncryption
elapsedDecryption
elapsedInvRecon




