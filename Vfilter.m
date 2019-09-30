%% Synthetic voice signal file  
% To filter the voice record and to get the filtered record.
%
% Shaun Wang 2019-04-17

clear;
close all;

addpath('./samples/');
[ y0, fs ] = audioread('TASCAM_0100.wav');

y1 = y0(1 : 0.176*10^6, 1);
y2 = y0(0.364*10^6 : 0.578*10^6, 1);
y3 = y0(0.737*10^6 : 0.945*10^6, 1);
y4 = y0(1.094*10^6 : 1.310*10^6, 1);
y5 = y0(1.465*10^6 : 1.697*10^6, 1);

yr1 = LPfilter(y1, fs);
yr2 = LPfilter(y2, fs);
yr3 = LPfilter(y3, fs);
yr4 = LPfilter(y4, fs);
yr5 = LPfilter(y5, fs);

yr = zeros(size(y0));
yr(1 : 0.176*10^6, 1) = yr1;
yr(0.364*10^6 : 0.578*10^6, 1) = yr2;
yr(0.737*10^6 : 0.945*10^6, 1) = yr3;
yr(1.094*10^6 : 1.310*10^6, 1) = yr4;
yr(1.465*10^6 : 1.697*10^6, 1) = yr5;
yr(:, 2) = [];
yr = [zeros(200000, 1); yr];
y0 = [zeros(200000, 1); y0(:,1)];

audiowrite('./outputs/filtered.wav', yr, fs);
audiowrite('./outputs/unfiltered.wav', y0, fs);