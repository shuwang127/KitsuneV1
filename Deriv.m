function [ list, r ] = Deriv( y )

len = max(size(y));
der = y(2:end, 1) - y(1:(end-1), 1);

sig = sign(der(1));
cnt = 0;
list = [];
for i = 2 : (len-1)
    csig = sign(der(i));
    
    if (sig*csig < 0)
        cnt = cnt + 1;
        list(end+1) = i;
        sig = csig;
    elseif (sig == 0)
        list(end+1) = i;
        sig = csig;
    end
end

r = cnt / (len - 2);