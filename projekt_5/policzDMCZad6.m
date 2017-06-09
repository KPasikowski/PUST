function [ y, u, E, yzad ] = policzDMCZad6(D_, N_, Nu_, lambda, psi, Kk_)
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
u = zeros(nu, kk);
du = zeros(nu, kk);
dUP = zeros((D-1)*nu, 1);
Y = zeros(N*ny, 1);
Yzad = zeros(N*ny, 1);

M = cell(N,Nu);

for i = 1 : N
   for j = 1 : Nu
      if (i >= j)
         M(i, j)={[s11(i-j+1) s12(i-j+1) s13(i-j+1) s14(i-j+1);...
                  s21(i-j+1) s22(i-j+1) s23(i-j+1) s24(i-j+1);...
                  s31(i-j+1) s32(i-j+1) s33(i-j+1) s34(i-j+1)]};
      else
          M(i, j)={zeros(ny, nu)};
      end
   end
end

M = cell2mat(M);
MP = cell(N, D-1);

for i = 1 : N
   for j = 1 : D-1
      if i + j <= D
         MP(i, j) = {[s11(i+j)-s11(j) s12(i+j)-s12(j) s13(i+j)-s13(j) s14(i+j)-s14(j);...
                   s21(i+j)-s21(j) s22(i+j)-s22(j) s23(i+j)-s23(j) s24(i+j)-s24(j);...
                   s31(i+j)-s31(j) s32(i+j)-s32(j) s33(i+j)-s33(j) s34(i+j)-s34(j)]};
      else
         MP(i, j) = {[s11(D)-s11(j) s12(D)-s12(j) s13(D)-s13(j) s14(D)-s14(j);...
                   s21(D)-s21(j) s22(D)-s22(j) s23(D)-s23(j) s24(D)-s24(j);...
                   s31(D)-s31(j) s32(D)-s32(j) s33(D)-s33(j) s34(D)-s34(j)]};
      end
   end
end

MP = cell2mat(MP);

LAMBDA = cell(Nu,Nu);

for i = 1 : Nu
    for j = 1 : Nu
        if i == j
            LAMBDA(i, j)={diag(lambda)};
        else
            LAMBDA(i, j)={zeros(nu, nu)};
        end
    end
end

LAMBDA = cell2mat(LAMBDA);

PSI = cell(N,N);

for i = 1 : N
    for j = 1 : N
        if i == j
            PSI(i, j)={diag(psi)};
        else
            PSI(i, j)={zeros(ny, ny)};
        end
    end
end

PSI = cell2mat(PSI);

K = (M'*PSI*M+LAMBDA)^(-1)*M'*PSI;
K1 = K(1 : nu, :);

ku = K1 * MP;
ke = zeros(4, 3);
ke(1, 1) = sum(K(1, 1 : 3 : (N*ny)));
ke(1, 2) = sum(K(1, 2 : 3 : (N*ny)));
ke(1, 3) = sum(K(1, 3 : 3 : (N*ny)));
ke(2, 1) = sum(K(2, 1 : 3 : (N*ny)));
ke(2, 2) = sum(K(2, 2 : 3 : (N*ny)));
ke(2, 3) = sum(K(2, 3 : 3 : (N*ny)));
ke(3, 1) = sum(K(3, 1 : 3 : (N*ny)));
ke(3, 2) = sum(K(3, 2 : 3 : (N*ny)));
ke(3, 3) = sum(K(3, 3 : 3 : (N*ny)));
ke(4, 1) = sum(K(4, 1 : 3 : (N*ny)));
ke(4, 2) = sum(K(4, 2 : 3 : (N*ny)));
ke(4, 3) = sum(K(4, 3 : 3 : (N*ny)));

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
    
    du(:, k) = ke * (yzad(:, k) - y(:, k)) - ku * dUP;
    
    for i = ((D-1) * nu) : -4 : 8
      dUP(i) = dUP(i-4);
      dUP(i-1) = dUP(i-5);
      dUP(i-2) = dUP(i-6);
      dUP(i-3) = dUP(i-7);
    end
    
    dUP(1:4) = du(:,k);
    u(:, k)=u(:, k-1) + du(:, k);
   
end

for k=1:kk
    E1 = E1 + ((yzad(1,k) - y(1,k))^2);
    E2 = E2 + ((yzad(2,k) - y(2,k))^2);
    E3 = E3 + ((yzad(3,k) - y(3,k))^2);
end

E=E1+E2+E3;

end

