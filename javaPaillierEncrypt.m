function c_bigd = javaPaillierEncrypt(m_bigd, n_bigd, g_bigd, r_bigd)


nSquare_bigd = n_bigd.pow(2);

tic
g_temp_bigd = javaFastPowerMod(g_bigd, m_bigd, nSquare_bigd);
toc
tic
r_temp_bigd = javaFastPowerMod(r_bigd, n_bigd, nSquare_bigd);
toc
tic
c_temp_bigd = g_temp_bigd.multiply(r_temp_bigd);
c_bigd = c_temp_bigd.remainder(nSquare_bigd);
toc

end