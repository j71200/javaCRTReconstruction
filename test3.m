clear
clc


load('mat/primeList_502_bigd.mat');

% divisor = 83; % 227 digits
divisor = 84; % 230 digits
% divisor = 85; % 233 digits


primeNums_bigd = primeList_502_bigd(1:divisor);

primeNums = zeros(size(primeNums_bigd));
product_bigd = java.math.BigDecimal('1');
for idx = 1:divisor
	product_bigd = product_bigd.multiply(primeNums_bigd(idx));
	primeNums(idx) = str2num(primeNums_bigd(idx).toString);
end

product_bigd



