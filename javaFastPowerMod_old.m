function res_bigd = javaFastPowerMod(base_bigd, power_bigd, modulus_bigd)


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

