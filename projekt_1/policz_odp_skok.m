function [ s, u ] = policz_odp_skok( )
Ypp = 0.8;
Upp = 2;
Kk = 1614;  

delta_u = 0.8;
u = zeros(Kk, 1);

s = zeros(Kk, 1) + Ypp;

u(1:11) = Upp;
u(12:Kk) = Upp + delta_u;

for k = 12 : Kk
   s(k) = symulacja_obiektu4Y(u(k-10), u(k-11), s(k-1), s(k-2));
end
s = s(13:end);
s = (s - Ypp) / delta_u;

end

