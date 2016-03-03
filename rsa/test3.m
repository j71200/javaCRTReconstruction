clear
clc

% KeyGen
p = uint64(197);
q = uint64(199);


N = p*q;
r = (p-1)*(q-1);

e = uint64(randi([1, r-1], 1));
while gcd(e, r) ~= 1
	e = uint64(randi([1, r-1], 1));
end
d = fastPowerMod(e, phiFun(r)-1, r);

% Encryption
n = uint64(9)
c = fastPowerMod(n, e, N)


% Decryption
m1 = fastPowerMod(c, d, N)

disp('===================================');
% Decryption
v1 = fastPowerMod(c, mod(d, p-1), p)
v2 = fastPowerMod(c, mod(d, q-1), q)
C2 = fastPowerMod(p, phiFun(q)-1, q)

disp('v2 > v1');
v2 > v1
u = mod((v2-v1)*C2, q);

m2 = mod(v1+u*p, n)






