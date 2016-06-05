close all
clear('all');
clc


inputImage = imread('images/airplane_gray.png');
[height, width] = size(inputImage);


imgVec = reshape(inputImage, height*width, 1);
uniImgVec = unique(imgVec);


set(0,'RecursionLimit',1000)

% RSA-768 (232 digits)
p_bigd = java.math.BigDecimal('33478071698956898786044169848212690817704794983713768568912431388982883793878002287614711652531743087737814467999489');
q_bigd = java.math.BigDecimal('36746043666799590428244633799627952632279158164343087642676032283815739666511279233373417143396810270092798736308917');
% KeyGen
[n_bigd, g_bigd, lambda_bigd, mu_bigd] = javaPaillierKeygen(p_bigd, q_bigd);


% ZERO_BIGD = java.math.BigDecimal('0');
% encryptedImage_bigd = ZERO_BIGD;
% for idx = 1:height*width-1
% 	encryptedImage_bigd = [encryptedImage_bigd ZERO_BIGD];
% end

tic
ZERO_BIGD = java.math.BigDecimal('0');
encUniImageVec_bigd = ZERO_BIGD;
for idx = 1:length(uniImgVec)-1
	encUniImageVec_bigd = [encUniImageVec_bigd ZERO_BIGD];
end
r_bigd = java.math.BigDecimal('3');

toc


tic
for idx = 1:length(uniImgVec)
	disp(idx)
	pixel = uniImgVec(idx);
	m_bigd = java.math.BigDecimal(num2str(pixel));
	encUniImageVec_bigd(idx) = javaPaillierEncrypt(m_bigd, n_bigd, g_bigd, r_bigd);
end

toc

encryptedImage_bigd = ZERO_BIGD;
for idx = 1:19
	encryptedImage_bigd = [encryptedImage_bigd encryptedImage_bigd];
end


% ====

tic
for idx = 1:length(imgVec)
	encryptedImage_bigd(idx) = encUniImageVec_bigd(imgVec(idx)-15);
end
toc

% ===







