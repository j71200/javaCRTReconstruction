clear
clc

load('mat/encryptedAirplane_bigd');
load('mat/encryptedWatermark_bigd');

groupNums = length(encryptedWatermark_bigd);
nSquare_bigd = n_bigd.pow(2);
ZERO_BIGD = java.math.BigDecimal('0');

embededEncryptedImage_bigd = ZERO_BIGD;
for idx = 1:groupNums-1
	embededEncryptedImage_bigd = [embededEncryptedImage_bigd ZERO_BIGD];
end


tic
parfor idx = 1:groupNums
% for idx = 1:groupNums
	tempProduct_bigd = encryptedAirplane_bigd(idx).multiply(encryptedWatermark_bigd(idx));
	embededEncryptedImage_bigd(idx) = tempProduct_bigd.remainder(nSquare_bigd);
end
toc



% =============
% Decrypt Image
% =============
embededImage_bigd = ZERO_BIGD;
for idx = 1:groupNums-1
	embededImage_bigd = [embededImage_bigd ZERO_BIGD];
end

% parfor 
totalElapsedTime = 0;
for idx = 1:groupNums
	tic
% parfor idx = 1:groupNums
	embededImage_bigd(idx) = javaPaillierDecrypt(embededEncryptedImage_bigd(idx), n_bigd, lambda_bigd, mu_bigd);
	elapsedTime = toc;
	totalElapsedTime = totalElapsedTime + elapsedTime;
	dispthese_debug('idx =', idx, '; time =', elapsedTime, '; total =', totalElapsedTime);
end






