function [ y, u, E ] = DMC( D_, N_, Nu_, lambda_, Kk_)
Upp = 29;
Ypp = 34;

Kk = Kk_;

D = D_;
N = N_;
Nu = Nu_;
lambda = lambda_;

U_max = 100;
U_min = 0;

yzad = 37;   %skok wartosci zadanej
yzadVec(1:30) = Ypp;
yzadVec(31:Kk) = yzad;

s = load('Sapr_zad3');
s = s.Sapr;
%s(length(s) : 400) = s(length(s));

%sygnal sterujacy
u = Upp + zeros(1,Kk);

%wyjscie ukladu
y = zeros(1,Kk) + Ypp ;

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

addpath ('F:\SerialCommunication'); % add a path
initSerialControl COM14 % initialise com port
sendControls ([1,5],[50,Upp]);

figure;

for k = 1:30    
    y(k) = readMeasurements(1);

    stairs(y);
    pause(0.01);
    
    waitForNewIteration();
end

for k = 31:Kk
  
    y(k) = readMeasurements(1);
    
    sum = 0;    %suma potrzebna do obliczenia skladowej swobodnej
    for j = 1:D-1
        if(k-j > 0)
            sum = sum + kju(j)*du(k-j);
            %w innym przypadku du = 0 wiec sum sie nie zmienia
        end
    end
    
    du(k) = ke * (yzadVec(k)-y(k)) - sum;
    
    u(k) = u(k-1) + du(k);
    
    if u(k) > U_max - Upp
        u(k) = U_max - Upp;
    elseif u(k) < U_min - Upp
        u(k) = U_min - Upp;
    end
    
    sendNonlinearControls(u(k)+Upp);
    
    stairs(y);
    pause(0.01);
    
    waitForNewIteration();
    
end

% wska?nik jako?ci regulacji
E = (yzadVec - y)*(yzadVec - y)';

fileTitle = ['DMC_u_',num2str(lambda),'.txt'];
filename = fopen(fileTitle,'w');
for i=1:Kk
    fprintf(filename,'%5d ',i);
    fprintf(filename,'%5d\n',u(i));
end
fclose(filename);

fileTitle = ['DMC_y_',num2str(lambda),'.txt'];
filename = fopen(fileTitle,'w');
for i=1:Kk
    fprintf(filename,'%5d ',i);
    fprintf(filename,'%5d\n',y(i));
end
fclose(filename);

fileTitle = ['DMC_E_',num2str(lambda),'.txt'];
filename = fopen(fileTitle,'w');
fprintf(filename,'%5d ',E);
fclose(filename);

end

