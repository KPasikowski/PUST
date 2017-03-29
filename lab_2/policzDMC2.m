function [  ] = policzDMC2( D_, Dz_, N_, Nu_, lambda_, Kk_, dist_measure )

T1 = 0.1769012380547;
T2 = 184.3023815254766;
K  = 0.3274418893550;
Td = 20;

al1 = exp(-1/T1);
al2 = exp(-1/T2);

a1 = -al1 - al2;
a2 = al1 * al2;

b1 = K*(1/(T1-T2))*(T1*(1-al1) - T2*(1-al2));
b2 = K*(1/(T1-T2))*(al1*T2*(1-al2) - al2*T1*(1-al1));

D=D_;
DZ=Dz_;
N=N_;
Nu=Nu_; %20
lambda=lambda_; %0.5
s = load('nowe/odpskok_y_apr');
s = s.Sapr;
s(length(s) : 400) = s(length(s));
sz = load('nowe/odpskok_z_apr');
sz = sz.Sapr;
sz(length(sz) : 400) = sz(length(sz));
zak=dist_measure;
Upp=29;
Ypp=34.5;
Umin=0;
Umax=100;

%inicjalizacja sta?ych
kk=Kk_;
startk=10;
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

MZP=zeros(N,DZ);
for i=1:N
    MZP(i,1) = sz(i);
   for j=2:DZ
      if i+j-1<=DZ
         MZP(i,j)=sz(i+j-1)-sz(j);
      else
         MZP(i,j)=sz(DZ)-sz(j);
      end;      
   end;
end;

% Obliczanie parametr?w regulatora

I=eye(Nu);
K=((M'*M+lambda*I)^-1)*M';
ku=K(1,:)*MP;
kz=K(1,:)*MZP;
ke=sum(K(1,:));

U(1:kk)=Upp;
Y(1:kk)=Ypp;
Z(1:kk)=0;
%startz=300;
%z(startz:kk)= 1;

e=zeros(1,kk);
Yzad(1:startk)=Ypp; 
Yzad(startk:kk)=Ypp+3;

u=U-Upp;
y=U-Ypp;
yzad = Yzad-Ypp;
umax = Umax - Upp;
umin = Umin - Upp;

deltaup=zeros(1,D-1);
deltazp=zeros(1,DZ-1);


for k=23:kk
   %symulacja obiektu
   Y(k)= b1*U(k - Td - 1) + b2*U(k - Td -  2) - a1*Y(k - 1) - a2*Y(k - 2);
   y(k) = Y(k) - Ypp;
   %uchyb regulacji
   e(k)=yzad(k) - y(k);
   
   %uwzgl?dnianie zak??cenia
   for n=DZ:-1:2;
       deltazp(n)=deltazp(n-1);
   end
   deltazp(1)=Z(k)-Z(k-1);
   
   % Prawo regulacji
   deltauk=ke*e(k)-ku*deltaup';
   if(zak)
       deltauk=deltauk-kz*deltazp';
   end;
   
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

plot(Y);

%obliczenie b??du
E=0;
for k=1:kk
    E=E+((Yzad(k)-Y(k))^2);
end 

end

