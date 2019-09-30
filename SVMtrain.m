% function [accuracy] = SVMtrain()
tic
clear;
close all;

%% Give path and parameters
data_file = './data/Matrix.mat';
% set parameters
load(data_file);
vr = 20;
N = size(Mgenuine, 1);
rtrain = 0.8;

%% Get training and testing set
Lgenuine = ones(N, 1);
Lmodulated = 0 * ones(N, 1);
Label = [Lgenuine; Lmodulated];
Matrix = [Mgenuine; Mmodulated];

A=randperm(2*N);
Xtrain = Matrix(A(1 : rtrain*2*N), :);
Ytrain = Label(A(1 : rtrain*2*N), :);
Xtest = Matrix(A(rtrain*2*N+1 : end), :);
Ytest = Label(A(rtrain*2*N+1 : end), :);

%% Train SVM
SVMSTRUCT = svmtrain(Ytrain, Xtrain);
[predict_label, accuracy, ~] = svmpredict(Ytest, Xtest, SVMSTRUCT);
toc