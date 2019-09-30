%% Timbre Test for Liveness
% TASCAM_0100: live audio
% TASCAM_0101: replay audio
% TASCAM_0102: replay audio (back direction)
% TASCAM_0103: replay audio (in the pocket)
% TASCAM_0105: filtered audio
% TASCAM_0106: unfiltered audio

clear;
close all;

addpath('./samples/');
[ y0, fs ] = audioread('TASCAM_0100.wav');
[ s0, f, amp0, ph0 ] = FT( y0, fs );
[ y1, ~ ] = audioread('TASCAM_0101.wav');
[ s1, ~, amp1, ph1 ] = FT( y1, fs );
[ y2, fs ] = audioread('TASCAM_0105.wav');
[ s2, ~, amp2, ph2 ] = FT( y2, fs );
[ y3, ~ ] = audioread('TASCAM_0106.wav');
[ s3, ~, amp3, ph3 ] = FT( y3, fs );

%-----------------------------------------
i = 2;
rg = 1 : 10922;
rgl = 1 : 5461;
rgh = 5462 : 10922;
% subplot(2, 1, 1);
% ylim([0, 3*10^-4]);
% plot(f(rg), amp0(rg, i)); 
% subplot(2, 1, 2);
% plot(f(rg), amp1(rg, i));
figure(1);
subplot(2, 2, 1);
%ylim([0, 1*10^-3])
plot(f(rg), amp0(rg, i)); %ylim([0, 1*10^-3])
tic;
P0 = sum(amp0(rgh, i).^2) / sum(amp0(rgl, i).^2)
toc
subplot(2, 2, 2);
plot(f(rg), amp1(rg, i));
P1 = sum(amp1(rgh, i).^2) / sum(amp1(rgl, i).^2)
subplot(2, 2, 3);
plot(f(rg), amp2(rg, i)); 
P2 = sum(amp2(rgh, i).^2) / sum(amp2(rgl, i).^2)
subplot(2, 2, 4);
plot(f(rg), amp3(rg, i));
P3 = sum(amp3(rgh, i).^2) / sum(amp3(rgl, i).^2)
hold on;

figure(4);
A0 = cumsum(amp0(rg, i).^2);
A0 = A0 / A0(end);
AA0 = sum(A0) / rg(end);
%subplot(2, 1, 1);
plot(f(rg), A0);
hold on;
A1 = cumsum(amp1(rg, i).^2);
A1 = A1 / A1(end);
AA1 = sum(A1) / rg(end);
%subplot(2, 1, 2);
plot(f(rg), A1);
hold on;
legend('genuine audio','replay audio')
xlabel('Frequency (Hz)')
ylabel('Cumulative Density Function A(n)')

figure(2);
subplot(2, 2, 1);
plot(f(rg), ph0(rg, i)); 
subplot(2, 2, 2);
plot(f(rg), ph1(rg, i));
subplot(2, 2, 3);
plot(f(rg), ph2(rg, i)); 
subplot(2, 2, 4);
plot(f(rg), ph3(rg, i));
hold on;

figure(3);
nInd = 30;
subplot(2, 2, 1);
hist(ph0(rg,i), nInd);
subplot(2, 2, 2);
hist(ph1(rg,i), nInd);
subplot(2, 2, 3);
hist(ph2(rg,i), nInd);
subplot(2, 2, 4);
hist(ph3(rg,i), nInd);


