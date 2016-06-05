% findReconFactor
close all
clear
clc

primeNums = primes(10000);

m_max = 2:5:1002;
rsaModulus = 640:128:2560;

reconFactors = zeros(length(m_max), length(rsaModulus));

for mMaxIdx = 1:length(m_max)
	% Find the suit primes
	tmp = find(primeNums > m_max(mMaxIdx));
	suitPrimeNums = primeNums(tmp(1):end);
	logSuitPrimeNums = log2(suitPrimeNums);
	% Sum the log primes
	sumLogSuitPrimesNums = logSuitPrimeNums;
	for idx = 2:length(logSuitPrimeNums)
		sumLogSuitPrimesNums(idx) = sumLogSuitPrimesNums(idx-1) + logSuitPrimeNums(idx);
	end

	for rsaModulusIdx = 1:length(rsaModulus)
		% Find the reconstruction factor
		tmp = find(sumLogSuitPrimesNums >= rsaModulus(rsaModulusIdx));
		reconFactors(mMaxIdx, rsaModulusIdx) = tmp(1) - 1;
	end
end


% ==========
% Calculus
% ==========

A1 = m_max;
for idx = 2:length(rsaModulus)
	A1 = [A1 m_max];
end
A1 = A1';

A2 = zeros(1, length(m_max)) + rsaModulus(1);
for idx = 2:length(rsaModulus)
	A2 = [A2 zeros(1, length(m_max)) + rsaModulus(idx)];
end
A2 = A2';

A3 = zeros(1, length(m_max)*length(rsaModulus)) + 1;
A3 = A3';


A = [A1 A2 A3];
b = reshape(reconFactors, length(m_max)*length(rsaModulus), 1);

A\b




load franke
x = A(:, 1:2);
y = b;
sf = fit(x, y,'poly11')
figure;
plot(sf, x, y);
xlabel('m_{max}', 'FontSize', 12);
ylabel('rsaModulus', 'FontSize', 12);
zlabel('reconFactors', 'FontSize', 12);



sf = fit(x, y,'poly22')
figure;
plot(sf, x, y);
xlabel('m_{max}', 'FontSize', 12);
ylabel('rsaModulus', 'FontSize', 12);
zlabel('reconFactors', 'FontSize', 12);


% ax = gca;
% set(ax,'XTick', m_max);
% set(ax,'YTick', rsaModulus);
% set(ax,'ZTick', reconFactors);
% set(ax,'fontsize', 12);




% corrcoef()
% figure;
% plot(m_max, reconFactors(:,12), '.-');



% % ==========
% % Ploting - m_max vs. reconFactors
% % ==========
% figure;
% plot(m_max, reconFactors(:,1), 'o-', ...
%      m_max, reconFactors(:,2), '+-', ...
%      m_max, reconFactors(:,3), '*-', ...
%      m_max, reconFactors(:,4), '.-', ...
%      m_max, reconFactors(:,5), 'x-', ...
%      m_max, reconFactors(:,6), 's-', ...
%      m_max, reconFactors(:,7), 'd-', ...
%      m_max, reconFactors(:,8), '^-', ...
%      m_max, reconFactors(:,9), 'v-', ...
%      m_max, reconFactors(:,10), '>-', ...
%      m_max, reconFactors(:,11), '<-', ...
%      m_max, reconFactors(:,12), 'p-', ...
%      m_max, reconFactors(:,13), 'h-', ...
%      m_max, reconFactors(:,14), 'o-', ...
%      m_max, reconFactors(:,15), '+-', ...
%      m_max, reconFactors(:,16), '*-');


% % ==========
% % Ploting - rsaModulus vs. reconFactors
% % ==========
% figure;
% plot(rsaModulus, reconFactors(1,:), 'o-', ...
%      rsaModulus, reconFactors(2,:), '+-', ...
%      rsaModulus, reconFactors(3,:), '*-', ...
%      rsaModulus, reconFactors(4,:), '.-', ...
%      rsaModulus, reconFactors(5,:), 'x-', ...
%      rsaModulus, reconFactors(6,:), 's-', ...
%      rsaModulus, reconFactors(7,:), 'd-', ...
%      rsaModulus, reconFactors(8,:), '^-', ...
%      rsaModulus, reconFactors(9,:), 'v-', ...
%      rsaModulus, reconFactors(10,:), '>-', ...
%      rsaModulus, reconFactors(11,:), '<-');
% legend('m_{max} = 2', 'm_{max} = 52', 'm_{max} = 102', 'm_{max} = 152', 'm_{max} = 202', 'm_{max} = 252', 'm_{max} = 302', 'm_{max} = 352', 'm_{max} = 402', 'm_{max} = 452', 'm_{max} = 502');
% ax = gca;
% set(ax,'XTick', rsaModulus);
% set(ax,'YTick', reconFactors(7,:));
% set(ax,'fontsize', 12);







