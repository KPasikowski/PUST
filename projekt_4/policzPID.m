function [ y, u, E, yzad ] = policzPID( Kp_, Ti_, Td_, Kk_)
U_min = -1;
U_max = 1;

Kp = Kp_;
Ti = Ti_;
Td = Td_;

Kk = Kk_;
Tp = 0.5;

r2 = (Kp * Td) / Tp ;
r1 = Kp * ( (Tp/(2*Ti)) - 2*(Td/Tp) - 1 ) ;
r0 = Kp * ( 1 + Tp/(2*Ti) + Td/Tp ) ;

% warunki poczatkowe
% u(1:11) = 0 ;
% y(1:11) = 0 ;
% e(1:11) = 0 ;
% index = 1;
% yzads = [-1 -2.5 -1 0.06];
% yzad = yzads(index);
% yzadVec(1:Kk) = yzad;
u(1:11) = 0.34 ;
y(1:11) = 0.073 ;
e(1:11) = 0 ;
index = 1;
yzads = [0.084];
yzad = yzads(index);
yzadVec(1:Kk) = yzad;


% glowna petla symulacji
for k = 7 : Kk
    if mod(k,200) == 0
        index = index + 1;
        if index > length(yzads)
            index = length(yzads);
        end
        yzad = yzads(index);
    end
    yzadVec(k) = yzad;

    y(k) = symulacja_obiektu6y(u(k-5), u(k-6), y(k-1), y(k-2));

    e(k) = yzad - y(k) ;
    
    u(k) = r2 * e(k-2) + r1 * e(k-1) + r0 * e(k) + u(k-1) ;
    
    if u(k) > U_max
       u(k) = U_max;
    elseif u(k) < U_min
       u(k) = U_min;
    end


end

E = (yzadVec - y) * (yzadVec - y)';

yzad = zeros(1, Kk);
yzad(1, :) = yzadVec;

end

