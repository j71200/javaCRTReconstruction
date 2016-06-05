close all
clear
clc


ONE_BIGD = java.math.BigDecimal('1');


% RSA-768 (232 digits)
p_uint = 65413;
q_uint = 65537;
n_uint = p_uint * q_uint;
p_bigd = dbl2bigd(p_uint);
q_bigd = dbl2bigd(q_uint);

[n_bigd, g_bigd, lambda_bigd, mu_bigd] = javaPaillierKeygen(p_bigd, q_bigd);

m_bigd = java.math.BigDecimal('1990');
r_bigd = java.math.BigDecimal('3');

c_bigd = javaPaillierEncrypt(m_bigd, n_bigd, g_bigd, r_bigd);


vPrime_uint = [p_uint, q_uint];
vPrimeSquare_uint = vPrime_uint.^2;
vH_uint = uint64([1 1]);
vMPrime_uint = uint64([1 1]);

tic
parfor idx = 1:2
% for idx = 1:2
	tempVPrime_bigd = dbl2bigd(vPrime_uint(idx));
	tempVPrimeSquare_bigd = dbl2bigd(vPrimeSquare_uint(idx));

	tempH_bigd = javaFastPowerMod(g_bigd, tempVPrime_bigd.subtract(ONE_BIGD), tempVPrimeSquare_bigd);
	tempH_bigd = tempH_bigd.subtract(ONE_BIGD);
	tempH_bigd = tempH_bigd.divide(tempVPrime_bigd);
	[tempH_bigd, ~] = javaModularInverse(tempH_bigd, tempVPrime_bigd);

	vH_uint(idx) = uint64(bigd2dbl(tempH_bigd));

	tempMPrime_bigd = javaFastPowerMod(c_bigd, tempVPrime_bigd.subtract(ONE_BIGD), tempVPrimeSquare_bigd);
	tempMPrime_bigd = tempMPrime_bigd.subtract(ONE_BIGD);
	tempMPrime_bigd = tempMPrime_bigd.divide(tempVPrime_bigd);
	tempMPrime_bigd = tempMPrime_bigd.multiply(tempH_bigd);
	tempMPrime_bigd = tempMPrime_bigd.remainder(tempVPrime_bigd);

	vMPrime_uint(idx) = uint64(bigd2dbl(tempMPrime_bigd));
end
toc


[x_bigd, ~] = javaCRT(dbl2bigd(vMPrime_uint), dbl2bigd(vPrime_uint));
x_bigd


