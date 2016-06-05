function binStr = bigd2bin(decimal_bigd)

if ~isa(decimal_bigd, 'java.math.BigDecimal')
	warning('The type of "decimal_bigd" is transformed from "%s" to "java.math.BigDecimal"', class(decimal_bigd));
	decimal_bigd = java.math.BigDecimal(num2str(decimal_bigd));
end

ZERO_BIGD = java.math.BigDecimal('0');
TWO_BIGD  = java.math.BigDecimal('2');

dividend_bigd = decimal_bigd;
quotAndRemain_bigd = dividend_bigd.divideAndRemainder(TWO_BIGD);
quotient_bigd  = quotAndRemain_bigd(1);
remainder_bigd = quotAndRemain_bigd(2);

binStr = char(remainder_bigd.toString);

while ~quotient_bigd.equals(ZERO_BIGD)
	dividend_bigd = quotient_bigd;

	quotAndRemain_bigd = dividend_bigd.divideAndRemainder(TWO_BIGD);
	quotient_bigd  = quotAndRemain_bigd(1);
	remainder_bigd = quotAndRemain_bigd(2);
	binStr = [char(remainder_bigd.toString), binStr];
end
