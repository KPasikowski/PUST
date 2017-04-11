parametry;

dirPathFigures = 'wykresy_figury/zad5';
dirPathFiguresConf = [dirPathFigures '/config_podstawowy'];
% dirPathFiguresConf = [dirPathFigures '/config_odwrotny'];
dirPathTxt = 'wykresy_pliki/zad5';
subDirPathPID = [dirPathTxt '/PID'];
subDirPathPIDConf = [subDirPathPID '/config_podstawowy'];
% subDirPathPIDConf = [subDirPathPID '/config_odwrotny'];
mkDirectory(subDirPathPID);
mkDirectory(subDirPathPIDConf);
mkDirectory(dirPathFiguresConf);

Kp1s = [1 0.6 0.8];
Kp2s = [1 0.6 0.8];
Ti1s = [15 10 8];
Ti2s = [15 10 8];
Td1s = [0.8 0.005 0.007];
Td2s = [0.8 0.005 0.007];
% Ti1s = [0 0 0];
% Ti2s = [0 0 0];
% Td1s = [0 0 0];
% Td2s = [0 0 0];

Es = zeros(1, length(Kp1s));


figure;
for i = 1 : length(Kp1s)
    
    [y, u, E, yzad] = policzPID(Kp1s(i), Ti1s(i), Td1s(i), Kp2s(i), Ti2s(i), Td2s(i), Kk, 1, 5, @() 0);
    
    zapiszDoPliku([subDirPathPIDConf '/wyjscie1_Kp1='  num2str(Kp1s(i)) '_Ti1=' num2str(Ti1s(i)) '_Td1=' num2str(Td1s(i)) '_Kp2=' num2str(Kp2s(i)) '_Ti2=' num2str(Ti2s(i)) 'Td2=' num2str(Td2s(i)) '.txt'], y(1,:));
    zapiszDoPliku([subDirPathPIDConf '/sterowanie1_Kp1='  num2str(Kp1s(i)) '_Ti1=' num2str(Ti1s(i)) '_Td1=' num2str(Td1s(i)) '_Kp2=' num2str(Kp2s(i)) '_Ti2=' num2str(Ti2s(i)) 'Td2=' num2str(Td2s(i)) '.txt'], u(1,:));
    zapiszDoPliku([subDirPathPIDConf '/wyjscie2__Kp1='  num2str(Kp1s(i)) '_Ti1=' num2str(Ti1s(i)) '_Td1=' num2str(Td1s(i)) '_Kp2=' num2str(Kp2s(i)) '_Ti2=' num2str(Ti2s(i)) 'Td2=' num2str(Td2s(i)) '.txt'], y(2,:));
    zapiszDoPliku([subDirPathPIDConf '/sterowanie2__Kp1='  num2str(Kp1s(i)) '_Ti1=' num2str(Ti1s(i)) '_Td1=' num2str(Td1s(i)) '_Kp2=' num2str(Kp2s(i)) '_Ti2=' num2str(Ti2s(i)) 'Td2=' num2str(Td2s(i)) '.txt'], u(2,:));
    
    subplot(4,1,1);
    rysujWykres((1 : length(y(1,:))), y(1,:), -1, 'k', 'y1', '', 'Wyjscie y1 obiektu');
    hold on
    rysujWykres((1 : length(yzad(1,:))), yzad(1,:), -1, 'k', 'y1', '', 'Wyjscie y1 obiektu');
    hold on
    
    subplot(4,1,2);
    rysujWykres((1 : length(y(2,:))), y(2,:), -1, 'k', 'y2', '', 'Wyjscie y2 obiektu');
    hold on
    rysujWykres((1 : length(yzad(2,:))), yzad(2,:), -1, 'k', 'y2', '', 'Wyjscie y2 obiektu');
    hold on

    subplot(4,1,3);
    rysujWykres((1 : length(u(1,:))), u(1,:), -1, 'k', 'u1', '', 'Sterowanie u1');
    hold on

    subplot(4,1,4);
    rysujWykres((1 : length(u(2,:))), u(2,:), -1, 'k', 'u', '', 'Sterowanie u2');
    hold on
    
    Es(i) = E;

end

zapiszDoPliku([subDirPathPIDConf '/wartosc_zadana1.txt'], yzad(1,:));
zapiszDoPliku([subDirPathPIDConf '/wartosc_zadana2.txt'], yzad(2,:));


savefig([dirPathFiguresConf '/sterowanie_wyjscie_PID.fig']);
zapiszDoPliku([subDirPathPIDConf '/bledy.txt'], Es);
