function cRecoveredMessage = expParaPaillierDecryption(cCiphertext, n_bigd, lambda_bigd, mu_bigd)


% n_bigd, g_bigd, lambda_bigd, mu_bigd
% p_bigd, q_bigd


nSquare_bigd = n_bigd.pow(2);

numCiphertext = length(cCiphertext);
cRecoveredMessage = cell(numCiphertext, 1);

parfor idx = 1:numCiphertext
	c_bigd = cCiphertext{idx};

	recU_bigd = javaFastPowerMod(c_bigd, lambda_bigd, nSquare_bigd);

	temp_recU_bigd = recU_bigd.subtract(java.math.BigDecimal('1'));
	recL_bigd = temp_recU_bigd.divideToIntegralValue(n_bigd);

	recM_bigd = recL_bigd.multiply(mu_bigd);
	recM_bigd = recM_bigd.remainder(n_bigd);

	cRecoveredMessage{idx} = recM_bigd;
end







% nSquare_bigd = n_bigd.pow(2);

% recU_bigd = javaFastPowerMod(c_bigd, lambda_bigd, nSquare_bigd);

% temp_recU_bigd = recU_bigd.subtract(java.math.BigDecimal('1'));
% recL_bigd = temp_recU_bigd.divideToIntegralValue(n_bigd);

% recM_bigd = recL_bigd.multiply(mu_bigd);
% recM_bigd = recM_bigd.remainder(n_bigd);





end
