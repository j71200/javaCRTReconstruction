close all
clear
clc

% load('mat/primeList_502_bigd.mat');
modulus_bigd = java.math.BigDecimal('2003');
modulus_bigd = [modulus_bigd java.math.BigDecimal('2011')];
modulus_bigd = [modulus_bigd java.math.BigDecimal('2017')];

% divisor = 3;
% modulus_bigd = primeList_502_bigd(1:divisor);

xs_bigd = java.math.BigDecimal('98');
xs_bigd = [xs_bigd java.math.BigDecimal('99')];
xs_bigd = [xs_bigd java.math.BigDecimal('105')];

ys_bigd = java.math.BigDecimal('7');
ys_bigd = [ys_bigd java.math.BigDecimal('4')];
ys_bigd = [ys_bigd java.math.BigDecimal('3')];


[x_bigd, M_bigd] = javaCRT(xs_bigd, modulus_bigd, true);
[y_bigd, M_bigd] = javaCRT(ys_bigd, modulus_bigd, true);

x_bigd
disp(x_bigd.remainder(modulus_bigd(1)))
disp(x_bigd.remainder(modulus_bigd(2)))
disp(x_bigd.remainder(modulus_bigd(3)))

y_bigd
disp(y_bigd.remainder(modulus_bigd(1)))
disp(y_bigd.remainder(modulus_bigd(2)))
disp(y_bigd.remainder(modulus_bigd(3)))


z_bigd = x_bigd.add(y_bigd);
z_bigd = z_bigd.remainder(M_bigd);
z_bigd
disp(z_bigd.remainder(modulus_bigd(1)))
disp(z_bigd.remainder(modulus_bigd(2)))
disp(z_bigd.remainder(modulus_bigd(3)))

w_bigd = x_bigd.multiply(y_bigd);
w_bigd = w_bigd.remainder(M_bigd);
w_bigd
disp(w_bigd.remainder(modulus_bigd(1)))
disp(w_bigd.remainder(modulus_bigd(2)))
disp(w_bigd.remainder(modulus_bigd(3)))







