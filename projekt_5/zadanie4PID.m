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

Kp1s = [1 0.9 0.8 ;  1 1.2 0.8 ; 0.03 0.05 0.01 ; 0.2 0.25 0.15 ; 1 1.1 1.1 ; 2 2.3 1.7 ];
Kp2s = [1.6 1.5 1.4 ; 0.01 0.015 0.008 ; 0.5 0.7 0.3 ; 1 1.2 0.8 ; 0.3 0.3 0.3 ; 1.6 1.6 1.4 ];
Kp3s = [1 0.9 0.8 ; 0.01 0.015 0.008 ; 1 1.2 0.8 ; 0.01 0.015 0.007 ; 1 1 1 ; 0.01 0.01 0.008 ];

Ti1s = [20 20 20 ; 20 20 20 ; 200 200 200 ; 20 20 20 ; 20 20 20 ; 3 3 3 ];
Ti2s = [20 20 20 ; 20 20 20 ; 20 20 20 ; 20 20 20 ; 20 20 20 ; 20 20 20 ];
Ti3s = [15 15 15 ; 15 15 15 ; 15 15 15 ; 15 15 15 ; 15 15 15 ; 15 15 15 ];
Td1s = [0.1 0.1 0.07 ; 0.1 0.1 0.1 ; 0.01 0.01 0.01 ; 0.01 0.01 0.01 ; 0.1 0.1 0.1 ; 0.2 0.2 0.2 ];
Td2s = [1 1 0.9 ; 0.1 0.1 0.1 ; 0.1 0.1 0.1 ; 1 1 1 ; 1 1 1 ; 1 1 1 ];
Td3s = [0.8 0.8 0.7 ; 0.1 0.1 0.1 ; 0.8 0.8 0.8 ; 0.2 0.2 0.2  ; 0.8 0.8 0.8 ; 0.01 0.01 0.01 ];

Es = zeros(1, length(Kp1s));


for option = 1 : 6
    
    figure;
    for i = 1 : length(Kp1s(1, :))

        [y, u, E, yzad] = policzPID(Kp1s(option, i), Ti1s(option, i), Td1s(option, i), Kp2s(option, i), Ti2s(option, i), Td2s(option, i), Kp3s(option, i), Ti3s(option, i), Td3s(option, i), Kk, option);

        zapiszDoPliku([subDirPathPID '/wyjscie1_Kp1='  num2str(Kp1s(option, i)) '_Ti1=' num2str(Ti1s(option, i)) '_Td1=' num2str(Td1s(option, i)) '_Kp2=' num2str(Kp2s(option, i)) '_Ti2=' num2str(Ti2s(option, i)) '_Td2=' num2str(Td2s(option, i)) '_Kp3=' num2str(Kp3s(option, i)) '_Ti3=' num2str(Ti3s(option, i)) '_Td3=' num2str(Td3s(option, i)) '_config_' num2str(option) '.txt'], y(1,:));
        zapiszDoPliku([subDirPathPID '/sterowanie1_Kp1='  num2str(Kp1s(option, i)) '_Ti1=' num2str(Ti1s(option, i)) '_Td1=' num2str(Td1s(option, i)) '_Kp2=' num2str(Kp2s(option, i)) '_Ti2=' num2str(Ti2s(option, i)) 'Td2=' num2str(Td2s(option, i)) '_Kp3=' num2str(Kp3s(option, i)) '_Ti3=' num2str(Ti3s(option, i)) '_Td3=' num2str(Td3s(option, i)) '.txt'], u(1,:));
        zapiszDoPliku([subDirPathPID '/wyjscie2__Kp1='  num2str(Kp1s(option, i)) '_Ti1=' num2str(Ti1s(option, i)) '_Td1=' num2str(Td1s(option, i)) '_Kp2=' num2str(Kp2s(option, i)) '_Ti2=' num2str(Ti2s(option, i)) 'Td2=' num2str(Td2s(option, i)) '_Kp3=' num2str(Kp3s(option, i)) '_Ti3=' num2str(Ti3s(option, i)) '_Td3=' num2str(Td3s(option, i)) '.txt'], y(2,:));
        zapiszDoPliku([subDirPathPID '/sterowanie2__Kp1='  num2str(Kp1s(option, i)) '_Ti1=' num2str(Ti1s(option, i)) '_Td1=' num2str(Td1s(option, i)) '_Kp2=' num2str(Kp2s(option, i)) '_Ti2=' num2str(Ti2s(option, i)) 'Td2=' num2str(Td2s(option, i)) '_Kp3=' num2str(Kp3s(option, i)) '_Ti3=' num2str(Ti3s(option, i)) '_Td3=' num2str(Td3s(option, i)) '.txt'], u(2,:));
        zapiszDoPliku([subDirPathPID '/wyjscie3__Kp1='  num2str(Kp1s(option, i)) '_Ti1=' num2str(Ti1s(option, i)) '_Td1=' num2str(Td1s(option, i)) '_Kp2=' num2str(Kp2s(option, i)) '_Ti2=' num2str(Ti2s(option, i)) 'Td2=' num2str(Td2s(option, i)) '_Kp3=' num2str(Kp3s(option, i)) '_Ti3=' num2str(Ti3s(option, i)) '_Td3=' num2str(Td3s(option, i)) '.txt'], y(3,:));
        zapiszDoPliku([subDirPathPID '/sterowanie4__Kp1='  num2str(Kp1s(option, i)) '_Ti1=' num2str(Ti1s(option, i)) '_Td1=' num2str(Td1s(option, i)) '_Kp2=' num2str(Kp2s(option, i)) '_Ti2=' num2str(Ti2s(option, i)) 'Td2=' num2str(Td2s(option, i)) '_Kp3=' num2str(Kp3s(option, i)) '_Ti3=' num2str(Ti3s(option, i)) '_Td3=' num2str(Td3s(option, i)) '.txt'], u(3,:));

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

        Es(option, i) = E;

    end

    zapiszDoPliku([subDirPathPID '/wartosc_zadana1_config_' num2str(option) '.txt'], yzad(1,:));
    zapiszDoPliku([subDirPathPID '/wartosc_zadana2_config_' num2str(option) '.txt'], yzad(2,:));
    zapiszDoPliku([subDirPathPID '/wartosc_zadana3_config_' num2str(option) '.txt'], yzad(3,:));

            %savefig([dirPathFiguresConf '/sterowanie_wyjscie_PID.fig']);
    zapiszDoPliku([subDirPathPID '/bledy_config_' num2str(option) '.txt'], Es);
    
end
