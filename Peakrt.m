function [ rvec ] = Peakrt( y, l )

y1 = y(1 : 0.176*10^6, 1);
y2 = y(0.364*10^6 : 0.578*10^6, 1);
y3 = y(0.737*10^6 : 0.945*10^6, 1);
y4 = y(1.094*10^6 : 1.310*10^6, 1);
y5 = y(1.465*10^6 : 1.697*10^6, 1);

r1 = Peakratio(y1, l);
r2 = Peakratio(y2, l);
r3 = Peakratio(y3, l);
r4 = Peakratio(y4, l);
r5 = Peakratio(y5, l);

rvec = [r1 r2 r3 r4 r5];