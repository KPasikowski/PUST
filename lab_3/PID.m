
addpath('F:\SerialCommunication');
initSerialControl COM14

yzads = [40, 37];
Upp1 = 29;
Ypp1 = 36.5;
Upp2 = 34;
Ypp2 = 38.5;
Kk = 500;
U_min = 0;
U_max = 100;

% nastawy regulatora PID
% Kp = 3 ;
% Ti = 10 ;
% Td = 3.2 ;
Kp1 = 3;%5.94 ;
Ti1 = 25;%5.64 ;
Td1 = 0.7;%3.16 ;
Tp = 1;

Kp2 = 5;%5.94 ;
Ti2= 50;%5.64 ;
Td2= 0;%3.16 ;
Tp2= 1;

r2_1 = (Kp1 * Td1) / Tp ;
r1_1 = Kp1 * ( (Tp/(2*Ti1)) - 2*(Td1/Tp) - 1 ) ;
r0_1 = Kp1 * ( 1 + Tp/(2*Ti1) + Td1/Tp ) ;

r2_2 = (Kp2 * Td2) / Tp ;
r1_2 = Kp2 * ( (Tp/(2*Ti2)) - 2*(Td2/Tp) - 1 ) ;
r0_2 = Kp2 * ( 1 + Tp/(2*Ti2) + Td2/Tp ) ;

% warunki poczatkowe
u1(1:31) = Upp1 ;
U1(1:31) = Upp1 ;
y1(1:31) = Ypp1 ;
y2_1(1:31) = Ypp1 ;
e1(1:31) = 0 ;
delta_u1 = 0;
u2(1:31) = Upp2 ;
U2(1:31) = Upp2 ;
y2(1:31) = Ypp2 ;
y2_2(1:31) = Ypp2 ;
e2(1:31) = 0 ;
delta_u2 = 0;

index = 1;

yzad = yzads(1);   %skok wartosci zadanej
yzad2 = yzads(2);
yzadVec(1:30) = Ypp1;
yzadVec2(1:30) = Ypp2;
yzadVec(31:Kk) = yzad;
yzadVec2(31:Kk) = yzad2;

figure;
% glowna petla symulacji
for k = 3 : Kk
    
    tmp = readMeasurements([1,2]);
    y1(k) = tmp(1);
    y2(k) = tmp(2);
    
    e1(k) = yzadVec(k) - y1(k) ;
    e1(k);
    e2(k) = yzadVec2(k) - y2(k) ;
    

% regulator dla T1
    u1(k) = r2_1 * e1(k-2) + r1_1 * e1(k-1) + r0_1 * e1(k) + u1(k-1);
    
    if u1(k) > U_max - Upp1
        u1(k) = U_max - Upp1;
    elseif u1(k) < U_min - Upp1
        u1(k) = U_min - Upp1;
    end
    
     U1(k) = u1(k) + Upp1;

% regulator dla T2
    u2(k) = r2_2 * e2(k-2) + r1_2 * e2(k-1) + r0_2 * e2(k) + u2(k-1) ;
    
    if u2(k) > U_max - Upp2
        u2(k) = U_max - Upp2;
    elseif u2(k) < U_min - Upp2
        u2(k) = U_min - Upp2;
    end
    
     U2(k) = u2(k) + Upp2;



     sendControls([ 1,2,5,6], [ 50, 50, U1(k), U2(k)]);
     
     
     plot(y1); hold on;
     plot(y2); hold off;
     pause(0.01);

     waitForNewIteration();
end

E1 = (yzadVec - y1)*(yzadVec - y1)';
E2 = (yzadVec2 - y2)*(yzadVec2 - y2)';
E = E1+E2;

% fileTitle = ['zad5_odpskok_y_2.txt'];
% filename = fopen(fileTitle,'w');
% for i=1:800
%     fprintf(filename,'%5d ',i);
%     fprintf(filename,'%5d\n',y(i));
% end
% fclose(filename);
% 
% fileTitle = ['zad5_odpskok_u_2.txt'];
% filename = fopen(fileTitle,'w');
% for i=1:800
%     fprintf(filename,'%5d ',i);
%     fprintf(filename,'%5d\n',U(i));
% end
% fclose(filename);
