clear
clc

load('mat/primeList_502_bigd.mat');

divisor = 4;
modulus_bigd = primeList_502_bigd(1:divisor);

numbers = uint64([123, 7, 212, 10]);

reconData_bigd = javaCRTReconstruct(numbers, modulus_bigd);

reconData_bigd.remainder(modulus_bigd(1))
reconData_bigd.remainder(modulus_bigd(2))
reconData_bigd.remainder(modulus_bigd(3))
reconData_bigd.remainder(modulus_bigd(4))

disp('=====================');
% ==========
% KeyGen
% ==========
p_bigd = java.math.BigDecimal('65519');
q_bigd = java.math.BigDecimal('65521');
[n_bigd, g_bigd, lambda_bigd, mu_bigd] = javaPaillierKeygen(p_bigd, q_bigd);
r_bigd = java.math.BigDecimal('3');

c_bigd = javaPaillierEncrypt(reconData_bigd, n_bigd, g_bigd, r_bigd);

c_bigd.remainder(modulus_bigd(1))
c_bigd.remainder(modulus_bigd(2))
c_bigd.remainder(modulus_bigd(3))
c_bigd.remainder(modulus_bigd(4))

disp('=====================');

recM_bigd = javaPaillierDecrypt(c_bigd, n_bigd, lambda_bigd, mu_bigd);

