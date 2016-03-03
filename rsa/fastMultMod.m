function mult_uint = fastMultMod(a1_uint, a2_uint, modulus_uint)

a1_bigd = java.math.BigDecimal(num2str(a1_uint));
a2_bigd = java.math.BigDecimal(num2str(a2_uint));
modulus_bigd = java.math.BigDecimal(num2str(modulus_uint));

mult_bigd = a1_bigd.multiply(a2_bigd);
mult_temp_bigd = mult_bigd.remainder(modulus_bigd);

mult_str = java.lang.String('uint64(');
mult_str = mult_str.concat(mult_temp_bigd.toString);
mult_str = mult_str.concat(java.lang.String(')'));

mult_uint = str2num(mult_str);


% UINT64_MAX = uint64(18446744073709551615);

% mult_uint = a1_uint * a2_uint;
% if mult_uint >= UINT64_MAX
% 	% disp('Overflow!!');

% 	divisor = 16;
% 	a2Quotient_uint = (a2_uint - mod(a2_uint, divisor)) / divisor;
% 	partSum2_uint = fastMultMod(a1_uint, a2Quotient_uint, modulus_uint) + fastMultMod(a1_uint, a2Quotient_uint, modulus_uint);
	
% 	if partSum2_uint >= UINT64_MAX
% 		disp('Overflow!! - partSum2_uint');
% 	else
% 		partSum2_uint = mod(partSum2_uint, modulus_uint);
% 	end

% 	partSum4_uint = partSum2_uint + partSum2_uint;
% 	if partSum4_uint >= UINT64_MAX
% 		disp('Overflow!! - partSum4_uint');
% 	else
% 		partSum4_uint = mod(partSum4_uint, modulus_uint);
% 	end
	
% 	partSum8_uint = partSum4_uint + partSum4_uint;
% 	if partSum8_uint >= UINT64_MAX
% 		disp('Overflow!! - partSum8_uint');
% 	else
% 		partSum8_uint = mod(partSum8_uint, modulus_uint);
% 	end

% 	partSum16_uint = partSum8_uint + partSum8_uint;
% 	if partSum16_uint >= UINT64_MAX
% 		disp('Overflow!! - partSum16_uint');
% 	else
% 		partSum16_uint = mod(partSum16_uint, modulus_uint);
% 	end

% 	if a1_uint * mod(a2_uint, divisor) >= UINT64_MAX
% 		disp('Overflow!! - remainder');
% 	else
% 		remainder = mod(a1_uint * mod(a2_uint, divisor), modulus_uint);
% 	end

% 	mult_uint = mod(partSum16_uint + remainder, modulus_uint);
% else
% 	mult_uint = mod(mult_uint, modulus_uint);
% end

end