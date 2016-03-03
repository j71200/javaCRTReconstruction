clear('all');
clc

p_bigd = java.math.BigDecimal('33478071698956898786044169848212690817704794983713768568912431388982883793878002287614711652531743087737814467999489');
q_bigd = java.math.BigDecimal('36746043666799590428244633799627952632279158164343087642676032283815739666511279233373417143396810270092798736308917');


% p_bigd = java.math.BigDecimal('37975227936943673922808872755445627854565536638199');
% q_bigd = java.math.BigDecimal('40094690950920881030683735292761468389214899724061');


% p_bigd = java.math.BigDecimal('9999973');
% q_bigd = java.math.BigDecimal('9999991');


tic
[n_bigd, g_bigd, lambda_bigd, mu_bigd] = javaPaillierKeygen(p_bigd, q_bigd);

m_bigd = java.math.BigDecimal('7481244')
r_bigd = java.math.BigDecimal('3');
c_bigd = javaPaillierEncrypt(m_bigd, n_bigd, g_bigd, r_bigd)
recM_bigd = javaPaillierDecrypt(c_bigd, n_bigd, lambda_bigd, mu_bigd)
toc
