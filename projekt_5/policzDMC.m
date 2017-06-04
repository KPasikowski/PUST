function [ y, u, E, yzad ] = policzDMC(D_, N_, Nu_, lambda, Kk_)
N = N_;
Nu = Nu_;
D=D_;

Su1y1 = load('wykresy_pliki/zad2/odp_skok/odpskok_y1_u_1.txt');
Su2y1 = load('wykresy_pliki/zad2/odp_skok/odpskok_y1_u_2.txt');
Su3y1 = load('wykresy_pliki/zad2/odp_skok/odpskok_y1_u_3.txt');
Su4y1 = load('wykresy_pliki/zad2/odp_skok/odpskok_y1_u_4.txt');
Su1y2 = load('wykresy_pliki/zad2/odp_skok/odpskok_y2_u_1.txt');
Su2y2 = load('wykresy_pliki/zad2/odp_skok/odpskok_y2_u_2.txt');
Su3y2 = load('wykresy_pliki/zad2/odp_skok/odpskok_y2_u_3.txt');
Su4y2 = load('wykresy_pliki/zad2/odp_skok/odpskok_y2_u_4.txt');
Su1y3 = load('wykresy_pliki/zad2/odp_skok/odpskok_y3_u_1.txt');
Su2y3 = load('wykresy_pliki/zad2/odp_skok/odpskok_y3_u_2.txt');
Su3y3 = load('wykresy_pliki/zad2/odp_skok/odpskok_y3_u_3.txt');
Su4y3 = load('wykresy_pliki/zad2/odp_skok/odpskok_y3_u_4.txt');

s11=Su1y1(:,2);
s12=Su2y1(:,2);
s13=Su3y1(:,2);
s14=Su4y1(:,2);
s21=Su1y2(:,2);
s22=Su2y2(:,2);
s23=Su3y2(:,2);
s24=Su4y2(:,2);
s31=Su1y3(:,2);
s32=Su2y3(:,2);
s33=Su3y3(:,2);
s34=Su4y3(:,2);

kk=Kk_;

ny=3;
nu=4;
E1=0;
E2=0;
E3=0;

yzads1 = [1.05 0.8 1.1 0.9];
yzads2 = [0.9 0.8 1.1 1];
yzads3 = [0.9 0.8 1.1 1];

index1 = 1;
index2 = 1;
index3 = 1;
y=zeros(ny,kk);
yzad=zeros(ny,kk);
yzad1 = yzads1(index1);
yzad2 = yzads2(index2);
yzad3 = yzads3(index3);
yzad(1,Kk_) = yzad1;
yzad(2,Kk_) = yzad2;
yzad(3,Kk_) = yzad3;
u=zeros(nu,kk);
du=zeros(nu,kk);
dUP=cell(D-1,1);
dUP(1:D-1)={zeros(2,1)};
M=cell(N,Nu);

for i=1:N
   for j=1:Nu
      if (i>=j)
         M(i,j)={[s11(i-j+1) s12(i-j+1); s21(i-j+1) s22(i-j+1)]};
      else
          M(i,j)={zeros(nu,ny)};
      end
   end
end

MP=cell(N,D-1);
for i=1:N
   for j=1:D-1
      if i+j<=D
         MP(i,j)={[s11(i+j)-s11(j) s12(i+j)-s12(j); s21(i+j)-s21(j) s22(i+j)-s22(j)]};
      else
         MP(i,j)={[s11(D)-s11(j) s12(D)-s12(j); s21(D)-s21(j) s22(D)-s22(j)]};
      end
   end
end

K=(cell2mat(M)'*cell2mat(M)+diag(ones(1,Nu*nu)*lambda))^(-1)*cell2mat(M)';
ku=K(1:nu,:)*cell2mat(MP);
ke1=sum(K(1,1:2:(N*ny)));
ke2=sum(K(1,2:2:(N*ny)));
ke3=sum(K(2,1:2:(N*ny)));
ke4=sum(K(2,2:2:(N*ny)));

for k=10:kk
    
    if mod(k, 200) == 0
        index1 = index1 + 1;
        if index1 > length(yzads1)
            index1 = length(yzads1);
        end
        yzad1 = yzads1(index1);
    end
    yzad(1,k) = yzad1;
    
    if mod(k, 120) == 0
        index2 = index2 + 1;
        if index2 > length(yzads2)
            index2 = length(yzads2);
        end
        yzad2 = yzads2(index2);
    end
    yzad(2,k) = yzad2;
    
    if mod(k, 220) == 0
        index3 = index3 + 1;
        if index3 > length(yzads3)
            index3 = length(yzads3);
        end
        yzad3 = yzads3(index3);
    end
    yzad(3,k) = yzad3;
    
    [y(1, k), y(2, k), y(3, k)] = symulacja_obiektu6( ...
            u(1, k-1), u(1, k-2), u(1, k-3), u(1, k-4), ...
            u(2, k-1), u(2, k-2), u(2, k-3), u(2, k-4), ...
            u(3, k-1), u(3, k-2), u(3, k-3), u(3, k-4), ...
            u(4, k-1), u(4, k-2), u(4, k-3), u(4, k-4), ...
            y(1, k-1), y(1, k-2), y(1, k-3), y(1, k-4), ...
            y(2, k-1), y(2, k-2), y(2, k-3), y(2, k-4), ...
            y(3, k-1), y(3, k-2), y(3, k-3), y(3, k-4));
    
    du(:,k)=[ke1 ke2;ke3 ke4]*(yzad(:,k)-y(:,k))-ku*cell2mat(dUP);
   
    for i=D-1:-1:2
      dUP(i)=dUP(i-1);
    end
    
   dUP(1)={du(:,k)};
   u(:,k)=u(:,k-1)+du(:,k);
   
end

for k=1:kk
    E1 = E1 + ((yzad(1,k) - y(1,k))^2);
    E2 = E2 + ((yzad(2,k) - y(2,k))^2);
    E3 = E3 + ((yzad(3,k) - y(3,k))^2);
end

E=E1+E2+E3;

end
