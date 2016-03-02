function reconData_bigd = javaCRTReconstruct(grayImage_uint, modulus_bigd)

divisor = length(modulus_bigd);

[height, width] = size(grayImage_uint);
totalPixelNum = height * width;
groupNum = ceil(totalPixelNum / divisor);

ZERO_BIGD = java.math.BigDecimal('0');
ONE_BIGD  = java.math.BigDecimal('1');
TWO_BIGD  = java.math.BigDecimal('2');

% ===============
% Product the mi
% ===============
M_bigd = ONE_BIGD;
for idx = 1:divisor
	modulus_i_bigd = modulus_bigd(idx);
	M_bigd = M_bigd.multiply(modulus_i_bigd);
end

% ================================
% Initializing the auxiMultiplier
% ================================
auxiMultiplier_bigd = ZERO_BIGD;
for idx = 1:divisor-1
	auxiMultiplier_bigd = [auxiMultiplier_bigd, ZERO_BIGD];
end

% ========================
% Form the auxiMultiplier
% ========================
% parfor idx = 1:divisor  % Infeasible
for idx = 1:divisor
	modulus_i_bigd = modulus_bigd(idx);
	mDividMi_bigd = M_bigd.divide(modulus_i_bigd);

	modulus_i_minus2_bigd = modulus_i_bigd.subtract(TWO_BIGD);
	invMDividMi_bigd = javaFastPowerMod(mDividMi_bigd, modulus_i_minus2_bigd, modulus_i_bigd);

	auxiMultiplier_bigd(idx) = mDividMi_bigd;
	auxiMultiplier_bigd(idx) = auxiMultiplier_bigd(idx).multiply(invMDividMi_bigd);
	auxiMultiplier_bigd(idx) = auxiMultiplier_bigd(idx).remainder(M_bigd);
end

% ================================
% Initializing the reconData_bigd
% ================================
reconData_bigd = ZERO_BIGD;
for idx = 1:groupNum-1
	reconData_bigd = [reconData_bigd ZERO_BIGD];
end

% ============
% Reconstruct
% ============
parfor groupIdx = 1:(groupNum-1)  % Feasible
% for groupIdx = 1:(groupNum-1)
	groupStartIdx = (groupIdx-1) * divisor + 1;
	groupEndIdx = groupStartIdx + divisor - 1;
	groupPixels_uint = grayImage_uint(groupStartIdx:groupEndIdx)';

	groupPixels_bigd = java.math.BigDecimal(num2str(groupPixels_uint(1)));
	for idx = 2:divisor
		groupPixels_bigd = [groupPixels_bigd, java.math.BigDecimal(num2str(groupPixels_uint(idx)))];
	end

	[reconData_bigd(groupIdx), ~] = javaCRT(groupPixels_bigd, modulus_bigd, false, auxiMultiplier_bigd);
end

groupStartIdx = (groupNum-1) * divisor + 1;
groupPixels_uint = zeros(divisor, 1, 'uint64');
groupPixels_uint(1:totalPixelNum-groupStartIdx+1) = grayImage_uint(groupStartIdx:end);

groupPixels_bigd = java.math.BigDecimal(num2str(groupPixels_uint(1)));
for idx = 2:divisor
	groupPixels_bigd = [groupPixels_bigd, java.math.BigDecimal(num2str(groupPixels_uint(idx)))];
end
[reconData_bigd(groupNum), ~] = javaCRT(groupPixels_bigd, modulus_bigd, false, auxiMultiplier_bigd);

end
