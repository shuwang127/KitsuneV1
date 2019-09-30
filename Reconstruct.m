clear;
close all;

%% Path
addpath('./samples/');
audio_file = 'genuine_all.wav';
audio_path = './samples/genuine/';
save_path = './outputs/';
segN = 100;

%% reconstruct unmodulated audio
[ y, fs ] = audioread(audio_file);
y = [ zeros(2*fs, 2) ; y ; zeros(2*fs, 2)];
%plot(y)
audiowrite([save_path, 'replay.wav'], y, fs);

%% reconstruct modulated audio
load([audio_path, 'para.mat']);
chn = 1;
yr = zeros(len, chn);
for i = 1 : segN
    f_name = [num2str(i, '%04d'), '.wav'];
    [ys, ~] = audioread([audio_path, f_name]);
    ysr = LPfilter(ys(:, 1), fs);
    
    i_r = findP(i);
    i_d = findN(i);
    yr(i_r : (i_d-1), 1) = ysr;
    
    if (chn == 2)
        ysr = LPfilter(ys(:, 2), fs);
        yr(i_r : (i_d-1), 2) = ysr;
    end
end
yr = [ zeros(2*fs, chn) ; yr ; zeros(2*fs, chn)];
%plot(yr);
audiowrite([save_path, 'modulated_2.wav'], yr, fs);