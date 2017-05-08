function [ y, u, E, yzadVec] = policzPIDzad5(Kp_, Ti_, Td_, d_, c_, Kk_)
U_min = -1;
U_max = 1;

Kp = Kp_;
Ti = Ti_;
Td = Td_;

Kk = Kk_;
Tp = 0.5;

d = d_;
c = c_;

numOfControllers = size(Kp, 2);

% warunki poczatkowe
u(1:Kk) = 0 ;
y(1:Kk) = 0 ;
e(1:Kk) = 0 ;
index = 1;
yzads = [-1 -2.5 -1 0.08];
yzad = yzads(index);
yzadVec(1:Kk) = yzad;

r0 = zeros(1,numOfControllers);
r1 = zeros(1,numOfControllers);
r2 = zeros(1,numOfControllers);

mi = zeros(1, numOfControllers);
u_n = zeros(1, numOfControllers);

for i = 1 : numOfControllers
    r0(i) = Kp(i) * ( 1 + Tp/(2*Ti(i)) + Td(i)/Tp ) ;
    r1(i) = Kp(i) * ( (Tp/(2*Ti(i))) - 2*(Td(i)/Tp) - 1 ) ;
    r2(i) = (Kp(i) * Td(i)) / Tp ;
end

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
    
    for i = 1 : numOfControllers
        u_n(i) = r2(i) * e(k-2) + r1(i) * e(k-1) + r0(i) * e(k) + u(k-1) ;
    end
    
    if numOfControllers == 2
       mi(1) = 1 - 1 / (1 + exp(-d(1) * (y(k) - c(1))));
       mi(2) = 1 / (1 + exp(-d(1) * (y(k) - c(1))));
%        if(yzad == yzads(4))
%        disp('y = ');
%        disp(y(k));    
%        disp('m1 = ');
%        disp(mi(1));
%        disp('m2 = ');
%        disp(mi(2));
%        end
    elseif numOfControllers == 3
       mi(1) = 1 - 1 / (1 + exp(-d(1) * (y(k) - c(1))));
       mi(2) = 1 / (1 + exp(-d(1) * (y(k) - c(1)))) - 1 / (1 + exp(-d(2) * (y(k) - c(2))));
       mi(3) = 1 / (1 + exp(-d(2) * (y(k) - c(2))));
    elseif numOfControllers == 4
       mi(1) = 1 - 1 / (1 + exp(-d(1) * (y(k) - c(1))));
       mi(2) = 1 / (1 + exp(-d(1) * (y(k) - c(1)))) - 1 / (1 + exp(-d(2) * (y(k) - c(2))));
       mi(2) = 1 / (1 + exp(-d(2) * (y(k) - c(2)))) - 1 / (1 + exp(-d(3) * (y(k) - c(3))));
       mi(4) = 1 / (1 + exp(-d(3) * (y(k) - c(3))));
    elseif numOfControllers == 5
       mi(1) = 1 - 1 / (1 + exp(-d(1) * (y(k) - c(1))));
       mi(2) = 1 / (1 + exp(-d(1) * (y(k) - c(1)))) - 1 / (1 + exp(-d(2) * (y(k) - c(2))));
       mi(3) = 1 / (1 + exp(-d(2) * (y(k) - c(2)))) - 1 / (1 + exp(-d(3) * (y(k) - c(3))));
       mi(4) = 1 / (1 + exp(-d(3) * (y(k) - c(3)))) - 1 / (1 + exp(-d(4) * (y(k) - c(4))));
       mi(5) = 1 / (1 + exp(-d(4) * (y(k) - c(4))));
    end
    
    u(k) = sum(u_n * mi') / sum(mi);
    
    if u(k) > U_max
       u(k) = U_max;
    elseif u(k) < U_min
       u(k) = U_min;
    end
    
end

E = (yzadVec - y) * (yzadVec - y)';

end

