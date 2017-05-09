
addpath('F:\SerialCommunication');
initSerialControl COM14

Upp = 29;
Ypp = 32.5;
Kk = 800;
U_min = 0;
U_max = 100;

% nastawy regulatora PID
% Kp = 3 ;
% Ti = 10 ;
% Td = 3.2 ;
Kp = 6;%5.94 ;
Ti = 65;%5.64 ;
Td = 1.25;%3.16 ;
Tp = 1;

r2 = (Kp * Td) / Tp ;
r1 = Kp * ( (Tp/(2*Ti)) - 2*(Td/Tp) - 1 ) ;
r0 = Kp * ( 1 + Tp/(2*Ti) + Td/Tp ) ;

% warunki poczatkowe
u(1:31) = Upp ;
U(1:31) = Upp ;
y(1:31) = Ypp ;
y2(1:31) = Ypp ;
e(1:31) = 0 ;
delta_u = 0;
index = 1;
yzads = [52, 30];
yzad = yzads(index);   %skok wartosci zadanej
yzad2 = yzad - Ypp;
yzadVec(1:800) = yzad;
sendControls (1,W1);

figure;
% glowna petla symulacji
for k = 32 : 800
    if mod(k,400) == 0
        index = index + 1;
        if index > length(yzads)
            index = length(yzads);
        end
        yzad = yzads(index);
        yzad2 = yzad - Ypp;
    end
    yzadVec(k) = yzad;
    
    y(k) = readMeasurements(1);
    
    y2(k) = y(k) - Ypp;
    e(k) = yzad2 - y2(k) ;
    
    u(k) = r2 * e(k-2) + r1 * e(k-1) + r0 * e(k) + u(k-1) ;
    
    delta_u = u(k) - u(k-1);
    
    %if delta_u > dU_max
    %    delta_u = dU_max;
    %elseif delta_u < -dU_max
    %    delta_u = -dU_max;
    %end
    
    u(k) = u(k-1) + delta_u;
    
    if u(k) > U_max - Upp
        u(k) = U_max - Upp;
    elseif u(k) < U_min - Upp
        u(k) = U_min - Upp;
    end
    
     U(k) = u(k) + Upp;
     sendNonlinearControls(U(k));
     
     stairs(y);
     pause(0.01);

     waitForNewIteration();
end

E = (yzadVec - y)*(yzadVec - y)';

fileTitle = ['zad5_pid_y.txt'];
filename = fopen(fileTitle,'w');
for i=1:800
    fprintf(filename,'%5d ',i);
    fprintf(filename,'%5d\n',y(i));
end
fclose(filename);

fileTitle = ['zad5_pid_u.txt'];
filename = fopen(fileTitle,'w');
for i=1:800
    fprintf(filename,'%5d ',i);
    fprintf(filename,'%5d\n',U(i));
end
fclose(filename);
