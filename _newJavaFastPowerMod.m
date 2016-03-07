clear
clc

% base_bigd = java.math.BigDecimal('4712947136781656124127497958710790561');
% power_str = '4712947136781656124127599157917451764979';
% power_bigd = java.math.BigDecimal(power_str);
% modulus_bigd = java.math.BigDecimal('471294713678165124761561241274979');

% newJavaFastPowerMod


% power_bigd = java.math.BigDecimal('24');


ZERO_BIGD = java.math.BigDecimal('0');
ONE_BIGD  = java.math.BigDecimal('1');
TWO_BIGD  = java.math.BigDecimal('2');


binNumber_str = '';
counter = -1;
exps = [];
theHalf_bigd = power_bigd;
while theHalf_bigd.compareTo(ZERO_BIGD)
	counter = counter + 1;
	binDigit = double(theHalf_bigd.remainder(TWO_BIGD));
	theHalf_bigd = theHalf_bigd.divideToIntegralValue(TWO_BIGD);

	binNumber_str = [num2str(binDigit) binNumber_str];

	if binDigit == 1
		exps = [exps counter];
	else
		continue;
	end
end








