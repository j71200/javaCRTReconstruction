clear
clc

% 16
% 32
% 64
% 128
% 256
% 512

scaleRatio = 256/512;
repeatTimes = 10;

elapsedKeyGen = zeros(repeatTimes, 1);
elapsedReconstruct = zeros(repeatTimes, 1);
elapsedEncryption = zeros(repeatTimes, 1);
elapsedDecryption = zeros(repeatTimes, 1);
elapsedInvRecon = zeros(repeatTimes, 1);

for idx = 1:repeatTimes
	disp(['repeat: ' num2str(idx)]);
	[elapsedKeyGen(idx), elapsedReconstruct(idx), elapsedEncryption(idx), elapsedDecryption(idx), elapsedInvRecon(idx)] = expParaEncryption(scaleRatio);
end

averageKeyGen = mean(elapsedKeyGen);
averageReconstruct = mean(elapsedReconstruct);
averageEncryption = mean(elapsedEncryption);
averageDecryption = mean(elapsedDecryption);
averageInvRecon = mean(elapsedInvRecon);

elapsedKeyGen
elapsedReconstruct
elapsedEncryption
elapsedDecryption
elapsedInvRecon




