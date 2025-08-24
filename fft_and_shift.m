function [mask_ft,freq_support] = fft_and_shift(mask,x_support)

N = size(mask,1);
xmax = max(x_support);
xmin = min(x_support);
dx = (xmax - xmin)/N;

freq = fftfreq(N, dx);

mask_ft = fftshift(fft(mask));

% Do not forget the pixel size d when creating the frequency support
freq_support = fftshift(fftfreq(128, dx));
end