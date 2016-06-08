function [elapsedKeyGen, elapsedEncryption, elapsedDecryption, smallInputImage, decryptedImage] = expParaEncryptionNoRecon(scaleRatio)
% close all
% clear
% clc


inputImage = imread('images/lena_gray.png');
smallInputImage = imresize(inputImage, scaleRatio);

% smallInputImage = imresize(inputImage, 0.03125); % smallInputImage is 16 x 16
% smallInputImage = imresize(inputImage, 1/4); % smallInputImage is 128 x 128
% smallInputImage = inputImage;

% figure
% imshow(smallInputImage)
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
% Reconstruction
% ========================
% load('mat/primeList_502_bigd.mat');

% reconFactor = 208;
% vModului_bigd = primeList_502_bigd(1:reconFactor);

% ticReconstruct = tic;
% cReconData_bigd = expParaCRTReconstruct(vPlaintext, vModului_bigd);
% elapsedReconstruct = toc(ticReconstruct);



% cReconData_bigd = cell(totalPixels, 1);
% parfor idx = 1:totalPixels
% 	cReconData_bigd{idx} = dbl2bigd(vPlaintext(idx));
% end

% ========================
% Encryption
% ========================
ticEncryption = tic;
cCiphertext_bigd = expParaPaillierEncryption(vPlaintext, n_bigd, g_bigd);
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
% cDecryptedMessage_bigd = cReconData_bigd;
% ticInvRecon = tic;
% vRecoveredMessage = expParaCRTInvReconstruct(cDecryptedMessage_bigd, vModului_bigd, totalPixels);
% elapsedInvRecon = toc(ticInvRecon);


% ========================
% Examining
% ========================
if length(cDecryptedMessage_bigd) ~= totalPixels
	warning('Decrypted message has different size.');
else
	decryptedImage = zeros(height, width, 'uint8');
	parfor idx = 1:totalPixels
		decryptedImage(idx) = uint8(bigd2dbl(cDecryptedMessage_bigd{idx}));
	end
end

figure
imshow(decryptedImage)
% psnr(decryptedImage, smallInputImage)

% recoveredImage = uint8(vRecoveredMessage);
% recoveredImage = reshape(recoveredImage, height, width);
% % figure
% % imshow(recoveredImage)
% if nnz(double(recoveredImage) - double(smallInputImage)) ~= 0
% 	warning('recoveredImage is not equals to smallInputImage on scaleRatio %f.', scaleRatio);
% end


% =========== Without the reconstruction ===========
% General time
% 16x16 pixel needs 218 s

% Parallel time
% 16x16 pixel needs 108 s

% General time on Server
% 16x16 pixel needs 334 s

% Parallel time on Server
% 16x16 pixel needs 37 s

% =========== 16x16 ===========
% General time
% 16x16 pixel needs  s

% Parallel time
% 16x16 pixel needs 108 s
% 16x16 pixel needs 0.92 + 3.56 = 4.48 s

% General time on Server
% 16x16 pixel needs  s

% Parallel time on Server
% 16x16 pixel needs 37 s
% 16x16 pixel needs 0.74 + 4.69 = 5.43 s

% =========== 128x128 ===========
% General time
% 128x128 pixel needs  s

% Parallel time
% 128x128 pixel needs  s
% 128x128 pixel needs 9.51 + 163.79 = 173.30 s

% General time on Server
% 128x128 pixel needs  s

% Parallel time on Server
% 128x128 pixel needs  s
% 128x128 pixel needs 3.36 + 40.79 = 44.15 s

% =========== 512x512 ===========
% General time
% 512x512 pixel needs  s

% Parallel time
% 512x512 pixel needs 133.84 + __ s

% General time on Server
% 512x512 pixel needs  s

% Parallel time on Server
% 512x512 pixel needs  s
% 512x512 pixel needs 38.64 + 610.92 = 649.56 s

end