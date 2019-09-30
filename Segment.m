clear;
close all;

%% Path
addpath('./samples/');
audio_file = 'genuine_all.wav';
% audio_file = 'TASCAM_0100.wav';
save_path = './samples/genuine/';

%% set parameters
th = 1 * 10^-3;           % threshold to segment the power.
% genuine : 1*10^-3
mode = 1;                   % 1 : segment number; 0 : threshold;
if (mode) 
    segN = 100;
else
    intv_th = 3000;
end

%% read audio file.
[ y, fs ] = audioread(audio_file);
y = [ zeros(10,2) ; y ; zeros(10,2)];

% show the waveform.
len = max(size(y));
plot(1:len, y(:, 1));

%% check power
pw = y(:, 1) .^ 2;
mark = (pw > th);           % the power is greater than th 0/1
plot(1:len, pw);

mark_dev = [ 0; mark(2:end) - mark(1:(end-1))];
findP = find(mark_dev == 1);                % get all the rising
findN = find(mark_dev == -1);               % get all the dropping
intv = findP(2:end) - findN(1:(end-1));     % get all the gaps
intv_s = sort(intv, 'descend');             % sort for the gaps

% calculate the threshold for selecting gaps.
if (mode)
    intv_th = intv_s(segN) + 1;
else
    % intv_th = intv_th;
    % adaptive selection : ratio = intv_s(i) / intv_s(i+1)
end

% remove the small gaps.
for i = 1 : length(intv)
    i_d = findN(i);
    i_r = findP(i+1);
    iv = i_r - i_d;
    if (iv < intv_th)
        mark_dev(i_r) = 0;
        mark_dev(i_d) = 0;
    end
end
findP = find(mark_dev == 1);                % get all the rising
findN = find(mark_dev == -1);               % get all the dropping

% reconstruct the large gaps.
mark_r = zeros(size(mark));
s = 0;
for i = 1 : len
    s = s + mark_dev(i);
    mark_r(i) = s;
end

plot(1:len, pw, 1:len, 0.05 * mark_r); ylim([0, 0.05]);
% important value: findP findN intv_s len
save([save_path, 'para.mat'], 'findP', 'findN', 'intv_s', 'len');

%% segmentation
seg_num = length(findP);
for i = 1 : seg_num
    i_r = findP(i);
    i_d = findN(i);
    y_save = y(i_r : (i_d-1), :);
    % plot(y_save);
    
    f_name = [num2str(i, '%04d'), '.wav'];
    audiowrite([save_path, f_name], y_save, fs);
end

