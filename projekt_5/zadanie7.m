parametry;

dirPathFigures = 'wykresy_figury/zad7';
dirPathTxt = 'wykresy_pliki/zad7';
subDirPathDMC = [dirPathTxt '/DMC'];
subDirPathPID = [dirPathTxt '/PID'];
mkDirectory(dirPathFigures);
mkDirectory(dirPathTxt);
mkDirectory(subDirPathDMC);
mkDirectory(subDirPathPID);

% ------------------------ DMC -------------------------

D = 200;
N = D;
Nu = D;
lambda = 1;

[y, u, E, yzad] = policzDMC(D, N, Nu, lambda, 600, 7, @() 0);
    
zapiszDoPliku([subDirPathDMC '/wyjscie1_lambda_'  num2str(lambda) '.txt'], y(1,:));
zapiszDoPliku([subDirPathDMC '/sterowanie1_lambda_'  num2str(lambda) '.txt'], u(1,:));
zapiszDoPliku([subDirPathDMC '/wyjscie2_lambda_'  num2str(lambda) '.txt'], y(2,:));
zapiszDoPliku([subDirPathDMC '/sterowanie2_lambda_'  num2str(lambda) '.txt'], u(2,:));

figure;

subplot(4,1,1);
rysujWykres((1 : length(y(1,:))), y(1,:), -1, 'k', 'y1', '', 'Wyjscie y1 obiektu');
hold on
rysujWykres((1 : length(yzad(1,:))), yzad(1,:), -1, 'k', 'y1', '', 'Wyjscie y1 obiektu');

subplot(4,1,2);
rysujWykres((1 : length(y(2,:))), y(2,:), -1, 'k', 'y2', '', 'Wyjscie y2 obiektu');
hold on
rysujWykres((1 : length(yzad(2,:))), yzad(2,:), -1, 'k', 'y2', '', 'Wyjscie y2 obiektu');

subplot(4,1,3);
rysujWykres((1 : length(u(1,:))), u(1,:), -1, 'k', 'u1', '', 'Sterowanie u1');
hold on

subplot(4,1,4);
rysujWykres((1 : length(u(2,:))), u(2,:), -1, 'k', 'u', '', 'Sterowanie u2');
hold on


zapiszDoPliku([subDirPathDMC '/wartosc_zadana1_DMC.txt'], yzad(1,:));
zapiszDoPliku([subDirPathDMC '/wartosc_zadana2_DMC.txt'], yzad(2,:));

savefig([dirPathFigures '/sterowanie_wyjscie_DMC.fig']);

% ------------------------ PID -------------------------
Kp1 = 1;
Ti1 = 15;
Td1 = 0.8;
Kp2 = 0.6;
Ti2 = 10;
Td2 = 0.005;


[y, u, E, yzad] = policzPID(Kp1, Ti1, Td1, Kp2, Ti2, Td2, Kk, 1, 7);
    
zapiszDoPliku([subDirPathPID '/wyjscie1_Kp1='  num2str(Kp1) '_Ti1=' num2str(Ti1) '_Td1=' num2str(Td1) '_Kp2=' num2str(Kp2) '_Ti2=' num2str(Ti2) 'Td2=' num2str(Td2) '.txt'], y(1,:));
zapiszDoPliku([subDirPathPID '/sterowanie1_Kp1='  num2str(Kp1) '_Ti1=' num2str(Ti1) '_Td1=' num2str(Td1) '_Kp2=' num2str(Kp2) '_Ti2=' num2str(Ti2) 'Td2=' num2str(Td2) '.txt'], u(1,:));
zapiszDoPliku([subDirPathPID '/wyjscie2__Kp1='  num2str(Kp1) '_Ti1=' num2str(Ti1) '_Td1=' num2str(Td1) '_Kp2=' num2str(Kp2) '_Ti2=' num2str(Ti2) 'Td2=' num2str(Td2) '.txt'], y(2,:));
zapiszDoPliku([subDirPathPID '/sterowanie2__Kp1='  num2str(Kp1) '_Ti1=' num2str(Ti1) '_Td1=' num2str(Td1) '_Kp2=' num2str(Kp2) '_Ti2=' num2str(Ti2) 'Td2=' num2str(Td2) '.txt'], u(2,:));

figure;

subplot(4,1,1);
rysujWykres((1 : length(y(1,:))), y(1,:), -1, 'k', 'y1', '', 'Wyjscie y1 obiektu');
hold on
rysujWykres((1 : length(yzad(1,:))), yzad(1,:), -1, 'k', 'y1', '', 'Wyjscie y1 obiektu');

subplot(4,1,2);
rysujWykres((1 : length(y(2,:))), y(2,:), -1, 'k', 'y2', '', 'Wyjscie y2 obiektu');
hold on
rysujWykres((1 : length(yzad(2,:))), yzad(2,:), -1, 'k', 'y2', '', 'Wyjscie y2 obiektu');

subplot(4,1,3);
rysujWykres((1 : length(u(1,:))), u(1,:), -1, 'k', 'u1', '', 'Sterowanie u1');

subplot(4,1,4);
rysujWykres((1 : length(u(2,:))), u(2,:), -1, 'k', 'u', '', 'Sterowanie u2');

zapiszDoPliku([subDirPathPID '/wartosc_zadana1_PID.txt'], yzad(1,:));
zapiszDoPliku([subDirPathPID '/wartosc_zadana2_PID.txt'], yzad(2,:));


savefig([dirPathFigures '/sterowanie_wyjscie_PID.fig']);
