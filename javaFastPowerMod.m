function res_bigd = javaFastPowerMod(base_bigd, power_bigd, modulus_bigd, primeFactors_bigd, factorPowers)

if ~isa(base_bigd, 'java.math.BigDecimal')
	warning('The type of "base_bigd" is transformed from "%s" to "java.math.BigDecimal"', class(base_bigd));
	base_bigd = java.math.BigDecimal(num2str(base_bigd));
end
if ~isa(power_bigd, 'java.math.BigDecimal')
	warning('The type of "power_bigd" is transformed from "%s" to "java.math.BigDecimal"', class(power_bigd));
	power_bigd = java.math.BigDecimal(num2str(power_bigd));
end
if ~isa(modulus_bigd, 'java.math.BigDecimal')
	warning('The type of "modulus_bigd" is transformed from "%s" to "java.math.BigDecimal"', class(modulus_bigd));
	modulus_bigd = java.math.BigDecimal(num2str(modulus_bigd));
end

% This skill may be useless because the phiValue_bigd may
% bigger than the power_bigd.
if exist('primeFactors_bigd', 'var') && exist('factorPowers', 'var')
	phiValue_bigd = javaPhiFunction(primeFactors_bigd, factorPowers);
	power_bigd = power_bigd.remainder(phiValue_bigd);
end

ONE_BIGD  = java.math.BigDecimal('1');

binStrPower = bigd2bin(power_bigd);
basePower_bigd = base_bigd;
accuMulti_bigd = ONE_BIGD;

for powOf2 = length(binStrPower):-1:1
	if binStrPower(powOf2) == '1'
		accuMulti_bigd = accuMulti_bigd.multiply(basePower_bigd);
		accuMulti_bigd = accuMulti_bigd.remainder(modulus_bigd);
	end
	basePower_bigd = basePower_bigd.pow(2);
	basePower_bigd = basePower_bigd.remainder(modulus_bigd);
end

res_bigd = accuMulti_bigd.remainder(modulus_bigd);

end

