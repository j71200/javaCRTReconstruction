close all
clear
clc


p_bigd = java.math.BigDecimal('33478071698956898786044169848212690817704794983713768568912431388982883793878002287614711652531743087737814467999489');
q_bigd = java.math.BigDecimal('36746043666799590428244633799627952632279158164343087642676032283815739666511279233373417143396810270092798736308917');
n_bigd = p_bigd.multiply(q_bigd);
bound_bigd = n_bigd.divide(dbl2bigd(2));

load('mat/primeList_502_bigd.mat');

a = primeList_502_bigd;

product_bigd = dbl2bigd(1);
for idx = 1:84
	product_bigd = product_bigd.multiply(a(idx));
end 

product_bigd.compareTo(bound_bigd)

% inputImage = imread('images/lena_gray.png');
% smallInputImage = imresize(inputImage, 0.25);
% figure
% imshow(smallInputImage)
% % [height_dbl width_dbl] = size(smallInputImage);
% % totalPixels = height_dbl * width_dbl;

% imwrite(smallInputImage, 'images/lena_gray_128.png');




% ONE_BIGD = java.math.BigDecimal('1');

% % RSA-768 (232 digits)
% p_bigd = java.math.BigDecimal('33478071698956898786044169848212690817704794983713768568912431388982883793878002287614711652531743087737814467999489');
% q_bigd = java.math.BigDecimal('36746043666799590428244633799627952632279158164343087642676032283815739666511279233373417143396810270092798736308917');

% [n_bigd, g_bigd, lambda_bigd, mu_bigd] = javaPaillierKeygen(p_bigd, q_bigd);


% ciphertext = [];
% % Encrypt pixel by pixel
% parfor idx = 1:totalPixels
% 	disp( (idx/totalPixels) * 100)

% 	r_dbl = round(rand(1) * 10^10);
% 	r_dbl = java.math.BigDecimal(num2str(r_dbl));

% 	m_bigd = dbl2bigd(smallInputImage(idx));
% 	c_bigd = javaPaillierEncrypt(m_bigd, n_bigd, g_bigd, r_dbl);

% 	ciphertext = [ciphertext c_bigd];
% end





% 256 pixel needs 218 s
% Elapsed time is 218.446858 seconds.



% uint64's upper bound:
% 18446744073709551615

%       18446744073709551615
% n^2 = 18446742914068399921
% n   =           4294967161
% p   =                65413
% q   =                65537




