function [mask_ft,freq_support] = fft_and_shift(mask,dx)
% mask OK
% mask_ft_py_re = dlmread('mask_ana_ft_re.txt')
% mask_ft_py_im = dlmread('mask_ana_ft_im.txt')
% eps_mask_ft_re = max(abs(real(mask_ft)-mask_ft_py_re'))
% eps_mask_ft_im = max(abs(real(mask_ft)-mask_ft_py_im'))
freq = fftfreq(128, dx);
% freq_py = dlmread("freq.txt");
% eps_freq = max(abs(freq-freq_py'));
% Do not forget the pixel size d when creating the frequency support
freq_support = fftshift(fftfreq(128, dx));
% freq_support_py_im = dlmread('freq_sup_im.txt');
% freq_support_py_re = dlmread('freq_sup_re.txt');
% eps_freq_support_py_re = max(abs(real(freq_support)-freq_support_py_re'))
% eps_freq_support_py_im = max(abs(imag(freq_support)-freq_support_py_im'))
;% Analytical Fourier Transform
mask_ana_ft = sinc(freq_support * dot_size) * dot_size / dx;
% mask_ana_ft_py_re = dlmread('mask_ana_ft_re.txt')
% mask_ana_ft_py_im = dlmread('mask_ana_ft_im.txt')
% eps_mask_ana_ft_py_re = max(abs(real(mask_ana_ft)-mask_ana_ft_py_re'))
% eps_mask_ana_ft_py_im = max(abs(imag(mask_ana_ft)-mask_ana_ft_py_im'))
% Plotting section
