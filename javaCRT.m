function [x_bigd, M_bigd] = javaCRT(remainders_bigd, modulus_bigd, isModulusValid, auxiMultiplier_bigd)


% ===============
% Checking
% ===============
if ~exist('isModulusValid', 'var')
	isModulusValid = true;
end

if ~isModulusValid
	numOfRem = length(remainders_bigd);
	numOfMod = length(modulus_bigd);

	if numOfRem ~= numOfMod
		disp('ERROR: numOfRem ~= numOfMod');
		return;
	elseif numOfRem == 1
		disp('ERROR: only one equation');
		return;
	end

	% parfor idx = 1:numOfRem  % Infeasible
	for idx = 1:numOfRem
		if ~isprime(str2num(modulus_bigd(idx).toString))
			disp('ERROR: ~isprime(modulus_bigd(idx))');
			return;
		end
	end
end


ZERO_BIGD = java.math.BigDecimal('0');
ONE_BIGD  = java.math.BigDecimal('1');
TWO_BIGD  = java.math.BigDecimal('2');

divisor = length(remainders_bigd);

% ===============
% Product the mi
% ===============
M_bigd = ONE_BIGD;
% parfor idx = 1:divisor  % Infeasible
for idx = 1:divisor
	modulus_i_bigd = modulus_bigd(idx);
	M_bigd = M_bigd.multiply(modulus_i_bigd);
end

% ===============
% CRT
% ===============
x_bigd = ZERO_BIGD;
if ~exist('auxiMultiplier_bigd', 'var')
	% parfor idx = 1:divisor  % Infeasible
	for idx = 1:divisor
		modulus_i_bigd = modulus_bigd(idx);
		mDividMi_bigd = M_bigd.divide(modulus_i_bigd);

		modulus_i_minus2_bigd = modulus_i_bigd.subtract(TWO_BIGD);
		invMDividMi_bigd = javaFastPowerMod(mDividMi_bigd, modulus_i_minus2_bigd, modulus_i_bigd);

		toBeAdd_bigd = remainders_bigd(idx);
		toBeAdd_bigd = toBeAdd_bigd.multiply(mDividMi_bigd);
		toBeAdd_bigd = toBeAdd_bigd.multiply(invMDividMi_bigd);
		x_bigd = x_bigd.add(toBeAdd_bigd);
		x_bigd = x_bigd.remainder(M_bigd);
	end
else
	% parfor idx = 1:divisor  % Infeasible
	for idx = 1:divisor
		toBeAdd_bigd = remainders_bigd(idx);
		auxiMultiplier_i_bigd = auxiMultiplier_bigd(idx);
		toBeAdd_bigd = toBeAdd_bigd.multiply(auxiMultiplier_i_bigd);
		x_bigd = x_bigd.add(toBeAdd_bigd);
		x_bigd = x_bigd.remainder(M_bigd);

	end
end


end