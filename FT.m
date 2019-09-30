function [ s, f1, amp, ph ] = FT( y, fs )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

y1 = y(1 : 0.176*10^6, 1);
y2 = y(0.364*10^6 : 0.578*10^6, 1);
y3 = y(0.737*10^6 : 0.945*10^6, 1);
y4 = y(1.094*10^6 : 1.310*10^6, 1);
y5 = y(1.465*10^6 : 1.697*10^6, 1);

[f1, amp1, ph1] = fastFT(y1(:,1), fs);
[f2, amp2, ph2] = fastFT(y2(:,1), fs);
[f3, amp3, ph3] = fastFT(y3(:,1), fs);
[f4, amp4, ph4] = fastFT(y4(:,1), fs);
[f5, amp5, ph5] = fastFT(y5(:,1), fs);

%----------------------------------------
len = max([length(y1), length(y2), length(y3), length(y4), length(y5)]);
s = zeros(len, 5);
s(1:length(y1), 1) = y1;
s(1:length(y2), 2) = y2;
s(1:length(y3), 3) = y3;
s(1:length(y4), 4) = y4;
s(1:length(y5), 5) = y5;
amp = [amp1 amp2 amp3 amp4 amp5];
ph = [ph1 ph2 ph3 ph4 ph5];

amp(1:5,:) = 0;

end

