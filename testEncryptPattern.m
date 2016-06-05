close all
clear
clc

% load('mat/allInOne_airplane/allInOne_3_enc_image');
load('mat/allInOne_airplane/allInOne_airplane_gray_4_enc_watermark.mat');


TWOFIVEFIVE_BIGD = java.math.BigDecimal('255');
% ZERO_BIGD = java.math.BigDecimal('0');
% ONE_BIGD = java.math.BigDecimal('1');
% TWO_BIGD = java.math.BigDecimal('2');
% encryptedWatermark_bigd = [TWO_BIGD, TWO_BIGD, TWO_BIGD, TWO_BIGD];
% groupNums = 4;


% ============================
% Find the maximum and minimum
% ============================
currMax_bigd = encryptedWatermark_bigd(1);
currMin_bigd = encryptedWatermark_bigd(1);

for idx = 1:groupNums
	isGreatThan = (encryptedWatermark_bigd(idx).compareTo(currMax_bigd) == 1);
	if isGreatThan
		currMax_bigd = encryptedWatermark_bigd(idx);
	end

	isLessThan = (encryptedWatermark_bigd(idx).compareTo(currMin_bigd) == -1);
	if isLessThan
		currMin_bigd = encryptedWatermark_bigd(idx);
	end
end

currMax_bigd
currMin_bigd

% =========
% Normalize
% =========
% normalizedImage_uint = zeros(64, 64, 'uint64');
normalizedImage_dbl = zeros(64, 64);

for idx = 1:groupNums
	numerator_bigd = encryptedWatermark_bigd(idx).subtract(currMin_bigd);
	numerator_bigd = numerator_bigd.multiply(TWOFIVEFIVE_BIGD);

	denominator_bigd = currMax_bigd.subtract(currMin_bigd);

	temp_bigd = numerator_bigd.divideToIntegralValue(denominator_bigd);
	normalizedImage_dbl(idx) = str2num(temp_bigd.toString);
end

normalizedImage = uint8(normalizedImage_dbl);

figure;
imshow(normalizedImage)







