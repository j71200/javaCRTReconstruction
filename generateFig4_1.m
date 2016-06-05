close all
clear('all');
clc


load('mat/primeList_502_bigd.mat');

logPrimes = log10(primeList_502);
numOfPrimes = length(logPrimes);

accLogPrimes = zeros(numOfPrimes, 1);
for idx = 1:numOfPrimes
	accLogPrimes(idx) = sum(logPrimes(1:idx));
end

b_vec = 640:128:2560;
maxDivisor = zeros(length(b_vec), 1);

for idx = 1:length(b_vec)
	b = b_vec(idx);
	currLog = b * log10(2);
	maxDivisor(idx) = nnz(accLogPrimes < currLog);
end

maxDivisor

figure;

plot(b_vec, maxDivisor, '*-');
xlabel('Bits of  RSA  modulo n','FontSize',12,'FontWeight','bold');
ylabel('The reconstruction factor','FontSize',12,'FontWeight','bold');
ax = gca;
set(ax,'XTick', b_vec);
set(ax,'YTick', maxDivisor);
set(ax,'fontsize', 12);

hold on;
plot([min(b_vec), 2048, 2048], [208, 208, min(maxDivisor)], '--r');
plot([min(b_vec), 768, 768], [84, 84, min(maxDivisor)], '--r');





