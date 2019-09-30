%close all;
yt = y0(1.465*10^6 : 1.697*10^6, 1);
yp = y2(1.465*10^6 : 1.697*10^6, 1);

%
figure(1);
%r = 1 : size(yt, 1);
r = 10000:11000;
plot(r, yt(r), r, yp(r))

l = 1;
[listt, rt] = Peakratio(yt(r), l);
[listp, rp] = Peakratio(yp(r), l);

for i = 1 : size(listt, 2)
    x = listt(i) + r(1) - 1;
    y = yt(x);
    hold on;
    plot(x, y, 'ro');
end

for i = 1 : size(listp, 2)
    x = listp(i) + r(1) - 1;
    y = yp(x);
    hold on;
    plot(x, y, 'go');
end

%plot(r, yt(r), r, yp(r))
xlabel('samples');
ylabel('amplitude');
legend('human voice','modified recording')

%
figure(2);
tic;
rtlist = []; rplist = [];
vr = 20;
for v = 1 : vr
    [listt, rt] = Peakratio(yt(r), v);
    plot(v, 100*rt, 'ro');
    rtlist(end+1) = rt;
    hold on;
    [listp, rp] = Peakratio(yp(r), v);
    plot(v, 100*rp, 'bx');
    rplist(end+1) = rp;
    hold on;
end
toc
plot(1:vr, 100*rtlist, 'r');
hold on;
plot(1:vr, 100*rplist, 'b');
% hold on;
% for v = 1 : vr
%     [listt, rt] = Peakratio(yt(r), v);
%     plot(v, 100*rt, 'ro');
%     %rtlist(end+1) = rt;
%     hold on;
%     [listp, rp] = Peakratio(yp(r), v);
%     plot(v, 100*rp, 'bx');
%     %rplist(end+1) = rp;
%     hold on;
% end
% 
% xlabel('Window parameter r')
% ylabel('Local extrema ratio (%)')
% legend('human voice', 'modified recording')