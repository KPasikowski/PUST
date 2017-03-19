function [ y, u, E ] = policzDMC( D_, Dz_, N_, Nu_, lambda_, Kk_, z, dist_measure)
Upp = 0;
Zpp = 0;
Ypp = 0;

Kk = Kk_;

D = D_;
Dz = Dz_;
N = N_;
Nu = Nu_;
lambda = lambda_;

yzad = 1;   %skok wartosci zadanej
yzadVec(1:Kk) = yzad;

s = load('wykresy_pliki/zad3/skok_sterowania/odp_skok_ster_0.4.txt');
s = s(:, 2);
s(length(s) : 400) = s(length(s));

s_z = load('wykresy_pliki/zad3/skok_zaklocenia/odp_skok_zakl_0.4.txt');
s_z = s_z(:, 2);
s_z(length(s_z) : 400) = s_z(length(s_z));

%sygnal sterujacy
u = Upp + zeros(1,Kk);

%wyjscie ukladu
y = zeros(1,Kk) + Ypp ;

du = (zeros(1,Kk))' ;
dz = (zeros(1,D-1))' ;

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

Mpz = zeros(N, Dz-1) ;
for i = 1:N
    for j = 1:(Dz-1)
        if(i+j <= N)
            Mpz(i,j) = s_z(i+j) - s_z(j) ;
        else
            Mpz(i,j) = s_z(N) - s_z(j) ;
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

kz = K(1,:)*Mpz;

for k = 7:Kk
   
    y(k) = symulacja_obiektu3y(u(k - 5), u(k - 6), z(k - 2), z(k - 3), y(k - 1), y(k - 2));
    
    sum = 0;    %suma potrzebna do obliczenia skladowej swobodnej
    for j = 1:D-1
        if(k-j > 0)
            sum = sum + kju(j)*du(k-j);
            %w innym przypadku du = 0 wiec sum sie nie zmienia
        end
    end
    
    dz(k) = z(k) - z(k-1);
    sum2 = 0;
    for j = 1:Dz-1
        if(k-j > 0)
            sum2 = sum2 + kz(j)*dz(k-j);
        end
    end
    
    du(k) = ke * (yzad-y(k)) - sum;
    
    if dist_measure == 1 
        du(k) = du(k) - sum2;
    end
    
    u(k) = u(k-1) + du(k);
    
    
end

% wska?nik jako?ci regulacji
E = (yzadVec - y)*(yzadVec - y)';
end

