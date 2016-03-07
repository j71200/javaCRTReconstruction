clear
clc

load('mat/interrupted_head.mat');


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
