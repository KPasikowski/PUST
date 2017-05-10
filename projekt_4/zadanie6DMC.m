parametry;

dirPathFigures = 'wykresy_figury/zad6';
dirPathTxt = 'wykresy_pliki/zad6';
subDirPathResponses = [dirPathTxt '/odpowiedzi'];
mkDirectory(dirPathFigures);
mkDirectory(dirPathTxt);
mkDirectory(subDirPathResponses);

% ----- odpowiedzi skokowe -----
u1 = [-1 0.75 -0.6 -0.6 -0.4 -0.70 -0.4 -0.26];
u2 = [-0.75 1 -0.23 -0.4 -0.23 -0.4 -0.26 -0.09];
ys = [-3.403 0.0813 -1.444  -1.444 -0.7051 -1.885 -0.7051 -0.3355];

for i = 1 : 8
    u(1 : 6) = u1(i);
    u(7 : Kk) = u2(i);
    y = zeros(Kk, 1) + ys(i);
    
    for k = 7 : Kk
           y(k) = symulacja_obiektu6y(u(k - 5), u(k - 6), y(k - 1), y(k - 2));
    end
    
    y = (y(7 : length(y)) - y(6)) / (abs(u1(i) - u2(i)));
    y(length(y) : 400) = y(length(y));
    
    zapiszDoPliku([subDirPathResponses '/wyjscie_skok_'  num2str(u1(i)) '_' num2str(u2(i)) '.txt'], y);
     
end
% ------------------------------

D = 200;
N = D;
Nu = D;
lambdas = [20 0.7 0 0 0 ; 20 10 0.7 0 0 ; 20 16 9 0.7 0 ; 20 16 10 5 0.7];
% lambdas = [10 10 0 0 0 ; 10 10 10 0 0 ; 10 10 10 10 0 ; 10 10 10 10 10];
d = [7 0 0 0 ; 7 12 0 0 ; 7 9 10 0; 7 8 8 12];
c = [-0.6 0 0 0 ; -0.6 -0.2 0 0 ; -0.6 -0.9 -0.1 0 ; -1 -0.2 -0.1 -0.1];
Es = zeros(1, 4);

for i = 1 : 4
    
    [y, u, E, yzad] = policzDMCzad6(D, N, Nu, lambdas(i, 1 : i+1), d(i, 1 : i), c(i, 1 : i), Kk);
    
    zapiszDoPliku([dirPathTxt '/wyjscie_lr_'  num2str(i+1) '.txt'], y);
    zapiszDoPliku([dirPathTxt '/sterowanie_lr_'  num2str(i+1) '.txt'], u);
    
    figure;
    subplot(2,1,1);
    rysujWykres((1 : length(y)), y, -1, 'k', 'y', '', ['Wyjscie y obiektu, liczba regulatorow ' num2str(i+1)]);
    hold on
    rysujWykres((1 : length(yzad)), yzad, -1, 'k', 'y', '', ['Wyjscie y obiektu, liczba regulatorow ' num2str(i+1)]);

    subplot(2,1,2);
    rysujWykres((1 : length(u)), u, -1, 'k', 'u', '', 'Sterowanie u');
    
    savefig([dirPathFigures '/sterowanie_wyjscie_PID_lr_' num2str(i+1) '.fig']);
    
    Es(i) = E;
    E

end

zapiszDoPliku([dirPathTxt '/wartosc_zadana.txt'], yzad);
zapiszDoPliku([dirPathTxt '/bledy.txt'], Es);