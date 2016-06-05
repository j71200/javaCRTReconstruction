close all
clear
clc

ONE_BIGD = java.math.BigDecimal('1');


% RSA-768 (232 digits)
p_bigd = java.math.BigDecimal('33478071698956898786044169848212690817704794983713768568912431388982883793878002287614711652531743087737814467999489');
q_bigd = java.math.BigDecimal('36746043666799590428244633799627952632279158164343087642676032283815739666511279233373417143396810270092798736308917');

[n_bigd, g_bigd, lambda_bigd, mu_bigd] = javaPaillierKeygen(p_bigd, q_bigd);

m_bigd = java.math.BigDecimal('1990');
r_bigd = java.math.BigDecimal('3');

c_bigd = javaPaillierEncrypt(m_bigd, n_bigd, g_bigd, r_bigd);

% tic
% recM_bigd = javaPaillierDecrypt(c_bigd, n_bigd, lambda_bigd, mu_bigd);
% toc
% recM_bigd


% ==============
tic

vPrime_bigd = [p_bigd, q_bigd];
vPrimeSquare_bigd = [p_bigd.pow(2), q_bigd.pow(2)];
vH_bigd = [ONE_BIGD, ONE_BIGD];
vMPrime_bigd = [ONE_BIGD, ONE_BIGD];

parfor idx = 1:2
% for idx = 1:2
	% vH_bigd(idx) = javaFastPowerMod(g_bigd, vPrime_bigd(idx).subtract(ONE_BIGD), vPrimeSquare_bigd(idx));
	% vH_bigd(idx) = vH_bigd(idx).subtract(ONE_BIGD);
	% vH_bigd(idx) = vH_bigd(idx).divide(vPrime_bigd(idx));
	% [vH_bigd(idx), ~] = javaModularInverse(vH_bigd(idx), vPrime_bigd(idx));
	% vMPrime_bigd(idx) = javaFastPowerMod(c_bigd, vPrime_bigd(idx).subtract(ONE_BIGD), vPrimeSquare_bigd(idx));
	% vMPrime_bigd(idx) = vMPrime_bigd(idx).subtract(ONE_BIGD);
	% vMPrime_bigd(idx) = vMPrime_bigd(idx).divide(vPrime_bigd(idx));
	% vMPrime_bigd(idx) = vMPrime_bigd(idx).multiply(vH_bigd(idx));
	% vMPrime_bigd(idx) = vMPrime_bigd(idx).remainder(vPrime_bigd(idx));
end


% pSquare_bigd = p_bigd.pow(2);
% qSquare_bigd = q_bigd.pow(2);

% % modulus p
% hp_bigd = javaFastPowerMod(g_bigd, p_bigd.subtract(ONE_BIGD), pSquare_bigd);
% hp_bigd = hp_bigd.subtract(ONE_BIGD);
% hp_bigd = hp_bigd.divide(p_bigd);
% [hp_bigd, ~] = javaModularInverse(hp_bigd, p_bigd);

% mp_bigd = javaFastPowerMod(c_bigd, p_bigd.subtract(ONE_BIGD), pSquare_bigd);
% mp_bigd = mp_bigd.subtract(ONE_BIGD);
% mp_bigd = mp_bigd.divide(p_bigd);
% mp_bigd = mp_bigd.multiply(hp_bigd);
% mp_bigd = mp_bigd.remainder(p_bigd);

% % modulus q
% hq_bigd = javaFastPowerMod(g_bigd, q_bigd.subtract(ONE_BIGD), qSquare_bigd);
% hq_bigd = hq_bigd.subtract(ONE_BIGD);
% hq_bigd = hq_bigd.divide(q_bigd);
% [hq_bigd, ~] = javaModularInverse(hq_bigd, q_bigd);

% mq_bigd = javaFastPowerMod(c_bigd, q_bigd.subtract(ONE_BIGD), qSquare_bigd);
% mq_bigd = mq_bigd.subtract(ONE_BIGD);
% mq_bigd = mq_bigd.divide(q_bigd);
% mq_bigd = mq_bigd.multiply(hq_bigd);
% mq_bigd = mq_bigd.remainder(q_bigd);

[x_bigd, ~] = javaCRT(vMPrime_bigd, vPrime_bigd);
toc
x_bigd

% nSquare_bigd = n_bigd.pow(2);

% recU_bigd = javaFastPowerMod(c_bigd, lambda_bigd, nSquare_bigd);

% temp_recU_bigd = recU_bigd.subtract(java.math.BigDecimal('1'));
% recL_bigd = temp_recU_bigd.divideToIntegralValue(n_bigd);

% recM_bigd = recL_bigd.multiply(mu_bigd);
% recM_bigd = recM_bigd.remainder(n_bigd);

