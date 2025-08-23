close all;
% rectangular pulse FT example
syms t
f1 = rectangularPulse(-1/2,1/2,t);
FT1 = fourier(f1);
FT1 = simplify(FT1)
n_f1 = ones(128,1)
n_t = linspace(-5,5,128);
for i = 1:size(n_f1,1)
    if abs(n_t(i)) < 1/2
        n_f1(i) = 1.0;
    else
        n_f1(i) = 0.0;
    end
end 

tiledlayout(2,2)
nexttile
fplot(f1)
xlabel("$t$",Interpreter="latex")
ylabel("$f(t)$",Interpreter="latex")
title("Rectangular Pulse")
nexttile
fplot(real(FT1),[-50 50])
hold on
fplot(imag(FT1),[-50 50])
xlabel("$w$",Interpreter="latex")
ylabel("FT($w$)",Interpreter="latex")
title("Fourier Transform")
legend("Re(FT)","Im(FT)",Location="northeastoutside")
nexttile
plot(n_t,n_f1);
title('Numeric rectangle pulse');
nexttile
% Do not forget the pixel size d when creating the frequency support
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  compare n_f1 and mask
n_FT1 = fftshift(fft(n_f1));
freq = fftfreq(128, dx);
freq_support = fftshift(fftfreq(128, dx));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

plot(freq_support,real(n_FT1))
title("Shifted Numeric Fourier Transform")
syms x y lambda;
% Define the chromium dot size in nanometers
dot_size = 250;
% Define the mask support (x support)
% Since we compute FT, better to choose a 2^n number of points
%x_support = linspace(-1000, 1000, 128);
% Compute the pixel size in nanometers

% Define the mask, 1 for glass, 0 for chromium
mask = abs(x_support) < dot_size / 2;
%TODO:1. draw mask vs. X
figure;
plot(x_support,mask,'r')
xlabel('X');
hold on;
title('mask');
a = dot_size;
object = heaviside(x + a/2)- heaviside(x - a/2); % where 'a' is the slit width
fplot(object,[-1000,1000],'g');
legend('numeric','symbolic');
hold off;
% Define illumination (plane wave)
illumination = 1;
% Propagate to the back focal plane (Fourier transform)
k = 2*pi/lambda;
object_spectrum = fourier(object);
figure;
fplot(object_spectrum);
title('SYMBOLIC SPECTRUM')
%     2. define symbolic mask and draw       
% Plot
figure;
title('Mask Transmission');
plot(x_support, mask);
xlabel('x position [nm]');
ylabel('Mask transmission');
grid on;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Computation of the mask TF and its frequency support

mask_ft_unshifted = fft(mask);
% figure;
mask_ft_sym_num = zeros(size(mask_ft,1))
syms w;
for i=1:size(mask_ft,1)
    mask_ft_sym_num(i) = subs(object_spectrum,w,x_support(i));
    num = real(mask_ft_unshifted(i));
    sym = mask_ft_sym_num(i);
    eps = abs(num-sym);
    fprintf("%3d numeric %15.5e symbolic %15.5e eps %e \n",i,num,sym,eps);
end
% plot(real(fft(mask)),'r');
% hold on;
% fplot(object_spectrum,'g');
% plot(imag(fft(mask)),'g');
legend('NUMERICAL','SYMBOLIC');
hold off;
title('NUMERICAL SPECTRUM');
% mask_ft_re = dlmread('mask_ft_re.txt')
% mask_ft_im = dlmread('mask_ft_im.txt')
% eps_mask_ft_re = max(abs(real(mask_ft)-mask_ft_re'))
% eps_mask_ft_im = max(abs(imag(mask_ft)-mask_ft_im'))
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[mask_ft,freq_support] = fft_and_shift(mask,dx);
figure
title('Mask Fourier Transform');
plot(freq_support, abs(mask_ft), 'DisplayName', 'Numeric FT');
hold on;
plot(freq_support, abs(mask_ana_ft), 'o', 'DisplayName', 'Analytic FT');
legend show;
% mask_ana_py = dlmread('mask_ana_ft.txt')
% eps = max(abs(mask_ana_ft-mask_ana_py))
xlabel('Frequency [1/nm]');
ylabel('Mask spectrum');
hold off;