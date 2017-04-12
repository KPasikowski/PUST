addpath ('F:\SerialCommunication'); % add a path
initSerialControl COM14 % initialise com port
N = 200;
Nu = 50;
D=200;
kk=250;
lambda = 2;
Upp1 = 29;
Upp2 = 34;
U_max = 100;
U_min = 0;

Sapru1y1 = load('Sapr_T1_G1');
Sapru2y1 = load('Sapr_T1_G2');
Sapru1y2 = load('Sapr_T2_G1');
Sapru2y2 = load('Sapr_T2_G2');
s11=Sapru1y1.Sapr;
s12=Sapru2y1.Sapr;
s21=Sapru1y2.Sapr;
s22=Sapru2y2.Sapr;


ny=2;
nu=2;
y=zeros(ny,kk);
yzad=zeros(ny,kk);
yzad(1,1:kk)=40;
yzad(2,1:kk)=37;
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
figure;
for k=2:kk
    
    y(1,k) = readMeasurements(1);
    y(2,k) = readMeasurements(2);
    du(:,k)=[ke1 ke2;ke3 ke4]*(yzad(:,k)-y(:,k))-ku*cell2mat(dUP);
    for i=D-1:-1:2
      dUP(i)=dUP(i-1);
    end
   dUP(1)={du(:,k)};
   u(:,k)=u(:,k-1)+du(:,k);
   if u(1,k) > U_max - Upp1
        u(1,k) = U_max - Upp1;
   elseif u(1,k) < U_min - Upp1
        u(1,k) = U_min - Upp1;
   end
   if u(2,k) > U_max - Upp2
        u(2,k) = U_max - Upp2;
   elseif u(2,k) < U_min - Upp2
        u(2,k) = U_min - Upp2;
   end

   sendControls ([1,2,5,6],[50, 50, u(1,k) + Upp1, u(2,k) + Upp2]);
   
   plot(y(1,:)); hold on;
   plot(y(2,:)); hold off;
   pause(0.01);

   waitForNewIteration();
end

E1=0;
E2=0;
for k=1:kk
    E1=E1+((yzad(1,k)-y(1,k))^2);
    E2=E2+((yzad(2,k)-y(2,k))^2);
end
E=E1+E2;

