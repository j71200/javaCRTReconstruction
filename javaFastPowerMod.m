function res_bigd = javaFastPowerMod(base_bigd, power_bigd, modulus_bigd);

ZERO_BIGD = java.math.BigDecimal('0');
ONE_BIGD  = java.math.BigDecimal('1');
TWO_BIGD  = java.math.BigDecimal('2');

% if power_bigd < 0
% 	disp('Wrong! power_bigd < 0');
% end
% if base_bigd < 0
% 	disp('Wrong! base_bigd < 0');
% elseif base_bigd == 0
% 	res_bigd = 0;
% 	return;
% elseif base_bigd == 1
% 	res_bigd = 1;
% 	return;
% end

if power_bigd == ZERO_BIGD
	res_bigd = ONE_BIGD;
elseif power_bigd == ONE_BIGD
	res_bigd = base_bigd.remainder(modulus_bigd);
elseif power_bigd.remainder(TWO_BIGD) == ZERO_BIGD
	partProd_bigd = javaFastPowerMod(base_bigd, power_bigd.divide(TWO_BIGD), modulus_bigd);
	prod_bigd = partProd_bigd.pow(2);
	res_bigd = prod_bigd.remainder(modulus_bigd);
elseif power_bigd.remainder(TWO_BIGD) == ONE_BIGD
	powerMinus1_bigd = power_bigd.subtract(ONE_BIGD);
	partProd_bigd = javaFastPowerMod(base_bigd, powerMinus1_bigd.divide(TWO_BIGD), modulus_bigd);
	prod_bigd = partProd_bigd.pow(2);
	prod_bigd = prod_bigd.remainder(modulus_bigd);
	prod_bigd = prod_bigd.multiply(base_bigd);
	res_bigd = prod_bigd.remainder(modulus_bigd);
end

end