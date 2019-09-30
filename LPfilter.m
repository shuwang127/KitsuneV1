function [ yr ] = LPfilter( y, fs )
% Low-Pass filter to band the low frequency components.
% Shaun Wang 2019-04-17

[~, amp, ph] = fastFT(y(:,1), fs);

N = 2^nextpow2(length(y));
frg = fs / N;
fL = 2000; % Hz
NL = floor(fL / frg); % Threshold
amp((1+NL) : (end-NL)) = 0;

z = amp .* exp(1i * ph);
yr = real(ifft(z) * N / 2);
yr = yr(1:length(y));

end

