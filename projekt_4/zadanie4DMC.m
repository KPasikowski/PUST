parametry;

dirPathFigures = 'wykresy_figury/zad4';
dirPathTxt = 'wykresy_pliki/zad4';
subDirPathDMC = [dirPathTxt '/DMC'];
mkDirectory(subDirPathDMC);

D = 200;
N = D;
Nu = D;
lambdas = [20];
Es = zeros(1, length(lambdas));


figure;
for i = 1 : length(lambdas)
    
    lambda = lambdas(i);
    [y, u, E, yzad] = policzDMC(D, N, Nu, lambda, Kk);
    
    zapiszDoPliku([subDirPathDMC '/wyjscie_lambda_'  num2str(lambdas(i)) '.txt'], y);
    zapiszDoPliku([subDirPathDMC '/sterowanie_lambda_'  num2str(lambdas(i)) '.txt'], u);
    
    subplot(2,1,1);
    rysujWykres((1 : length(y)), y, -1, 'k', 'y', '', 'Wyjscie y obiektu');
    hold on
    rysujWykres((1 : length(yzad)), yzad, -1, 'k', 'y', '', 'Wyjscie y obiektu');
    hold on

    subplot(2,1,2);
    rysujWykres((1 : length(u)), u, -1, 'k', 'u', '', 'Sterowanie u');
    hold on
    
    Es(i) = E;

end

zapiszDoPliku([subDirPathDMC '/wartosc_zadana_lambda_'  num2str(lambdas(i)) '.txt'], yzad);

savefig([dirPathFigures '/sterowanie_wyjscie.fig']);
zapiszDoPliku([subDirPathDMC '/bledy.txt'], Es);