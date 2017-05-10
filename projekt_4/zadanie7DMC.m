parametry;

dirPathFigures = 'wykresy_figury/zad7';
dirPathTxt = 'wykresy_pliki/zad7';
mkDirectory(dirPathFigures);
mkDirectory(dirPathTxt);

D = 200;
N = D;
Nu = D;
lambdas = [18 0.9 0 0 0 ; 18 12 0.9 0 0 ; 17 16 9 1 0 ; 16 16 10 5 1.5];
d = [7 0 0 0 ; 7 12 0 0 ; 7 9 10 0; 7 8 8 12];
c = [-0.6 0 0 0 ; -0.6 -0.2 0 0 ; -0.6 -0.9 -0.1 0 ; -1 -0.2 -0.1 -0.1];
Es = zeros(1, 4);

for i = 1 : 4
    
    [y, u, E, yzad] = policzDMCzad6(D, N, Nu, lambdas(i, 1 : i+1), d(i, 1 : i), c(i, 1 : i), Kk);
    
    txtToSave = '_lambdas_';
    for k = 1 : i + 1
        txtToSave = [txtToSave num2str(lambdas(i, k)) '_'];
    end
    
    zapiszDoPliku([dirPathTxt '/wyjscie_lr_'  num2str(i+1) txtToSave '.txt'], y);
    zapiszDoPliku([dirPathTxt '/sterowanie_lr_'  num2str(i+1) txtToSave '.txt'], u);
    
    figure;
    subplot(2,1,1);
    rysujWykres((1 : length(y)), y, -1, 'k', 'y', '', 'Wyjscie y obiektu');
    hold on
    rysujWykres((1 : length(yzad)), yzad, -1, 'k', 'y', '', 'Wyjscie y obiektu');

    subplot(2,1,2);
    rysujWykres((1 : length(u)), u, -1, 'k', 'u', '', 'Sterowanie u');
    
    savefig([dirPathFigures '/sterowanie_wyjscie_PID_lr_' num2str(+1) '.fig']);
    
    Es(i) = E;
    E

end

zapiszDoPliku([dirPathTxt '/wartosc_zadana.txt'], yzad);
zapiszDoPliku([dirPathTxt '/bledy.txt'], Es);
