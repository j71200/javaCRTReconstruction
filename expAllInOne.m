close all
clear
clc

% 16
% 32
% 64
% 128
% 256
% 512

scaleRatio = 128/512;
repeatTimes = 10;

elapsedKeyGen = zeros(repeatTimes, 1);
elapsedReconstruct = zeros(repeatTimes, 1);
elapsedEncryption = zeros(repeatTimes, 1);
elapsedDecryption = zeros(repeatTimes, 1);
elapsedInvRecon = zeros(repeatTimes, 1);

disp(['scaleRatio: ' num2str(scaleRatio)]);
for idx = 1:repeatTimes
	disp(['repeat: ' num2str(idx)]);
	a = clock;
	disp(['Start at ' num2str(a(2)) '/' num2str(a(3)) ' ' num2str(a(4)) ':' num2str(a(5))]);
	[elapsedKeyGen(idx), elapsedReconstruct(idx), elapsedEncryption(idx), elapsedDecryption(idx), elapsedInvRecon(idx)] = expParaEncryption(scaleRatio);
	% [elapsedKeyGen(idx), elapsedEncryption(idx), elapsedDecryption(idx)] = expParaEncryptionNoRecon(scaleRatio);
end

% averageKeyGen = mean(elapsedKeyGen);
% averageReconstruct = mean(elapsedReconstruct);
% averageEncryption = mean(elapsedEncryption);
% averageDecryption = mean(elapsedDecryption);
% averageInvRecon = mean(elapsedInvRecon);

elapsedKeyGen
elapsedReconstruct
elapsedEncryption
elapsedDecryption
elapsedInvRecon




