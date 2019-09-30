function [ list, r ] = Peakratio( y, l )

if (1 == l)
    [ list, r ] = Deriv(y);
    return;
end

len = max(size(y));
yr = [ones(l-1, 1) * y(1, 1); y(:,1); ones(l-1, 1) * y(end, 1)];

cnt = 0;
list = [];
pv = yr(l);
% search yr area : (l+1):(len+l-2)
for i = (l+1):(l+len-2)
    if (yr(i) == pv)
        continue;
    else
        pv = yr(i);
    end
    %if (yr(i) == max(yr((i-1):(i+1)))) && (yr(i) == max(yr((i-l):(i+l))))
    if (yr(i) >= yr(i-1)) && (yr(i) >= yr(i+1)) ...
        && (yr(i) == max(yr((i-l):(i+l))))
        cnt = cnt + 1;
        list(end+1) = i-l+1;
    elseif (yr(i) <= yr(i-1)) && (yr(i) <= yr(i+1)) ...
            && (yr(i) == min(yr((i-l):(i+l))))
        cnt = cnt + 1;
        list(end+1) = i-l+1;
    end
end

r = cnt / (len - 2);