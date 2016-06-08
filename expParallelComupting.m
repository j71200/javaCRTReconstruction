close all
clear
clc

% 這個程式是在測試CRT在decryption上的speed up能力

% 	一般	CRT	平行(加CRT)
% 1	0.992949	0.116595	0.653177
% 2	0.999928	0.131975	0.695054
% 3	0.895217	0.181487	0.719348
% 4	0.969356	0.118910	0.685313
% 5	0.935162	0.115446	0.756767
% 6	1.006315	0.125840	0.690778
% 7	0.930546	0.118224	0.671879
% 8	0.993745	0.115025	0.637278
% 9	0.950020	0.197075	0.740744
% 10	0.993424	0.108558	0.626355
% Mean	0.9666662	0.1329135	0.6876693
% STD	0.0372751	0.0305931	0.0426907



ONE_BIGD = java.math.BigDecimal('1');

% RSA-768 (232 digits)
p_bigd = java.math.BigDecimal('33478071698956898786044169848212690817704794983713768568912431388982883793878002287614711652531743087737814467999489');
q_bigd = java.math.BigDecimal('36746043666799590428244633799627952632279158164343087642676032283815739666511279233373417143396810270092798736308917');

[n_bigd, g_bigd, lambda_bigd, mu_bigd] = javaPaillierKeygen(p_bigd, q_bigd);

m_uint = uint64(rand(1) * 10^17);
m_bigd = dbl2bigd(m_uint);
r_uint = uint64(rand(1) * 10^17);
r_bigd = dbl2bigd(r_uint);
% m_bigd = java.math.BigDecimal('1990110819901002');
% r_bigd = java.math.BigDecimal('3');

c_bigd = javaPaillierEncrypt(m_bigd, n_bigd, g_bigd, r_bigd);

nonParaTic = tic;
recM_bigd = javaPaillierDecrypt(c_bigd, n_bigd, lambda_bigd, mu_bigd);
toc(nonParaTic)
recM_bigd

disp('======================')

paraTic = tic;
vPrime_bigd = [p_bigd, q_bigd];
vPrimeSquare_bigd = [p_bigd.pow(2), q_bigd.pow(2)];
cMPrime_bigd = {ONE_BIGD, ONE_BIGD};

parfor idx = 1:2
	tempVH_bigd = javaFastPowerMod(g_bigd, vPrime_bigd(idx).subtract(ONE_BIGD), vPrimeSquare_bigd(idx));
	tempVH_bigd = tempVH_bigd.subtract(ONE_BIGD);
	tempVH_bigd = tempVH_bigd.divide(vPrime_bigd(idx));
	[tempVH_bigd, ~] = javaModularInverse(tempVH_bigd, vPrime_bigd(idx));

	tempVMPrime_bigd = javaFastPowerMod(c_bigd, vPrime_bigd(idx).subtract(ONE_BIGD), vPrimeSquare_bigd(idx));
	tempVMPrime_bigd = tempVMPrime_bigd.subtract(ONE_BIGD);
	tempVMPrime_bigd = tempVMPrime_bigd.divide(vPrime_bigd(idx));
	tempVMPrime_bigd = tempVMPrime_bigd.multiply(tempVH_bigd);
	tempVMPrime_bigd = tempVMPrime_bigd.remainder(vPrime_bigd(idx));

	cMPrime_bigd{idx} = tempVMPrime_bigd;
end

crtTic = tic;
vMPrime_bigd = [cMPrime_bigd{1} cMPrime_bigd{2}];
[x_bigd, ~] = javaCRT(vMPrime_bigd, vPrime_bigd);
toc(crtTic)

toc(paraTic)
x_bigd



