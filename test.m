clear('all');
clc

% a = java.math.BigDecimal('764865671725223');
% b = java.math.BigDecimal('65536');
% c = java.math.BigDecimal('74818974172633245717461');

% for idx = 7678781:7678784
% 	x = uint64(791004165);
% 	% y = uint64(10);
% 	y = uint64(idx);
% 	z = uint64(418219471);
% 	p = fastPowerMod(x, y, z);

% 	a = java.math.BigDecimal(num2str(x));
% 	b = java.math.BigDecimal(num2str(y));
% 	c = java.math.BigDecimal(num2str(z));
% 	q = javaFastPowerMod(a, b, c);
% 	if p == q
% 		q
% 	else
% 		disp(idx);
% 	end
% end

divisor = 10;

moduloNumList = [256, 257, 259, 263, 269, 271, 277, 281, 283, 293, 307, 311, 313, 317, 331, 337, 347, 349, 353, 359, 367, 373, 379, 383, 389, 397, 401, 409, 419, 421, 431, 433, 439, 443, 449, 457, 461, 463, 467, 479, 487, 491, 499, 503, 509, 521, 523, 541, 547, 557, 563, 569, 571, 577, 587, 593, 599, 601, 607, 613, 617, 619, 631, 641, 643, 647, 653, 659, 661, 673, 677, 683, 691, 701, 709, 719, 727, 733, 739, 743, 751, 757, 761, 769, 773, 787, 797, 809, 811, 821, 823, 827, 829, 839, 853, 857, 859, 863, 877, 881]';

moduloNums = moduloNumList(1:divisor);
a = moduloNums;





