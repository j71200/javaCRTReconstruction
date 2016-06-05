function [inverse_bigd, counter_uint] = javaModularInverse(target_bigd, modulus_bigd);

ZERO_BIGD = java.math.BigDecimal('0');
ONE_BIGD  = java.math.BigDecimal('1');

if target_bigd.compareTo(ZERO_BIGD) <= 0
	return;
end
if modulus_bigd.compareTo(ZERO_BIGD) <= 0
	return;
end


dividend_bigd = modulus_bigd;
divisor_bigd  = target_bigd;

quotAndRemain_bigd = dividend_bigd.divideAndRemainder(divisor_bigd);
quotient_bigd  = quotAndRemain_bigd(1);
remainder_bigd = quotAndRemain_bigd(2);

prePreAccumulator_bigd = ZERO_BIGD;   % A trick
preAccumulator_bigd    = ONE_BIGD;    % A trick
curAccumulator_bigd    = prePreAccumulator_bigd.subtract(preAccumulator_bigd.multiply(quotient_bigd));

counter_uint = uint64(1);

while remainder_bigd.compareTo(ONE_BIGD)
	counter_uint = counter_uint + 1;
	dividend_bigd = divisor_bigd;
	divisor_bigd = remainder_bigd;
	quotAndRemain_bigd = dividend_bigd.divideAndRemainder(divisor_bigd);
	quotient_bigd  = quotAndRemain_bigd(1);
	remainder_bigd = quotAndRemain_bigd(2);

	prePreAccumulator_bigd = preAccumulator_bigd;
	preAccumulator_bigd    = curAccumulator_bigd;
	curAccumulator_bigd    = prePreAccumulator_bigd.subtract(preAccumulator_bigd.multiply(quotient_bigd));
end

inverse_bigd = curAccumulator_bigd;

if inverse_bigd.compareTo(ZERO_BIGD) == -1
	inverse_bigd = inverse_bigd.add(modulus_bigd);
end

