function resArray_bigd = dbl2bigd(inputArray)

if ~isa(inputArray, 'java.math.BigDecimal') || ~isa(inputArray, 'java.math.BigDecimal[]')
	resArray_bigd = [];
	for idx = 1:length(inputArray)
		resArray_bigd = [resArray_bigd java.math.BigDecimal(num2str(inputArray(idx)))];
	end
else
	resArray_bigd = inputArray;
end

end