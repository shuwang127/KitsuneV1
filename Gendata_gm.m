clear;
close all;

%% Give path and parameters
genuine_path = './samples/genuine/';
modulated_path = './samples/modulated/';
initial_file = './data/initMatrix.mat';
save_file = './data/Matrix.mat';
% set parameters
vr = 20;
segN = 100;
load(initial_file);

%% Get genuine data
for i = 1 : segN
    f_name = [num2str(i, '%04d'), '.wav'];
    [y, ~] = audioread([genuine_path, f_name]);
    
    rlist = [];
    for v = 1 : vr
        [~, rt] = Peakratio(y, v);
        rlist(end+1) = rt;
    end
    
    Mgenuine = [Mgenuine; rlist];
end

%% Get modulated data
for i = 1 : segN
    f_name = [num2str(i, '%04d'), '.wav'];
    [y, ~] = audioread([modulated_path, f_name]);
    
    rlist = [];
    for v = 1 : vr
        [~, rt] = Peakratio(y, v);
        rlist(end+1) = rt;
    end

    Mmodulated = [Mmodulated; rlist];
end

%% Save
save(save_file, 'Mgenuine', 'Mmodulated');

