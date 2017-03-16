function [ E ] = policzDMC( input )
Upp = 2;
Ypp = 0.8;
U_min = 1.2;
U_max = 2.8;
dU_max = 0.25;

Kk = 1600;

N = input(1);
Nu = input(2);
lambda = input(3);

s = policz_odp_skok();

D = policzHorDynamiki(s) ;   %horyzont dynamiki
yzads = [1.05 0.8 1.1 0.9];
index = 1;
yzad = yzads(index);   %skok wartosci zadanej
yzadVec(1:Kk) = yzad;

%sygnal sterujacy
u = Upp + zeros(1,Kk) ;
U = Upp + zeros(1,Kk);
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
y2 = zeros(Kk, 1);

for k = 12:Kk

    if mod(k,200) == 0
        index = index + 1;
        if index > length(yzads)
            index = length(yzads);
        end
        yzad = yzads(index);
    end
    yzadVec(k) = yzad;
   
    y(k) = symulacja_obiektu4Y(U(k-10), U(k-11), y(k-1), y(k-2)) ;
    
    sum = 0;    %suma potrzebna do obliczenia skladowej swobodnej
    for j = 1:D-1
        if(k-j > 0)
            sum = sum + kju(j)*du(k-j);
            %w innym przypadku du = 0 wiec sum sie nie zmienia
        end
    end
    y2(k) = y(k) - Ypp;
    yzad2 = yzad - Ypp;
    du(k) = ke * (yzad2-y2(k)) - sum ;
    
    % --- sprawdzenie, czy przyrost znajduje sie w ograniczeniach  ---
    if du(k) > dU_max
        du(k) = dU_max;
    elseif du(k) < -dU_max
        du(k) = -dU_max;
    end
    
    u(k) = u(k-1) + du(k);
    
    if u(k) > U_max - Upp
        u(k) = U_max - Upp;
    elseif u(k) < U_min - Upp
        u(k) = U_min - Upp;
    end
    
    U(k) = u(k) + Upp;
    
end

% wska?nik jako?ci regulacji
E = (yzadVec - y)*(yzadVec - y)';
end

