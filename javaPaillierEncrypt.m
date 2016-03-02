function c_bigd = javaPaillierEncrypt(m_bigd, n_bigd, g_bigd, r_bigd)


nSquare_bigd = n_bigd.pow(2);

g_temp_bigd = javaFastPowerMod(g_bigd, m_bigd, nSquare_bigd);
r_temp_bigd = javaFastPowerMod(r_bigd, n_bigd, nSquare_bigd);
c_temp_bigd = g_temp_bigd.multiply(r_temp_bigd);
c_bigd = c_temp_bigd.remainder(nSquare_bigd);


end