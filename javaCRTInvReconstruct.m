function invReconData_uint = javaCRTInvReconstruct(reconData_bigd, modulus_bigd, height, width)

divisor = length(modulus_bigd);

grayImage_uint = zeros(height, width, 'uint64');

totalPixelNum = height * width;
groupNum = ceil(totalPixelNum / divisor);
invReconData_uint = zeros(height, width, 'uint64');


temp = zeros(groupNum, divisor, 'uint64');
parfor groupIdx = 1:(groupNum-1)  % Feasible
% for groupIdx = 1:(groupNum-1)
	groupStartIdx = (groupIdx-1) * divisor + 1;

	% parfor idx = 1:divisor  % Infeasible. Parfor loops cannot be nested.
	for idx = 1:divisor
		remainder_i_bigd = reconData_bigd(groupIdx).remainder(modulus_bigd(idx));
		remainder_i_uint = uint64(str2num(remainder_i_bigd.toString));
		temp(groupIdx, idx) = remainder_i_uint;
		% invReconData_uint(groupStartIdx+idx-1) = remainder_i_uint;
	end
end
invReconData_uint = reshape(temp', height, width);

remainPixelNum = height*width-(groupNum-1)*divisor;
groupStartIdx = (groupNum-1) * divisor + 1;

% parfor idx = 1:remainPixelNum  % Infeasible
for idx = 1:remainPixelNum
	remainder_i_bigd = reconData_bigd(groupNum).remainder(modulus_bigd(idx));
	remainder_i_uint = uint64(str2num(remainder_i_bigd.toString));
	invReconData_uint(groupStartIdx+idx-1) = remainder_i_uint;
end


end
