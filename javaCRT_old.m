function [x_bigd, M_bigd] = javaCRT(remainders_bigd, modulus_bigd, auxiMultiplier_bigd)

if length(remainders_bigd) ~= length(modulus_bigd)
	error('"remainders_bigd" and "modulus_bigd" must be the same length.');
end

ZERO_BIGD = java.math.BigDecimal('0');
ONE_BIGD  = java.math.BigDecimal('1');
TWO_BIGD  = java.math.BigDecimal('2');

numOfEquations = length(remainders_bigd);

% ===============
% Checking
% ===============
if ~isa(remainders_bigd, 'java.math.BigDecimal[]')
	warning('The type of "remainders_bigd" is transformed from "%s" to "java.math.BigDecimal[]"', class(remainders_bigd));
	tmpVector = remainders_bigd;
	remainders_bigd = [];
	for idx = 1:numOfEquations
		remainders_bigd = [remainders_bigd java.math.BigDecimal(num2str(tmpVector(idx)))];
	end
end
if ~isa(modulus_bigd, 'java.math.BigDecimal[]')
	warning('The type of "modulus_bigd" is transformed from "%s" to "java.math.BigDecimal[]"', class(modulus_bigd));
	tmpVector = modulus_bigd;
	modulus_bigd = [];
	for idx = 1:numOfEquations
		modulus_bigd = [modulus_bigd java.math.BigDecimal(num2str(tmpVector(idx)))];
	end
end


% ===============
% Product the mi
% ===============
M_bigd = ONE_BIGD;
% parfor idx = 1:numOfEquations  % Infeasible
for idx = 1:numOfEquations
	modulus_i_bigd = modulus_bigd(idx);
	M_bigd = M_bigd.multiply(modulus_i_bigd);
end

% ===============
% CRT
% ===============
x_bigd = ZERO_BIGD;
if ~exist('auxiMultiplier_bigd', 'var')
	% parfor idx = 1:numOfEquations  % Infeasible
	for idx = 1:numOfEquations
		modulus_i_bigd = modulus_bigd(idx);
		mDividMi_bigd = M_bigd.divide(modulus_i_bigd);

		% modulus_i_minus2_bigd = modulus_i_bigd.subtract(TWO_BIGD);

		[invMDividMi_bigd, ~] = javaModularInverse(mDividMi_bigd, modulus_i_bigd);
		% invMDividMi_bigd = javaFastPowerMod(mDividMi_bigd, modulus_i_minus2_bigd, modulus_i_bigd);

		toBeAdd_bigd = remainders_bigd(idx);
		toBeAdd_bigd = toBeAdd_bigd.multiply(mDividMi_bigd);
		toBeAdd_bigd = toBeAdd_bigd.multiply(invMDividMi_bigd);
		x_bigd = x_bigd.add(toBeAdd_bigd);
		x_bigd = x_bigd.remainder(M_bigd);
	end
else
	% parfor idx = 1:numOfEquations  % Infeasible
	if ~isa(auxiMultiplier_bigd, 'java.math.BigDecimal')
		warning('The type of "auxiMultiplier_bigd" is transformed from "%s" to "java.math.BigDecimal"', class(auxiMultiplier_bigd));
		auxiMultiplier_bigd(idx) = java.math.BigDecimal(num2str(auxiMultiplier_bigd(idx)));
	end

	for idx = 1:numOfEquations
		toBeAdd_bigd = remainders_bigd(idx);
		auxiMultiplier_i_bigd = auxiMultiplier_bigd(idx);
		toBeAdd_bigd = toBeAdd_bigd.multiply(auxiMultiplier_i_bigd);
		x_bigd = x_bigd.add(toBeAdd_bigd);
		x_bigd = x_bigd.remainder(M_bigd);

	end
end


end