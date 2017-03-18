function [ y, u, E ] = policzDMC( D_, N_, Nu_, lambda_ )
Upp = 0;
Zpp = 0;
Ypp = 0;

Kk = 300;

D = D_;
N = N_;
Nu = Nu_;
lambda = lambda_;

yzad = 1;   %skok wartosci zadanej
yzadVec(1:Kk) = yzad;

s = load('wykresy_pliki/zad3/skok_sterowania/odp_skok_ster_0.4.txt');
s = s(:, 2);
s(length(s) : 400) = s(length(s));

%sygnal sterujacy
u = Upp + zeros(1,Kk);

%sygnal zaklocenia
z = Zpp + zeros(1, Kk);
%uchyb
e = zeros(1,N) ;
%wyjscie ukladu
y = zeros(1,Kk) + Ypp ;

%obliczanie odpowiedzi skokowej
du = (zeros(1,Kk))' ;

M = zeros(N, Nu) ;
for i = 1:N
    for j = 1:Nu
        if (i-j+1 > 0)
            M(i,j) = s(i-j+1) ;
        else
            M(i,j) = 0 ;
        end
    end
end

Mp = zeros(N, D-1) ;
for i = 1:N
    for j = 1:(D-1)
        if(i+j <= N)
            Mp(i,j) = s(i+j) - s(j) ;
        else
            Mp(i,j) = s(N) - s(j) ;
        end
    end
end

K = (M'*M + lambda*eye(Nu))^-1 * M' ;

%liczenie ke
ke = 0;
for i = 1:N
    ke = ke + K(1, i);
end

kju = K(1,:)*Mp;

for k = 7:Kk
   
    y(k) = symulacja_obiektu3y(u(k - 5), u(k - 6), z(k - 2), z(k - 3), y(k - 1), y(k - 2));
    
    sum = 0;    %suma potrzebna do obliczenia skladowej swobodnej
    for j = 1:D-1
        if(k-j > 0)
            sum = sum + kju(j)*du(k-j);
            %w innym przypadku du = 0 wiec sum sie nie zmienia
        end
    end
    
    du(k) = ke * (yzad-y(k)) - sum ;
    
    u(k) = u(k-1) + du(k);
    
end

% wska?nik jako?ci regulacji
E = (yzadVec - y)*(yzadVec - y)';
end

