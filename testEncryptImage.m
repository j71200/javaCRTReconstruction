clear
clc


% set(0,'RecursionLimit',1000)

% load('mat/reconImages.mat');
load('mat/reconWatermark_d84.mat');

divisor = 84;


% RSA-768 (232 digits)
p_bigd = java.math.BigDecimal('33478071698956898786044169848212690817704794983713768568912431388982883793878002287614711652531743087737814467999489');
q_bigd = java.math.BigDecimal('36746043666799590428244633799627952632279158164343087642676032283815739666511279233373417143396810270092798736308917');
% KeyGen
[n_bigd, g_bigd, lambda_bigd, mu_bigd] = javaPaillierKeygen(p_bigd, q_bigd);


reconImage_bigd = reconWmSignature2_idct_trick_bigd;
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

	dispthese_debug('idx =', idx, '; time =', elapsedTime, '; total =', totalElapsedTime);
end






