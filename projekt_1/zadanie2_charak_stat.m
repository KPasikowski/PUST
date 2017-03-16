parametry;

u = [U_min : 0.01 : U_max];
ys = zeros(length(u), 1);
czas_sym = 120;

for k = 1 : length(u)
    y= zeros(czas_sym, 1) + Ypp;
    
    for i = 3 : czas_sym
        y(i) = symulacja_obiektu4Y(u(k), u(k), y(i-1), y(i-2));
    end
    
    ys(k) = y(czas_sym);
end

%wykres y
plot(u, ys) ;
xlabel('u') ;
ylabel('y') ;
title('Charakterystyka statyczna dla sterowan z przedzialu [Umin : 0.01 : Umax]') ;

