function [ Y, U, E, yzadVec ] = policzDMCzad6( D_, N_, Nu_, lambda_, d_, c_, Kk_)

numOfControllers = 2;
D=D_;
N=N_;
Nu=Nu_;
lambda=lambda_;
d = d_;
c = c_;

s_1 = load('wykresy_pliki/zad6/odpowiedzi/wyjscie_skok_-1_0.75.txt');
s_last = load('wykresy_pliki/zad6/odpowiedzi/wyjscie_skok_0.75_1.txt');
Upp=0;
Ypp=0;
Umin=-1;
Umax=1;

index = 1;
yzads = [-1 -2.5 -1 0];
yzad = yzads(index);
yzadVec(1:Kk_) = yzad;
Yzad = yzadVec - Ypp;

%inicjalizacja sta?ych
kk=Kk_;

ku=zeros(numOfControllers,D-1);
ke=zeros(1,numOfControllers);
                            %DMC
%----------------------------------------------------------------
for m = 1 : numOfControllers
    
    if m == 1
        s=s_1(:,2);
    elseif m == numOfControllers
        s=s_last(:,2);
    elseif m == 2 && numOfControllers == 3
        stemp=load('wykresy_pliki/zad6/odpowiedzi/wyjscie_skok_-0.6_-0.23.txt');
        s=stemp(:,2);
    elseif m == 2 && numOfControllers == 4
        stemp=load('wykresy_pliki/zad6/odpowiedzi/wyjscie_skok_-0.6_-0.4.txt');
        s=stemp(:,2);
    elseif m == 3 && numOfControllers == 4
        stemp=load('wykresy_pliki/zad6/odpowiedzi/wyjscie_skok_-0.4_-0.23.txt');
        s=stemp(:,2);
    elseif m == 2 && numOfControllers == 5
        stemp=load('wykresy_pliki/zad6/odpowiedzi/wyjscie_skok_-0.7_-0.4.txt');
        s=stemp(:,2);
    elseif m == 3 && numOfControllers == 5
        stemp=load('wykresy_pliki/zad6/odpowiedzi/wyjscie_skok_-0.4_-0.26.txt');
        s=stemp(:,2);
    elseif m == 4 && numOfControllers == 5
        stemp=load('wykresy_pliki/zad6/odpowiedzi/wyjscie_skok_-0.26_-0.09.txt');
        s=stemp(:,2);
    end
    
    

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
    K=((M'*M+lambda(m)*I)^-1)*M';
    ku(m, :)=K(1,:)*MP;
    ke(m)=sum(K(1,:));

end

U(1:kk)=Upp;
Y(1:kk)=Ypp;

e=zeros(1,kk);

u=U-Upp;
y=Y-Ypp;
umax = Umax - Upp;
umin = Umin - Upp;

deltaup=zeros(1,D-1);

mi = zeros(1, numOfControllers);
u_n = zeros(1, numOfControllers);

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
   for m = 1 : numOfControllers
        deltauk=ke(m)*e(k)-ku(m, :)*deltaup';
        u_n(m) = U(k-1) + deltauk;
   end
   
   if numOfControllers == 2
       mi(1) = 1 - 1 / (1 + exp(-d(1) * (y(k) - c(1))));
       mi(2) = 1 / (1 + exp(-d(1) * (y(k) - c(1))));
%        if(yzad == yzads(4))
%        disp('y = ');
%        disp(y(k));    
%        disp('m1 = ');
%        disp(mi(1));
%        disp('m2 = ');
%        disp(mi(2));
%        end
   elseif numOfControllers == 3
       mi(1) = 1 - 1 / (1 + exp(-d(1) * (y(k) - c(1))));
       mi(2) = 1 / (1 + exp(-d(1) * (y(k) - c(1)))) - 1 / (1 + exp(-d(2) * (y(k) - c(2))));
       mi(3) = 1 / (1 + exp(-d(2) * (y(k) - c(2))));
   elseif numOfControllers == 4
       mi(1) = 1 - 1 / (1 + exp(-d(1) * (y(k) - c(1))));
       mi(2) = 1 / (1 + exp(-d(1) * (y(k) - c(1)))) - 1 / (1 + exp(-d(2) * (y(k) - c(2))));
       mi(2) = 1 / (1 + exp(-d(2) * (y(k) - c(2)))) - 1 / (1 + exp(-d(3) * (y(k) - c(3))));
       mi(4) = 1 / (1 + exp(-d(3) * (y(k) - c(3))));
   elseif numOfControllers == 5
       mi(1) = 1 - 1 / (1 + exp(-d(1) * (y(k) - c(1))));
       mi(2) = 1 / (1 + exp(-d(1) * (y(k) - c(1)))) - 1 / (1 + exp(-d(2) * (y(k) - c(2))));
       mi(3) = 1 / (1 + exp(-d(2) * (y(k) - c(2)))) - 1 / (1 + exp(-d(3) * (y(k) - c(3))));
       mi(4) = 1 / (1 + exp(-d(3) * (y(k) - c(3)))) - 1 / (1 + exp(-d(4) * (y(k) - c(4))));
       mi(5) = 1 / (1 + exp(-d(4) * (y(k) - c(4))));
   end
    
   u(k) = sum(u_n*mi') / sum(mi); 
   
   if u(k)>umax
      	u(k)=umax;
   elseif u(k)<umin
        u(k)=umin;
   end
   
   for n=D-1:-1:2
      deltaup(n)=deltaup(n-1);
   end
   deltaup(1)=u(k) - u(k-1);
   
   U(k)=u(k)+Upp;

end

%obliczenie b??du
E=0;
for k=1:kk
    E=E+((Yzad(k)-Y(k))^2);
end 

end

