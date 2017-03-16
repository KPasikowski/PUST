parametry;

delta_u = 0.4;
y = zeros(Kk,1) + Ypp;
u(1:11) = Upp;
u(12:Kk) = Upp + delta_u;

for k = 12 : Kk
    y(k) = symulacja_obiektu4Y(u(k-10), u(k-11), y(k-1), y(k-2));
end

wzmoc_stat = (y(Kk) - Ypp) / delta_u;

%wykres
stairs(y) ;
xlabel('k') ;
ylabel('y') ;
title('odpowied? obiektu dla skoku sterowania z Upp = 2 na U = 2.4');
