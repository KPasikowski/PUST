function [ Y, U, E, yzadVec ] = policzDMC( D_, N_, Nu_, lambda_, Kk_)

D=D_;
N=N_;
Nu=Nu_;
lambda=lambda_;

% testowanie i dobieranie parametr?w z zadania 6 i 7
% s = load('wykresy_pliki/zad6/odpowiedzi/wyjscie_skok_0.75_1.txt');
% s = s(:, 2);

s = load('wykresy_pliki/zad6/odpowiedzi/wyjscie_skok_-0.7_-0.4.txt');
s = s(:, 2);
s = (s(7 : length(s)) - s(6)) / 0.3;
s(length(s) : 400) = s(length(s));
Upp=0;
Ypp=0;
Umin=-1;
Umax=1;

% testowanie i dobieranie parametr?w z zadania 6 i 7
% index = 1;
% yzads = [0.084];
% yzad = yzads(index);
% yzadVec(1:Kk_) = yzad;
% Yzad = yzadVec - Ypp;

index = 1;
yzads = [-1 -2.5 -1 0.06];
yzad = yzads(index);
yzadVec(1:Kk_) = yzad;
Yzad = yzadVec - Ypp;
% inicjalizacja sta?ych
kk=Kk_;
                            %DMC
%----------------------------------------------------------------
M=zeros(N,Nu);
for i=1:N
   for j=1:Nu
      if (i>=j)
         M(i,j)=s(i-j+1);
      end;
   end;
end;

MP=zeros(N,D-1);
for i=1:N
   for j=1:D-1
      if i+j<=D
         MP(i,j)=s(i+j)-s(j);
      else
         MP(i,j)=s(D)-s(j);
      end;      
   end;
end;

% Obliczanie parametr?w regulatora

I=eye(Nu);
K=((M'*M+lambda*I)^-1)*M';
ku=K(1,:)*MP;
ke=sum(K(1,:));

% U(1:kk)=Upp;
% Y(1:kk)=Ypp;

% testowanie i dobieranie parametr?w z zadania 6 i 7
U(1:kk)=0.44;
Y(1:kk)=0.07632;

e=zeros(1,kk);

u=U-Upp;
y=Y-Ypp;
umax = Umax - Upp;
umin = Umin - Upp;

deltaup=zeros(1,D-1);

for k=7:kk
   if mod(k,200) == 0
       index = index + 1;
       if index > length(yzads)
           index = length(yzads);
       end
       yzad = yzads(index);
   end
   yzadVec(k) = yzad;
   Yzad(k) = yzadVec(k) - Ypp;
    
   %symulacja obiektu
   Y(k)= symulacja_obiektu6y(U(k-5), U(k-6), Y(k-1), Y(k-2));
   y(k) = Y(k) - Ypp;
   %uchyb regulacji
   e(k)=Yzad(k) - y(k);
   
   % Prawo regulacji
   deltauk=ke*e(k)-ku*deltaup';
   
   for n=D-1:-1:2
      deltaup(n)=deltaup(n-1);
   end
   deltaup(1)=deltauk;
   u(k)=u(k-1)+deltaup(1);
   
   if u(k)>umax
      	u(k)=umax;
   elseif u(k)<umin
        u(k)=umin;
   end
   U(k)=u(k)+Upp;

end

%obliczenie b??du
E=0;
for k=1:kk
    E=E+((Yzad(k)-Y(k))^2);
end 

end

