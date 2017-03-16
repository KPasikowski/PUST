function [ horDyn ] = policzHorDynamiki( s )
% funkcja liczy horyzont dynamiki na podstawie odpowiedzi skokowej obiektu

tol = 0.0001 ;
k = 1 ;

while s(k) == 0
    k = k + 1 ;
end

while  s(k+1) - s(k)  > tol
    k = k + 1 ;
end

horDyn = k ;