parametry;

dirPathFigures = 'wykresy_figury/zad4';
dirPathTxt = 'wykresy_pliki/zad4';
mkDirectory(dirPathFigures);
mkDirectory(dirPathTxt);

z(1 : Kk) = 0;
D = 200;
N = D;
Nu = D;
lambdas = [1 10 50];
Es = zeros(1, length(lambdas));


figure;
for i = 1 : length(lambdas)
    
    lambda = lambdas(i);
    [y, u, E] = policzDMC(D, 0, N, Nu, lambda, Kk, z, 0);
    
    zapiszDoPliku([dirPathTxt '/wyjscie_lambda_'  num2str(lambdas(i)) '.txt'], y);
    zapiszDoPliku([dirPathTxt '/sterowanie_lambda_'  num2str(lambdas(i)) '.txt'], u);
    
    subplot(2,1,1);
    rysujWykres((1 : length(y)), y, -1, 'k', 'y', '', 'Wyjscie obiektu dla zerowego zaklocenia');
    hold on

    subplot(2,1,2);
    rysujWykres((1 : length(u)), u, -1, 'k', 'u', '', 'Sterowanie dla zerowego zaklocenia');
    hold on
    
    Es(i) = E;

end

legend(['D=N=Nu=' num2str(D) 'lambda=' num2str(lambdas(1)) ' E=' num2str(Es(1))], ['D=N=Nu=' num2str(D) 'lambda=' num2str(lambdas(2)) ' E=' num2str(Es(2))], ['D=N=Nu=' num2str(D) 'lambda=' num2str(lambdas(3)) ' E=' num2str(Es(3))]);

savefig([dirPathFigures '/sterowanie_wyjscie.fig']);
zapiszDoPliku([dirPathTxt '/bledy.txt'], Es);