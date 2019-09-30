clear;
close all;

%% Path
addpath('./samples/');
para_path = './samples/genuine/';
audio_file = 'replay_all.wav';
save_path = './samples/replay/';
segN = 100;

%%
load([para_path, 'para.mat']);
[ y, fs ] = audioread(audio_file);
len = length(y);

%% Set intial mark
len_mark = max(findP(end), findN(end));
mark = zeros(len_mark, 1);
for i = 1 : segN
    i_r = findP(i);
    i_d = findN(i);
    mark(i_r:(i_d-1)) = ones(i_d-i_r, 1);
end

%%
initP = 0.65*10^5;
%plot(initP:2*10^5, y(initP:2*10^5, 1));
initP0 = findP(1);
shift = initP - initP0;
plot(1:len, y(:,1), shift+(1:len_mark), mark);

%% Save
for i = 1 : segN
    i_r = findP(i) + shift;
    i_d = findN(i) + shift;
    y_save = y(i_r : (i_d-1), :);
    % plot(y_save);
    
    f_name = [num2str(i, '%04d'), '.wav'];
    audiowrite([save_path, f_name], y_save, fs);
end



