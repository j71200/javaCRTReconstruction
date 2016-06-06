function cReconData_bigd = expParaCRTReconstruct(vData, vModului)


% vData    = [98, 99, 105, 201, 82, 223, 67];
% vModului = [257, 263, 269];
% x = 8843211, 14390916, 9409351

reconFactor = length(vModului);
numRNS = ceil(length(vData) / reconFactor);

% ==============
% Append vData
% ==============
if mod(length(vData), reconFactor) ~= 0
	vTempData = vData;
	vData = zeros(numRNS*reconFactor, 1);
	vData(1:length(vTempData)) = vTempData;
end



ZERO_BIGD  = java.math.BigDecimal('0');
ONE_BIGD  = java.math.BigDecimal('1');

% ======================================
% Produce M and double to bigdecimal
% ======================================

M_bigd = ONE_BIGD;
cModului_bigd = cell(length(vModului), 1);
for idx = 1:reconFactor
	modulus_i_bigd = dbl2bigd(vModului(idx));
	M_bigd = M_bigd.multiply(modulus_i_bigd);

	cModului_bigd{idx} = modulus_i_bigd;
end


% ========================
% Form the auxiMultiplier
% ========================
cAuxiMultiplier_bigd = cell(reconFactor, 1);
parfor idx = 1:reconFactor
	modulus_i_bigd = cModului_bigd{idx};

	mDividMi_bigd = M_bigd.divide(modulus_i_bigd);
	[invMDividMi_bigd, ~] = javaModularInverse(mDividMi_bigd, modulus_i_bigd);
	tempAuxiMultiplier_bigd = mDividMi_bigd.multiply(invMDividMi_bigd);
	tempAuxiMultiplier_bigd = tempAuxiMultiplier_bigd.remainder(M_bigd);
	cAuxiMultiplier_bigd{idx} = tempAuxiMultiplier_bigd;
end


% ==============
% Reconstructing
% ==============

cReconData_bigd = cell(numRNS, 1);

parfor idx = 1:numRNS
	tempReconData_bigd = ZERO_BIGD;
	for jdx = 1:reconFactor
		auxiMultiplier_i_bigd = cAuxiMultiplier_bigd{jdx};
		data_i_bigd = dbl2bigd(vData((idx-1)*reconFactor + jdx));
		temp_bigd = auxiMultiplier_i_bigd.multiply(data_i_bigd);
		tempReconData_bigd = tempReconData_bigd.add(temp_bigd);
		tempReconData_bigd = tempReconData_bigd.remainder(M_bigd);
	end
	cReconData_bigd{idx} = tempReconData_bigd;
end


end

