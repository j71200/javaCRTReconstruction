close all
clear
clc

inputImage = imread('images/lena_gray.png');
smallInputImage = imresize(inputImage, 0.03125);
% figure
% imshow(smallInputImage)
[height_dbl width_dbl] = size(smallInputImage);
totalPixels = height_dbl * width_dbl;


ONE_BIGD = java.math.BigDecimal('1');

% RSA-768 (232 digits)
p_bigd = java.math.BigDecimal('33478071698956898786044169848212690817704794983713768568912431388982883793878002287614711652531743087737814467999489');
q_bigd = java.math.BigDecimal('36746043666799590428244633799627952632279158164343087642676032283815739666511279233373417143396810270092798736308917');

[n_bigd, g_bigd, lambda_bigd, mu_bigd] = javaPaillierKeygen(p_bigd, q_bigd);


% ciphertext = cell(totalPixels, 1);
% % Encrypt pixel by pixel
% tic
% % for idx = 1:totalPixels
% parfor idx = 1:totalPixels
% 	r_dbl = round(rand(1) * 10^10);
% 	r_dbl = java.math.BigDecimal(num2str(r_dbl));

% 	m_bigd = dbl2bigd(smallInputImage(idx));
% 	c_bigd = javaPaillierEncrypt(m_bigd, n_bigd, g_bigd, r_dbl);

% 	ciphertext{idx} = c_bigd;
% end
% toc


tic
vPlaintext = reshape(smallInputImage, totalPixels, 1);
cCiphertext = expParaPaillierEncryption(vPlaintext, n_bigd, g_bigd);
toc

% General time
% 256 pixel needs 218 s

% Parallel time
% 256 pixel needs 108 s


% General time on Server
% 256 pixel needs 334 s

% Parallel time on Server
% 256 pixel needs 37 s

