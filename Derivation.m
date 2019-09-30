function [ rvec ] = Derivation( y )

y1 = y(1 : 0.176*10^6, 1);
y2 = y(0.364*10^6 : 0.578*10^6, 1);
y3 = y(0.737*10^6 : 0.945*10^6, 1);
y4 = y(1.094*10^6 : 1.310*10^6, 1);
y5 = y(1.465*10^6 : 1.697*10^6, 1);

r1 = Deriv(y1);
r2 = Deriv(y2);
r3 = Deriv(y3);
r4 = Deriv(y4);
r5 = Deriv(y5);

rvec = [r1 r2 r3 r4 r5];