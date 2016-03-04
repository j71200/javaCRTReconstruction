clear
clc

load('mat/reconImages.mat');

divisor = 84;


% RSA-768 (232 digits)
p_bigd = java.math.BigDecimal('33478071698956898786044169848212690817704794983713768568912431388982883793878002287614711652531743087737814467999489');
q_bigd = java.math.BigDecimal('36746043666799590428244633799627952632279158164343087642676032283815739666511279233373417143396810270092798736308917');
% KeyGen
[n_bigd, g_bigd, lambda_bigd, mu_bigd] = javaPaillierKeygen(p_bigd, q_bigd);


reconImage_bigd = recon_airplane_bigd;
groupNums = length(reconImage_bigd);

ZERO_BIGD = java.math.BigDecimal('0');
encryptedImage_bigd = ZERO_BIGD;
for idx = 1:groupNums-1
	encryptedImage_bigd = [encryptedImage_bigd ZERO_BIGD];
end

r_bigd = java.math.BigDecimal('3');
parfor idx = 1:groupNums
	m_bigd = reconImage_bigd(idx);
	encryptedImage_bigd(idx) = javaPaillierEncrypt(m_bigd, n_bigd, g_bigd, r_bigd);
end






