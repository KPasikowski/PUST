parametry;

dirPathFigures = 'wykresy_figury/zad6/PID';
dirPathTxt = 'wykresy_pliki/zad6/PID';

noises = {@() 0.006*(rand() - 0.5), @() 0.02*(rand() - 0.5), @() 0.06*(rand() - 0.5)};

Kp1 = 1;
Ti1 = 15;
Td1 = 0.8;
Kp2 = 0.6;
Ti2 = 10;
Td2 = 0.005;

for i = 1 : length(noises)
    [y, u, E, yzad] = policzPID(Kp1, Ti1, Td1, Kp2, Ti2, Td2, Kk, 1, 6, noises{i});
    zapiszDoPliku([dirPathTxt '/wyjscie1_szum='  num2str(i) '.txt'], y(1,:));
    zapiszDoPliku([dirPathTxt '/sterowanie1_szum='  num2str(i) '.txt'], u(1,:));
    zapiszDoPliku([dirPathTxt '/wyjscie2_szum='  num2str(i) '.txt'], y(2,:));
    zapiszDoPliku([dirPathTxt '/sterowanie2_szum='  num2str(i) '.txt'], u(2,:));

    figure;

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
