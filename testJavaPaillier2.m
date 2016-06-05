clear
clc

% 19 = 3 x 5 + 4
% 19 = 4 mod 3
ONE_BIGD = java.math.BigDecimal('1');
THREE_BIGD = java.math.BigDecimal('5');

% ==========
% KeyGen
% ==========
p_bigd = java.math.BigDecimal('65519');
q_bigd = java.math.BigDecimal('65521');
[n_bigd, g_bigd, lambda_bigd, mu_bigd] = javaPaillierKeygen(p_bigd, q_bigd);

r_bigd = java.math.BigDecimal('59');
% r_bigd = java.math.BigDecimal('1');

m_bigd = java.math.BigDecimal('19');
m0_bigd = java.math.BigDecimal('4');


c_bigd = javaPaillierEncrypt(m_bigd, n_bigd, g_bigd, r_bigd)
c0_bigd = javaPaillierEncrypt(m0_bigd, n_bigd, g_bigd, r_bigd)

disp('===============');

% recM_bigd = javaPaillierDecrypt(c_bigd, n_bigd, lambda_bigd, mu_bigd)
% recM0_bigd = javaPaillierDecrypt(c0_bigd, n_bigd, lambda_bigd, mu_bigd)


nSquare_bigd = n_bigd.pow(2);
p_minus1_bigd = p_bigd.subtract(ONE_BIGD);
q_minus1_bigd = q_bigd.subtract(ONE_BIGD);
phi_nSquare_bigd = p_bigd.multiply(p_minus1_bigd);
phi_nSquare_bigd = phi_nSquare_bigd.multiply(q_bigd);
phi_nSquare_bigd = phi_nSquare_bigd.multiply(q_minus1_bigd);
phi_nSquare_minus1_bigd = phi_nSquare_bigd.subtract(ONE_BIGD);

g_pow_bigd = javaFastPowerMod(g_bigd, THREE_BIGD, nSquare_bigd);

g_pow_inv_bigd = javaFastPowerMod(g_pow_bigd, phi_nSquare_minus1_bigd, nSquare_bigd);

disp('===============');

a = c_bigd;
b = g_pow_inv_bigd;

a = a.multiply(b); a = a.remainder(nSquare_bigd)
aa = javaPaillierDecrypt(a, n_bigd, lambda_bigd, mu_bigd)
% dispthese_debug('1.', a, ' -> ', aa);

a = a.multiply(b); a = a.remainder(nSquare_bigd)
aa = javaPaillierDecrypt(a, n_bigd, lambda_bigd, mu_bigd)
% dispthese_debug('2', a, ' -> ', aa);

a = a.multiply(b); a = a.remainder(nSquare_bigd)
aa = javaPaillierDecrypt(a, n_bigd, lambda_bigd, mu_bigd)
% dispthese_debug('3', a, ' -> ', aa);

a = a.multiply(b); a = a.remainder(nSquare_bigd)
aa = javaPaillierDecrypt(a, n_bigd, lambda_bigd, mu_bigd)
% dispthese_debug('4', a, ' -> ', aa);

a = a.multiply(b); a = a.remainder(nSquare_bigd)
aa = javaPaillierDecrypt(a, n_bigd, lambda_bigd, mu_bigd)
% dispthese_debug('5', a, ' -> ', aa);

a = a.multiply(b); a = a.remainder(nSquare_bigd)
aa = javaPaillierDecrypt(a, n_bigd, lambda_bigd, mu_bigd)
% dispthese_debug('6', a, ' -> ', aa);

