
tiledlayout(2,2)
% numerical sygnal
% from Python: linspace(-1000.,1000.,128)
[n_t,n_f1] = numerical_signal(128,50,-1000,1000);
[mask_ft,freq_support] = fft_and_shift(n_f1,n_t);
[t,f1] = symbolic_signal(50);
FT1 = fourier(f1);

nexttile
plot(n_t,n_f1);
title('Numeric rectangle pulse');
% numerical FFT of numerical signal
nexttile


% symbolic signal
nexttile
fplot(f1)
xlabel("$t$",Interpreter="latex")
ylabel("$f(t)$",Interpreter="latex")
title("Rectangular Pulse")
% symbolic FFT of symbolic signal
nexttile
fplot(real(FT1),[-50 50])
hold on
fplot(imag(FT1),[-50 50])
xlabel("$w$",Interpreter="latex")
ylabel("FT($w$)",Interpreter="latex")
title("Fourier Transform")
legend("Re(FT)","Im(FT)",Location="northeastoutside")