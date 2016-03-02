clear('all');
clc

a1 = java.math.BigDecimal('98');
a2 = java.math.BigDecimal('99');
a3 = java.math.BigDecimal('105');
m1 = java.math.BigDecimal('257');
m2 = java.math.BigDecimal('263');
m3 = java.math.BigDecimal('269');


remainders_bigd = [a1, a2, a3];
modulus_bigd = [m1, m2, m3];

[x_bigd, M_bigd] = javaCRT(remainders_bigd, modulus_bigd);

x_bigd
x_bigd.remainder(m1)
x_bigd.remainder(m2)
x_bigd.remainder(m3)

