close all
clear
clc

load('mat/primeList_502_bigd.mat');
divisor = 84;
modulus_bigd = primeList_502_bigd(1:1+divisor-1);

disp('airplane_gray');
inputImage_uint = uint64(imread('images/airplane_gray.png'));
tic
recon_airplane_bigd = javaCRTReconstruct(inputImage_uint, modulus_bigd);
toc

disp('baboon_gray');
inputImage_uint = uint64(imread('images/baboon_gray.png'));
tic
recon_baboon_bigd = javaCRTReconstruct(inputImage_uint, modulus_bigd);
toc

disp('fruits_gray');
inputImage_uint = uint64(imread('images/fruits_gray.png'));
tic
recon_fruits_bigd = javaCRTReconstruct(inputImage_uint, modulus_bigd);
toc

disp('lena_gray');
inputImage_uint = uint64(imread('images/lena_gray.png'));
tic
recon_lena_bigd = javaCRTReconstruct(inputImage_uint, modulus_bigd);
toc

disp('peppers_gray');
inputImage_uint = uint64(imread('images/peppers_gray.png'));
tic
recon_peppers_bigd = javaCRTReconstruct(inputImage_uint, modulus_bigd);
toc



% minDivisor = 112;
% maxDivisor = 212;
% elapsedTime = zeros((maxDivisor-minDivisor)/4+1, 2);
% for divisor = minDivisor:4:maxDivisor
% 	divisor

% 	modulus_bigd = primeList_502_bigd(9:9+divisor-1);


% 	tic
% 	reconData_bigd = javaCRTReconstruct(inputImage_uint, modulus_bigd);
% 	elapsedTime(divisor/4, 1) = toc;

% 	tic
% 	invReconData_uint = javaCRTInvReconstruct(reconData_bigd, modulus_bigd, height, width);
% 	elapsedTime(divisor/4, 2) = toc;

% 	aa = double(inputImage_uint);
% 	bb = double(invReconData_uint);

% 	if nnz(aa-bb) ~= 0
% 		disp(['Wrong! ' num2str(divisor)]);
% 	end
% 	% figure
% 	% spy(aa-bb)

% end

% elapsedTime
