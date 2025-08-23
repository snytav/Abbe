function [n_t,n_f1] = numerical_signal(N,halflength,xmin,xmax)
n_f1 = ones(N,1);
n_t  = linspace(xmin,xmax,N);
for i = 1:size(n_f1,1)
    if abs(n_t(i)) < halflength
        n_f1(i) = 1.0;
    else
        n_f1(i) = 0.0;
    end
end 
end
