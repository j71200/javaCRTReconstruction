close all
clear
clc

% m1 = java.math.BigDecimal('257');
% m2 = java.math.BigDecimal('263');
% m3 = java.math.BigDecimal('269');
% m4 = java.math.BigDecimal('271');
% modulus_bigd = [m1, m2, m3, m4];

load('mat/primeList_bigd.mat');

dim = 512
height = dim;
width  = dim;
inputImage_uint = uint64(randi([0,255], height, width));

maxDivisor = 128;
elapsedTime = zeros(maxDivisor/4, 2);
% for divisor = 4:4:maxDivisor
for divisor = 112:4:maxDivisor
	divisor

	modulus_bigd = primeList_bigd(1:divisor);


	tic
	reconData_bigd = javaCRTReconstruct(inputImage_uint, modulus_bigd);
	elapsedTime(divisor/4, 1) = toc;

	tic
	invReconData_uint = javaCRTInvReconstruct(reconData_bigd, modulus_bigd, height, width);
	elapsedTime(divisor/4, 2) = toc;

	aa = double(inputImage_uint);
	bb = double(invReconData_uint);

	if nnz(aa-bb) ~= 0
		disp(['Wrong! ' num2str(divisor)]);
	end
	% figure
	% spy(aa-bb)

end

elapsedTime
