parametry;

dirPathFigures = 'wykresy_figury/zad4';
%dirPathFiguresConf = [dirPathFigures '/config_podstawowy'];
%dirPathFiguresConf = [dirPathFigures '/config_odwrotny'];
dirPathTxt = 'wykresy_pliki/zad4';
subDirPathPID = [dirPathTxt '/PID'];
%subDirPathPIDConf = [subDirPathPID '/config_podstawowy'];
%subDirPathPIDConf = [subDirPathPID '/config_odwrotny'];
mkDirectory(subDirPathPID);
%mkDirectory(subDirPathPIDConf);
%mkDirectory(dirPathFiguresConf);

Kp1s = [1 0.6 0.8];
Kp2s = [3 0.6 0.8];
Kp3s = [1 0.6 0.8];
%Ti1s = [15 10 8];
%Ti2s = [15 10 8];
%Ti3s = [15 10 8];
%Td1s = [0.8 0.005 0.007];
%Td2s = [0.8 0.005 0.007];
%Td3s = [0.8 0.005 0.007];
Ti1s = [8 6 4];
Ti2s = [8 6 4];
Ti3s = [8 6 4];
Td1s = [0.008 0.004 0.002];
Td2s = [0.008 0.004 0.002];
Td3s = [0.008 0.004 0.002];

Es = zeros(1, length(Kp1s));


figure;
for i = 1 : length(Kp1s)
    
    [y, u, E, yzad] = policzPID(Kp1s(i), Ti1s(i), Td1s(i), Kp2s(i), Ti2s(i), Td2s(i), Kp3s(i), Ti3s(i), Td3s(i), Kk);
    
    zapiszDoPliku([subDirPathPID '/wyjscie1_Kp1='  num2str(Kp1s(i)) '_Ti1=' num2str(Ti1s(i)) '_Td1=' num2str(Td1s(i)) '_Kp2=' num2str(Kp2s(i)) '_Ti2=' num2str(Ti2s(i)) '_Td2=' num2str(Td2s(i)) '_Kp3=' num2str(Kp3s(i)) '_Ti3=' num2str(Ti3s(i)) '_Td3=' num2str(Td3s(i)) '.txt'], y(1,:));
    zapiszDoPliku([subDirPathPID '/sterowanie1_Kp1='  num2str(Kp1s(i)) '_Ti1=' num2str(Ti1s(i)) '_Td1=' num2str(Td1s(i)) '_Kp2=' num2str(Kp2s(i)) '_Ti2=' num2str(Ti2s(i)) 'Td2=' num2str(Td2s(i)) '_Kp3=' num2str(Kp3s(i)) '_Ti3=' num2str(Ti3s(i)) '_Td3=' num2str(Td3s(i)) '.txt'], u(1,:));
    zapiszDoPliku([subDirPathPID '/wyjscie2__Kp1='  num2str(Kp1s(i)) '_Ti1=' num2str(Ti1s(i)) '_Td1=' num2str(Td1s(i)) '_Kp2=' num2str(Kp2s(i)) '_Ti2=' num2str(Ti2s(i)) 'Td2=' num2str(Td2s(i)) '_Kp3=' num2str(Kp3s(i)) '_Ti3=' num2str(Ti3s(i)) '_Td3=' num2str(Td3s(i)) '.txt'], y(2,:));
    zapiszDoPliku([subDirPathPID '/sterowanie2__Kp1='  num2str(Kp1s(i)) '_Ti1=' num2str(Ti1s(i)) '_Td1=' num2str(Td1s(i)) '_Kp2=' num2str(Kp2s(i)) '_Ti2=' num2str(Ti2s(i)) 'Td2=' num2str(Td2s(i)) '_Kp3=' num2str(Kp3s(i)) '_Ti3=' num2str(Ti3s(i)) '_Td3=' num2str(Td3s(i)) '.txt'], u(2,:));
    zapiszDoPliku([subDirPathPID '/wyjscie3__Kp1='  num2str(Kp1s(i)) '_Ti1=' num2str(Ti1s(i)) '_Td1=' num2str(Td1s(i)) '_Kp2=' num2str(Kp2s(i)) '_Ti2=' num2str(Ti2s(i)) 'Td2=' num2str(Td2s(i)) '_Kp3=' num2str(Kp3s(i)) '_Ti3=' num2str(Ti3s(i)) '_Td3=' num2str(Td3s(i)) '.txt'], y(3,:));
    zapiszDoPliku([subDirPathPID '/sterowanie4__Kp1='  num2str(Kp1s(i)) '_Ti1=' num2str(Ti1s(i)) '_Td1=' num2str(Td1s(i)) '_Kp2=' num2str(Kp2s(i)) '_Ti2=' num2str(Ti2s(i)) 'Td2=' num2str(Td2s(i)) '_Kp3=' num2str(Kp3s(i)) '_Ti3=' num2str(Ti3s(i)) '_Td3=' num2str(Td3s(i)) '.txt'], u(3,:));
    
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

zapiszDoPliku([subDirPathPID '/wartosc_zadana1.txt'], yzad(1,:));
zapiszDoPliku([subDirPathPID '/wartosc_zadana2.txt'], yzad(2,:));
zapiszDoPliku([subDirPathPID '/wartosc_zadana3.txt'], yzad(3,:));

%savefig([dirPathFiguresConf '/sterowanie_wyjscie_PID.fig']);
zapiszDoPliku([subDirPathPID '/bledy.txt'], Es);
