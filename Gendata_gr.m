clear;
close all;

%% Give path and parameters
genuine_path = './samples/genuine/';
replay_path = './samples/replay/';
initial_file = './data/initVector.mat';
save_file = './data/Vector.mat';
% set parameters
segN = 100;
%load(initial_file);
Vgenuine = [];
Vreplay = [];
rg = 1 : 10922;
rgl = 1 : 5461;
rgh = 5462 : 10922;

%% Get genuine results
for i = 1 : segN
    f_name = [num2str(i, '%04d'), '.wav'];
    [y, fs] = audioread([genuine_path, f_name]);
    
    [~, amp, ~] = fastFT(y(:,1), fs);
    P = sum(amp(rgh).^2) / sum(amp(rgl).^2);
    Vgenuine = [Vgenuine; P];
end

%% Get replay results
for i = 1 : segN
    f_name = [num2str(i, '%04d'), '.wav'];
    [y, fs] = audioread([replay_path, f_name]);
    
    [~, amp, ~] = fastFT(y(:,1), fs);
    P = sum(amp(rgh).^2) / sum(amp(rgl).^2);
    Vreplay = [Vreplay; P];
end

%% Save
save(save_file, 'Vgenuine', 'Vreplay');
