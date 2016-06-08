function cCiphertext = expParaPaillierEncryption(vPlaintext, n_bigd, g_bigd)

numPlaintexts = length(vPlaintext);
cCiphertext = cell(numPlaintexts, 1);

if isa(vPlaintext, 'double') || isa(vPlaintext, 'uint8')
	minPlaintext = min(vPlaintext)
	maxPlaintext = max(vPlaintext)
	vPlainValues = minPlaintext:maxPlaintext;
	cCipherValues_bigd = cell(length(vPlainValues), 1);

	parfor idx = 1:length(vPlainValues)
		c_bigd = javaPaillierEncrypt(dbl2bigd(vPlainValues(idx)), n_bigd, g_bigd, dbl2bigd(1));
		cCipherValues_bigd{idx} = c_bigd;
	end

	nSquare_bigd = n_bigd.pow(2);
	parfor idx = 1:numPlaintexts
		r_bigd = round(rand(1) * 10^10);
		r_bigd = java.math.BigDecimal(num2str(r_bigd));
		
		c_bigd = cCipherValues_bigd{vPlaintext(idx) - minPlaintext + 1};
		c_bigd = c_bigd.multiply(r_bigd);
		c_bigd = c_bigd.remainder(nSquare_bigd);
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
