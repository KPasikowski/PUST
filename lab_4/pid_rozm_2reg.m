W1 = 50;
G1 = 29;
T1 = 34;
Kk = 800;

Umin = 0;
Umax = 100;

Yzad(1:10) = T1;
Yzad(11:300) = 37;
Yzad(301:600) = 39;
Yzad(601:Kk) = 36;

Tp = 1;

K1 = 8;
Ti1 = 50;
Td1 = 0.8;

r21 = K1*Td1/Tp;
r11 = K1*(Tp/(2*Ti1) - 2*Td1/Tp - 1);
r01 = K1*(1 + Tp/(2*Ti1) + Td1/Tp);

K2 = 25;
Ti2 = 40;
Td2 = 1.1;

r22 = K2*Td2/Tp;
r12 = K2*(Tp/(2*Ti2) - 2*Td2/Tp - 1);
r02 = K2*(1 + Tp/(2*Ti2) + Td2/Tp);

Y = ones(1,Kk)*T1;
y = zeros(1,Kk);
yzad = zeros(1,Kk);
U = zeros(1,Kk);


addpath ('F:\SerialCommunication'); % add a path
initSerialControl COM14 % initialise com port

figure;
for i = 1:Kk
    pomiary = readMeasurements(1) ;
    
    Y(i) = pomiary;
    
    y(i) = Y(i) - T1;
    yzad(i) = Yzad(i) - T1;
    e(i) = yzad(i) - y(i);
    
    if i == 1
        du_1 = r01*e(i);
        du_2 = r02*e(i);
    end
    if i == 2
        du_1 = r11*e(i-1)+r01*e(i);
        du_2 = r12*e(i-1)+r02*e(i);
    end
    if i > 2
        du_1 = r21*e(i-2)+r11*e(i-1)+r01*e(i);
        du_2 = r22*e(i-2)+r12*e(i-1)+r02*e(i);
    end
    
    if i == 1
        u_1 = G1+du_1;
        u_2 = G1+du_2;
    else
        u_1 = du_1 + U(i-1);
        u_2 = du_2 + U(i-1);
    end
    
    if i<=11
        u_mf = G1;
    else
        u_mf = U(i-10);
    end
    if u_mf<=46
        U(i) = u_1;
    end
    if u_mf>46 && u_mf<54
        par1 = [-1.5 50];
        par2 = [1.5 50];
        mi_1 = fprzynaleznosci(u_mf,par1);
        mi_2 = fprzynaleznosci(u_mf,par2);
        U(i) = (u_1*mi_1 +u_2*mi_2)/(mi_1+mi_2);
    end
    if u_mf>=54
        U(i) = u_2;
    end    
    
    if U(i)>100
        U(i)=100;
    end
    if U(i)<0
        U(i)=0;
    end
    sendNonlinearControls (U(i));
    
    stairs(Y);
    pause(0.01);
    
    waitForNewIteration();
end

fileTitle = ['pidrozm_y_1_',num2str(K1), '_', num2str(Ti1),'_',num2str(Td1),'2_',num2str(K2),'_',num2str(Ti2),'_',num2str(Td2),'_zad6.txt'];
fileName = fopen(fileTitle,'w');
for i=1:Kk
    fprintf(fileName,'%5d ',i);
    fprintf(fileName,'%5d\n',Y(i));
end
fclose(fileName);

fileTitle = ['pidrozm_u_1_',num2str(K1), '_', num2str(Ti1),'_',num2str(Td1),'2_',num2str(K2),'_',num2str(Ti2),'_',num2str(Td2),'_zad6.txt'];
fileName = fopen(fileTitle,'w');
for i=1:Kk
    fprintf(fileName,'%5d ',i);
    fprintf(fileName,'%5d\n',U(i));
end
fclose(fileName);
