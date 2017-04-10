function [ y, u, E, yzad ] = policzPID( Kp1_, Ti1_, Td1_, Kp2_, Ti2_, Td2_, Kk_, config)
Kp1 = Kp1_;
Ti1 = Ti1_;
Td1 = Td1_;
Kp2 = Kp2_;
Ti2 = Ti2_;
Td2 = Td2_;

Kk = Kk_;
Tp = 0.5;

r2_1 = (Kp1 * Td1) / Tp ;
r1_1 = Kp1 * ( (Tp/(2*Ti1)) - 2*(Td1/Tp) - 1 ) ;
r0_1 = Kp1 * ( 1 + Tp/(2*Ti1) + Td1/Tp ) ;

r2_2 = (Kp2 * Td2) / Tp ;
r1_2 = Kp2 * ( (Tp/(2*Ti2)) - 2*(Td2/Tp) - 1 ) ;
r0_2 = Kp2 * ( 1 + Tp/(2*Ti2) + Td2/Tp ) ;

% warunki poczatkowe
u1(1:11) = 0 ;
y1(1:11) = 0 ;
e1(1:11) = 0 ;
u2(1:11) = 0 ;
y2(1:11) = 0 ;
e2(1:11) = 0 ;
index1 = 1;
index2 = 1;
yzads1 = [1.05 0.8 1.1 0.9];
yzads2 = [0.9 0.8 1.1 1];
yzad1 = yzads1(index1);
yzad2 = yzads2(index2);
yzadVec1(1:Kk) = yzad1;
yzadVec2(1:Kk) = yzad2;

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
    y1(k)=symulacja_obiektu6y1(u1(k-6),u1(k-7),u2(k-3),u2(k-4),y1(k-1),y1(k-2));
    y2(k)=symulacja_obiektu6y2(u1(k-5),u1(k-6),u2(k-6),u2(k-7),y2(k-1),y2(k-2));
    e1(k) = yzad1 - y1(k) ;
    e2(k) = yzad2 - y2(k) ;  
    
    if config == 1
        u1(k) = r2_1 * e1(k-2) + r1_1 * e1(k-1) + r0_1 * e1(k) + u1(k-1) ;
        u2(k) = r2_2 * e2(k-2) + r1_2 * e2(k-1) + r0_2 * e2(k) + u2(k-1) ;
    else
        u1(k) = r2_1 * e2(k-2) + r1_1 * e2(k-1) + r0_1 * e2(k) + u1(k-1) ;
        u2(k) = r2_2 * e1(k-2) + r1_2 * e1(k-1) + r0_2 * e1(k) + u2(k-1) ;
    end

end

E1 = (yzadVec1 - y1)*(yzadVec1 - y1)';
E2 = (yzadVec2 - y2)*(yzadVec2 - y2)';
E = E1 + E2;

yzad = zeros(2, Kk);
yzad(1, :) = yzadVec1;
yzad(2, :) = yzadVec2;

y = zeros(2, Kk);
y(1, :) = y1;
y(2, :) = y2;

u = zeros(2, Kk);
u(1, :) = u1;
u(2, :) = u2;

end

