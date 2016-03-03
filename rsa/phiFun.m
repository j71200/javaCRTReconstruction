function phiValue_uint = phiFun(n_uint)
if n_uint < 2
	phiValue_uint = uint64(1);
	return;
end

phiValue_uint = uint64(1);

factors_uint = factor(n_uint);
if length(factors_uint) == 1
	phiValue_uint = n_uint - 1;
	return;
end

primeFactors_uint = unique(factors_uint)';
primeFactorNum = length(primeFactors_uint);
primeExpo_uint = zeros(primeFactorNum, 1, 'uint64');

for idx = 1:primeFactorNum
	primeExpo_uint(idx) = nnz(factors_uint == primeFactors_uint(idx));
end

for idx = 1:primeFactorNum
	p_uint = primeFactors_uint(idx);
	e_uint = primeExpo_uint(idx);
	if e_uint > 1
		phiValue_uint = phiValue_uint * (p_uint - 1) * p_uint^(e_uint-1);
	else
		phiValue_uint = phiValue_uint * (p_uint - 1);
	end
	
end



end
