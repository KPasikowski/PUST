parametry;

dirPathFigures = 'wykresy_figury/zad6';
dirPathTxt = 'wykresy_pliki/zad6';
subDirPathDMC = [dirPathTxt '/DMC'];
mkDirectory(dirPathFigures);
mkDirectory(dirPathTxt);
mkDirectory(subDirPathDMC);

D = 200;
N = D;
Nu = D;
lambdas = [1 1 1 1 ; 1 1 10 10 ; 10 10 1 1];
psi = [1 1 1];
Es = zeros(1, length(lambdas(:,1)));


figure;
for i = 1 : length(lambdas(:,1))
    
    lambda = lambdas(i, :);
    [y, u, E, yzad] = policzDMCZad6(D, N, Nu, lambda, psi, Kk);
    
    zapiszDoPliku([subDirPathDMC '/wyjscie1_lambda_'  num2str(lambdas(i, 1)) '_' num2str(lambdas(i, 2)) '_' num2str(lambdas(i, 3)) '_' num2str(lambdas(i, 4)) '.txt'], y(1,:));
    zapiszDoPliku([subDirPathDMC '/sterowanie1_lambda_'  num2str(lambdas(i, 1)) '_' num2str(lambdas(i, 2)) '_' num2str(lambdas(i, 3)) '_' num2str(lambdas(i, 4)) '.txt'], u(1,:));
    zapiszDoPliku([subDirPathDMC '/wyjscie2_lambda_'  num2str(lambdas(i, 1)) '_' num2str(lambdas(i, 2)) '_' num2str(lambdas(i, 3)) '_' num2str(lambdas(i, 4)) '.txt'], y(2,:));
    zapiszDoPliku([subDirPathDMC '/sterowanie2_lambda_'  num2str(lambdas(i, 1)) '_' num2str(lambdas(i, 2)) '_' num2str(lambdas(i, 3)) '_' num2str(lambdas(i, 4)) '.txt'], u(2,:));
    zapiszDoPliku([subDirPathDMC '/wyjscie3_lambda_'  num2str(lambdas(i, 1)) '_' num2str(lambdas(i, 2)) '_' num2str(lambdas(i, 3)) '_' num2str(lambdas(i, 4)) '.txt'], y(3,:));
    zapiszDoPliku([subDirPathDMC '/sterowanie3_lambda_'  num2str(lambdas(i, 1)) '_' num2str(lambdas(i, 2)) '_' num2str(lambdas(i, 3)) '_' num2str(lambdas(i, 4)) '.txt'], u(3,:));    
    zapiszDoPliku([subDirPathDMC '/sterowanie4_lambda_'  num2str(lambdas(i, 1)) '_' num2str(lambdas(i, 2)) '_' num2str(lambdas(i, 3)) '_' num2str(lambdas(i, 4)) '.txt'], u(4,:));    
    
    
    subplot(6,1,1);
    rysujWykres((1 : length(y(1,:))), y(1,:), 'k', 'y1', 'Wyjscie y1 obiektu');
    hold on
    rysujWykres((1 : length(yzad(1,:))), yzad(1,:), 'k', 'y1', 'Wyjscie y1 obiektu');
    hold on

    subplot(6,1,2);
    rysujWykres((1 : length(y(2,:))), y(2,:), 'k', 'y2', 'Wyjscie y2 obiektu');
    hold on
    rysujWykres((1 : length(yzad(2,:))), yzad(2,:), 'k', 'y2', 'Wyjscie y2 obiektu');
    hold on

    subplot(6,1,3);
    rysujWykres((1 : length(y(3,:))), y(3,:), 'k', 'y3', 'Wyjscie y3 obiektu');
    hold on
    rysujWykres((1 : length(yzad(3,:))), yzad(3,:), 'k', 'y3', 'Wyjscie y3 obiektu');
    hold on

    subplot(6,1,4);
    rysujWykres((1 : length(u(1,:))), u(1,:), 'k', 'u1', 'Sterowanie u1');
    hold on

    subplot(6,1,5);
    rysujWykres((1 : length(u(2,:))), u(2,:), 'k', 'u', 'Sterowanie u2');
    hold on

    subplot(6,1,6);
    rysujWykres((1 : length(u(3,:))), u(3,:), 'k', 'u', 'Sterowanie u4');
    hold on

    Es(i) = E;

end

savefig([dirPathFigures '/sterowanie_wyjscie.fig']);
zapiszDoPliku([subDirPathDMC '/bledy.txt'], Es);