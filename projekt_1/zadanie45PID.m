parametry ;

% nastawy regulatora PID
% Kp = 3 ;
% Ti = 10 ;
% Td = 3.2 ;
Kp = 3 ;
Ti = Inf ;
Td = 0 ;

r2 = (Kp * Td) / Tp ;
r1 = Kp * ( (Tp/(2*Ti)) - 2*(Td/Tp) - 1 ) ;
r0 = Kp * ( 1 + Tp/(2*Ti) + Td/Tp ) ;

% warunki poczatkowe
u(1:11) = Upp ;
U(1:11) = Upp ;
y(1:11) = Ypp ;
y2(1:11) = Ypp ;
e(1:11) = 0 ;
delta_u = 0;
index = 1;
yzads = [1.05 0.8 1.1 0.9];
yzad = yzads(index);   %skok wartosci zadanej
yzad2 = yzad - Ypp;
yzadVec(1:Kk) = yzad;

% glowna petla symulacji
for k = 12 : Kk
    if mod(k,400) == 0
        index = index + 1;
        if index > length(yzads)
            index = length(yzads);
        end
        yzad = yzads(index);
        yzad2 = yzad - Ypp;
    end
    yzadVec(k) = yzad;
    
    y(k) = symulacja_obiektu4Y(U(k-10), U(k-11), y(k-1), y(k-2)) ;
    
    y2(k) = y(k) - Ypp;
    e(k) = yzad2 - y2(k) ;
    
    u(k) = r2 * e(k-2) + r1 * e(k-1) + r0 * e(k) + u(k-1) ;
    
    delta_u = u(k) - u(k-1);
    
    if delta_u > dU_max
        delta_u = dU_max;
    elseif delta_u < -dU_max
        delta_u = -dU_max;
    end
    
    u(k) = u(k-1) + delta_u;
    
    if u(k) > U_max - Upp
        u(k) = U_max - Upp;
    elseif u(k) < U_min - Upp
        u(k) = U_min - Upp;
    end
    
     U(k) = u(k) + Upp;
end

E = (yzadVec - y)*(yzadVec - y)'

%wykresy
figure ;
subplot(2,1,1)
stairs(y) ; hold on ; stairs(yzadVec, '--') ;
xlabel('k') ;
ylabel('y') ;
title_ = ['y, yzad - regulator PID. Parametry : Kp = ', num2str(Kp), ' Ti = ', num2str(Ti), ' Td = ', num2str(Td)];
title_ = [title_ sprintf('\n') 'E = ' num2str(E)];
title(title_);

subplot(2,1,2)
stairs(U) ;
xlabel('k') ;
ylabel('u') ;
title('u') ;
