function [inverse_bigd, counter_uint] = javaModularInverse(target_bigd, modulus_bigd);

% This method is based on the extended Euclidean algorithm.
% So it is faster than Euler's theorem in finding the
% multiplicative inverse modulo n.

ZERO_BIGD = java.math.BigDecimal('0');
ONE_BIGD  = java.math.BigDecimal('1');

if ~isa(target_bigd, 'java.math.BigDecimal')
	warning('The type of "target_bigd" is transformed from "%s" to "java.math.BigDecimal"', class(target_bigd));
	target_bigd = java.math.BigDecimal(num2str(target_bigd));
end
if ~isa(modulus_bigd, 'java.math.BigDecimal')
	warning('The type of "modulus_bigd" is transformed from "%s" to "java.math.BigDecimal"', class(modulus_bigd));
	modulus_bigd = java.math.BigDecimal(num2str(modulus_bigd));
end

if target_bigd.compareTo(ZERO_BIGD) <= 0
	error('"target_bigd" is less or equal to zero.');
end
if modulus_bigd.compareTo(ZERO_BIGD) <= 0
	error('"modulus_bigd" is less or equal to zero.');
end
if target_bigd.equals(ONE_BIGD)
	inverse_bigd = ONE_BIGD;
	counter_uint = uint64(1);
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

while ~remainder_bigd.equals(ONE_BIGD)
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

