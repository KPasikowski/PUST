parametry;

dirPathFigures = 'wykresy_figury/zad6';
dirPathTxt = 'wykresy_pliki/zad6';
mkDirectory(dirPathFigures);
mkDirectory(dirPathTxt);

x = (1 : 1 : Kk);
f = 200;
fs = 12000;
z = 0.5*sin(2*pi*f/fs*x);

D = 200;
Dz = 200;
N = D;
Nu = D;
lambdas = [5 15 60];

E1s = zeros(1, length(lambdas));
E2s = zeros(1, length(lambdas));

for i = 1 : length(lambdas)
    lambda = lambdas(i);
    [y1, u1, E1] = policzDMC(D, Dz, N, Nu, lambda, Kk, z, 0, @(z) z);
    [y2, u2, E2] = policzDMC(D, Dz, N, Nu, lambda, Kk, z, 1, @(z) z);
    
    zapiszDoPliku([dirPathTxt '/wyjscie_bez_pom_lambda_'  num2str(lambdas(i)) '.txt'], y1);
    zapiszDoPliku([dirPathTxt '/sterowanie_bez_pom_lambda_'  num2str(lambdas(i)) '.txt'], u1);
    
    zapiszDoPliku([dirPathTxt '/wyjscie_pom_lambda_'  num2str(lambdas(i)) '.txt'], y2);
    zapiszDoPliku([dirPathTxt '/sterowanie_pom_lambda_'  num2str(lambdas(i)) '.txt'], u2);
    
    figure;
    subplot(2,1,1);
    rysujWykres((1 : length(y1)), y1, -1, 'k', 'y', '', ['Wyjscie obiektu z mierzonym zakloceniem i bez, lambda = ' num2str(lambdas(i))]);
    hold on
    rysujWykres((1 : length(y2)), y2, -1, 'k', 'y', '', ['Wyjscie obiektu z mierzonym zakloceniem i bez, lambda = ' num2str(lambdas(i))]);

    subplot(2,1,2);
    rysujWykres((1 : length(u1)), u1, -1, 'k', 'u', '', ['Sterowanie z mierzonym zakloceniem i bez, lambda = ' num2str(lambdas(i))]);
    hold on
    rysujWykres((1 : length(u2)), u2, -1, 'k', 'u', '', ['Sterowanie z mierzonym zakloceniem i bez, lambda = ' num2str(lambdas(i))]);
    
    legend('bez pomiaru zaklocenia', 'z pomiarem zaklocenia');
    savefig([dirPathFigures '/sterowanie_wyjscie_lambda_ ' num2str(lambdas(i)) '.fig']);
    
    E1s(i) = E1;
    E2s(i) = E2;
end

zapiszDoPliku([dirPathTxt '/bledy_bez_pom.txt'], E1s);
zapiszDoPliku([dirPathTxt '/bledy_pom.txt'], E2s);