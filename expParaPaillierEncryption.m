function cCiphertext = expParaPaillierEncryption(vPlaintext, n_bigd, g_bigd)

numPlaintexts = length(vPlaintext);
cCiphertext = cell(numPlaintexts, 1);


if isa(vPlaintext, 'double')
	parfor idx = 1:numPlaintexts
		r_bigd = round(rand(1) * 10^10);
		r_bigd = java.math.BigDecimal(num2str(r_bigd));

		m_bigd = dbl2bigd(vPlaintext(idx));
		c_bigd = javaPaillierEncrypt(m_bigd, n_bigd, g_bigd, r_bigd);

		cCiphertext{idx} = c_bigd;
	end

elseif isa(vPlaintext, 'cell')
	parfor idx = 1:numPlaintexts
		r_bigd = round(rand(1) * 10^10);
		r_bigd = java.math.BigDecimal(num2str(r_bigd));

		m_bigd = vPlaintext{idx};
		c_bigd = javaPaillierEncrypt(m_bigd, n_bigd, g_bigd, r_bigd);

		cCiphertext{idx} = c_bigd;
	end

end


end
