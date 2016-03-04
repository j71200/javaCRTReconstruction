function recM_bigd = javaPaillierDecrypt(c_bigd, n_bigd, lambda_bigd, mu_bigd)

nSquare_bigd = n_bigd.pow(2);

recU_bigd = javaFastPowerMod(c_bigd, lambda_bigd, nSquare_bigd);

temp_recU_bigd = recU_bigd.subtract(java.math.BigDecimal('1'));
recL_bigd = temp_recU_bigd.divideToIntegralValue(n_bigd);

recM_bigd = recL_bigd.multiply(mu_bigd);
recM_bigd = recM_bigd.remainder(n_bigd);

