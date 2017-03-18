function [ y, u, E ] = policzDMC( D_, N_, Nu_, Dz_, Nz_, Nuz_, lambda_ )
Upp = 0;
Zpp = 0;
Ypp = 0;

Kk = 300;

D = D_;
N = N_;
Nu = Nu_;

Dz = Dz_;
Nz = Nz_;
Nuz = Nuz_;
lambda = lambda_;

yzad = 1;   %skok wartosci zadanej
yzadVec(1:Kk) = yzad;

s = load('wykresy_pliki/zad3/skok_sterowania/odp_skok_ster_0.4.txt');
s = s(:, 2);
s(length(s) : 400) = s(length(s));

sz = load('wykresy_pliki/zad3/skok_sterowania/odp_skok_ster_0.4.txt');
sz = sz(:, 2);
sz(length(sz) : 400) = sz(length(sz));

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
	dz(k) = 0;
    
    sum = 0;    %suma potrzebna do obliczenia skladowej swobodnej
    for j = 1:D-1
        if(k-j > 0)
            sum = sum + kju(j)*du(k-j);
            %w innym przypadku du = 0 wiec sum sie nie zmienia
        end
    end

	sumz = 0;
	i = k;
	Pz = Dz;
	for j = i+1:Pz-1
		if (k-j+i > 0)
			sumz += sz(j)*dz(k-j+i);
		end
	end
	for j = Pz:Pz+i-1
		if (k-j+i > 0)
			sumz += sz(Pz)*dz(k-j+i);
		end
	end
	for j = 1:Pz-1
		if (k-j > 0)
			sumz -= sz(j)*dz(k-j);
		end
	end
	%for j = 1:i
	%	if (k-j > 0)
			%sumz -= sz(j)*dzk(k-j+i);
			% bez przewidywanych zmian w zakłóceniu
	%	end
	%end
    
    du(k) = ke * (yzad-y(k)-sumz) - sum) ;
    
    u(k) = u(k-1) + du(k);
	z(k) = z(k-1) + dz(k);
    
end

% wska?nik jako?ci regulacji
E = (yzadVec - y)*(yzadVec - y)';
end

