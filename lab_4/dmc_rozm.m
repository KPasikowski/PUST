ilosc_regulatorow = 2;

W1 = 50;
G1 = 29;
T1 = 34;
Kk = 800;

umin = 0;
umax = 100;

Yzad(1:10) = T1;
Yzad(11:300) = 37;
Yzad(301:600) = 39;
Yzad(601:Kk) = 36;

if ilosc_regulatorow == 2
    dmcrozm_2;
    par1 = [-1.5 50];
    par2 = [1.5 50];
end

Y = ones(1,Kk)*T1;
y = zeros(1,Kk);
yzad = zeros(1,Kk);
U = zeros(1,Kk);
u = zeros(1,Kk);
dupop = zeros(D-1,1);

addpath ('F:\SerialCommunication'); % add a path
initSerialControl COM14 % initialise com port

figure;
for i = 1:Kk
    pomiary = readMeasurements(1) ;
    
    Y(i) = pomiary;
    
    y(i) = Y(i) - T1;
    yzad(i) = Yzad(i) - T1;
    
    if i<=8
        u_mf = G1;
    else
        u_mf = U(i-8);
    end

    if ilosc_regulatorow == 2
        if(u_mf <= 46)
            du = ke1*(yzad(i)-y(i)) - ku1*dupop;
        end
        if(u_mf > 46 && u_mf < 54)
            du = (fprzynaleznosci(u_mf,par1)*(ke1*(yzad(i)-y(i)) - ku1*dupop)+...
                fprzynaleznosci(u_mf,par2)*(ke2*(yzad(i)-y(i)) - ku2*dupop))/(fprzynaleznosci(u_mf,par1)+fprzynaleznosci(u_mf,par2));
        end
        if(u_mf >= 54)
            du = ke2*(yzad(i)-y(i)) - ku2*dupop;
        end
    end
    
    if i == 1
        u(i) = du;
    else
        u(i) = u(i-1) + du;
    end
    
    U(i) = u(i) + G1;
    
    if U(i) > umax
        U(i) = umax;
    end
    if U(i) < umin
        U(i) = umin;
    end
    
    for n=D-1:-1:2
        dupop(n) = dupop(n-1);
    end
    if i==1
        dupop(1) = du;
    end
    if i>1
        dupop(1) = U(i)-U(i-1);
    end
    
    sendNonlinearControls (U(i));
    
    stairs(Y);
    pause(0.01);
    
    waitForNewIteration()
end

E = sum((Yzad-Y).^2);

fileTitle = ['dmcrozm_y_',num2str(lambda),'_',num2str(ilosc_regulatorow),'_zad7.txt'];
fileName = fopen(fileTitle,'w');
for i=1:Kk
    fprintf(fileName,'%5d ',i);
    fprintf(fileName,'%5d\n',Y(i));
end
fclose(fileName);

fileTitle = ['dmcrozm_u_',num2str(lambda),'_',num2str(ilosc_regulatorow),'_zad7.txt'];
fileName = fopen(fileTitle,'w');
for i=1:Kk
    fprintf(fileName,'%5d ',i);
    fprintf(fileName,'%5d\n',U(i));
end
fclose(fileName);
