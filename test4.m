clear('all');
clc

% ZERO_BIGD = java.math.BigDecimal('0');

% ==========
% KeyGen
% ==========
tic
% RSA-576 (174 digits)
p_bigd = java.math.BigDecimal('398075086424064937397125500550386491199064362342526708406385189575946388957261768583317');
q_bigd = java.math.BigDecimal('472772146107435302536223071973048224632914695302097116459852171130520711256363590397527');
[n_bigd, g_bigd, lambda_bigd, mu_bigd] = javaPaillierKeygen(p_bigd, q_bigd);
toc

% ==========
% Encrypt
% ==========
tic
r_bigd = java.math.BigDecimal('3');
m_bigd = java.math.BigDecimal('678');
encryptedImage_bigd(idx) = javaPaillierEncrypt(m_bigd, n_bigd, g_bigd, r_bigd);
toc







