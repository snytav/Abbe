function [t,f1] = symbolic_signal(halflength)
syms t
f1 = rectangularPulse(-halflength,halflength,t);
end