function [ y, u, E, yzad ] = policzPID( Kp1_, Ti1_, Td1_, Kp2_, Ti2_, Td2_, Kp3_, Ti3_, Td3_, Kk_)
Kp1 = Kp1_;
Ti1 = Ti1_;
Td1 = Td1_;
Kp2 = Kp2_;
Ti2 = Ti2_;
Td2 = Td2_;
Kp3 = Kp3_;
Ti3 = Ti3_;
Td3 = Td3_;

Kk = Kk_;
Tp = 0.5;

r2_1 = (Kp1 * Td1) / Tp ;
r1_1 = Kp1 * ( (Tp/(2*Ti1)) - 2*(Td1/Tp) - 1 ) ;
r0_1 = Kp1 * ( 1 + Tp/(2*Ti1) + Td1/Tp ) ;

r2_2 = (Kp2 * Td2) / Tp ;
r1_2 = Kp2 * ( (Tp/(2*Ti2)) - 2*(Td2/Tp) - 1 ) ;
r0_2 = Kp2 * ( 1 + Tp/(2*Ti2) + Td2/Tp ) ;

r2_3 = (Kp3 * Td3) / Tp ;
r1_3 = Kp3 * ( (Tp/(2*Ti3)) - 2*(Td3/Tp) - 1 ) ;
r0_3 = Kp3 * ( 1 + Tp/(2*Ti3) + Td3/Tp ) ;

% warunki poczatkowe

u1(1:11) = 0 ;
y1(1:11) = 0 ;
e1(1:11) = 0 ;
u2(1:11) = 0 ;
y2(1:11) = 0 ;
e2(1:11) = 0 ;
u4(1:11) = 0 ;
y3(1:11) = 0 ;
e3(1:11) = 0 ;

u3(1:Kk) = 0 ; % ma najmniejsze wzmocnienie



index1 = 1;
index2 = 1;
index3 = 1;


yzads1 = [0.9 0.9 0.9 0.9];
yzads2 = [0.9 0.9 0.9 0.9];    
yzads3 = [0.9 0.9 0.9 0.9];    

yzad1 = yzads1(index1);
yzad2 = yzads2(index2);
yzad3 = yzads3(index3);
yzadVec1(1:Kk) = yzad1;
yzadVec2(1:Kk) = yzad2;
yzadVec3(1:Kk) = yzad3;

% glowna petla symulacji
for k = 12 : Kk
    if mod(k,200) == 0
        index1 = index1 + 1;
        if index1 > length(yzads1)
            index1 = length(yzads1);
        end
        yzad1 = yzads1(index1);
    end
    yzadVec1(k) = yzad1;
    
    if mod(k,120) == 0
        index2 = index2 + 1;
        if index2 > length(yzads2)
            index2 = length(yzads2);
        end
        yzad2 = yzads2(index2);
    end
    yzadVec2(k) = yzad2;
    
    if mod(k,220) == 0
        index3 = index3 + 1;
        if index3 > length(yzads3)
            index3 = length(yzads3);
        end
        yzad3 = yzads3(index3);
    end
    yzadVec3(k) = yzad3;
    
    [y1(k), y2(k), y3(k)] = symulacja_obiektu6( ...
            u1(k-1), u1(k-2), u1(k-3), u1(k-4), ...
            u2(k-1), u2(k-2), u2(k-3), u2(k-4), ...
            u3(k-1), u3(k-2), u3(k-3), u3(k-4), ...
            u4(k-1), u4(k-2), u4(k-3), u4(k-4), ...
            y1(k-1), y1(k-2), y1(k-3), y1(k-4), ...
            y2(k-1), y2(k-2), y2(k-3), y2(k-4), ...
            y3(k-1), y3(k-2), y3(k-3), y3(k-4));

    
    e1(k) = yzad1 - y1(k) ;
    e2(k) = yzad2 - y2(k) ;
    e3(k) = yzad3 - y3(k) ;
    
    u1(k) = r2_1 * e1(k-2) + r1_1 * e1(k-1) + r0_1 * e1(k) + u1(k-1) ;
    u2(k) = r2_2 * e2(k-2) + r1_2 * e2(k-1) + r0_2 * e2(k) + u2(k-1) ;
    u4(k) = r2_3 * e3(k-2) + r1_3 * e3(k-1) + r0_3 * e3(k) + u4(k-1) ;
    
end

E1 = (yzadVec1 - y1) * (yzadVec1 - y1)';
E2 = (yzadVec2 - y2) * (yzadVec2 - y2)';
E3 = (yzadVec3 - y3) * (yzadVec3 - y3)';
E = E1 + E2 + E3;

yzad = zeros(3, Kk);
yzad(1, :) = yzadVec1;
yzad(2, :) = yzadVec2;
yzad(3, :) = yzadVec3;

y = zeros(3, Kk);
y(1, :) = y1;
y(2, :) = y2;
y(3, :) = y3;

u = zeros(3, Kk);
u(1, :) = u1;
u(2, :) = u2;
u(3, :) = u4;

end

