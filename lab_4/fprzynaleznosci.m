function [mi] = fprzynaleznosci(x,par)
mi = 1/(1+exp(-par(1)*(x-par(2))));
end