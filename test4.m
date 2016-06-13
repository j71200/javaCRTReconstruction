clear('all');
clc

tic
% summation = uint64(0);
summation = 0;
repeatTimes = 1000;
for idx = 1:repeatTimes
	for jdx = 1:repeatTimes
		for kdx = 1:repeatTimes
			summation = summation + idx;
		end
	end
end
toc

summation
a=2^32;
uint64(a)




