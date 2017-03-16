parametry ; 

% ---------- wyznaczenie odpowiedzi skokowej ----------- 

% odpowiedz skokowa
[s, u] = policz_odp_skok();

% ---------- wyznaczenie algorytmu DMC ----------
D = policzHorDynamiki(s) ;
N = D ;
Nu = D ;
lambda = 10 ;
U = zeros(Kk,1) ;
Yk = zeros(N, 1) ;

fi(1:N) = 1 ;
lambdaVec(1:Nu) = lambda;
macFi = diag(fi) ;
macLam = diag(lambdaVec) ;

 for i = D+1 : N + D + 1
     s(i) = s(D) ;
 end

U(1:11) = Upp ; % sterowanie dla obiektu w kolejnych chwilach
Yzad(1:N) = 1 ;
duPrze(1:D-1) = 0 ;
y(1:11) = Ypp ;

% wyznaczenie macierzy Mp
Mp=zeros(N,D-1) ;
for i = 1 : (D - 1)
    for j = 1 : N
        Mp(j,i) = s(i+j) - s(i) ;
    end
end

% wyznaczenie macierzy M
M=zeros(N,Nu) ;
for i = 1:N
    k=i;
    for j = 1:Nu
        M(i,j) = s(k) ;
        k=k-1;
        if i ==j
            break
        end
    end
end

% wyznaczene wektora K
K = (M' * M + macLam) \ M' ;

% ----------- glowna petla -----------
for i = 12 : Kk

    
    y(i) = symulacja_obiektu4Y(U(i-10), U(i-11), y(i-1), y(i-2)) - Ypp ;
    
    for j = 1 : N
        Yk(j) = y(i) ;
    end

    % --- obliczenie y0 ---

    Y0 = Yk + Mp * (duPrze)' ;

    % --- wyznaczenie optymalnego wektora przyszlych przyrostow ---
    dU = K * (Yzad' - Y0) ;
    
    % --- sprawdzenie, czy przyrost znajduje sie w ograniczeniach  ---
    if dU(1) > dU_max
        dU(1) = dU_max;
    elseif dU(1) < -dU_max
        dU(1) = -dU_max;
    end
    
    % --- wyznaczenie aktualnego sterowania ---
    U(i) = dU(1) + U(i-1) + Upp ;
    
    % --- sprawdzenie czy u znajduje sie w ograniczeniach ---
    if U(i) > U_max
        U(i) = U_max;
    elseif U(i) < U_min
        U(i) = U_min;
    end

    
    % --- zmiana wektora przeszlych sterowan ---
    for z = 1 : D-2
        duPrze(D-z) = duPrze(D-z-1) ;
    end
    duPrze(1) = dU(1) ;
    
end

    figure ;
    stairs(y) ;
    xlabel('k') ;
    ylabel('y') ;
    title(['Wyjscie obiektu z regulatorem DMC o parametrach N=Nu=D= ', num2str(N), ', lambda = ', num2str(lambda)]) ;
    
    figure ;
    stairs(U) ;
    xlabel('k') ;
    ylabel('u') ;
    title('Przebieg sterowania') ;
