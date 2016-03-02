function [n_bigd, g_bigd, lambda_bigd, mu_bigd] = javaPaillierKeygen(p_bigd, q_bigd)

% =================
% key gen
% =================
p_minus1_bigd = p_bigd.subtract(java.math.BigDecimal('1'));
q_minus1_bigd = q_bigd.subtract(java.math.BigDecimal('1'));
phi_bigd = p_minus1_bigd.multiply(q_minus1_bigd);


n_bigd = p_bigd.multiply(q_bigd);
nSquare_bigd = n_bigd.multiply(n_bigd);

g_bigd = n_bigd.add(java.math.BigDecimal('1'));
lambda_bigd = phi_bigd;
phi_minus1_bigd = phi_bigd.subtract(java.math.BigDecimal('1'));

mu_bigd = javaFastPowerMod(phi_bigd, phi_minus1_bigd, n_bigd);
