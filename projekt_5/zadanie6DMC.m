parametry;

dirPathFigures = 'wykresy_figury/zad6/DMC';
dirPathTxt = 'wykresy_pliki/zad6/DMC';

noises = {@() 0.006*(rand() - 0.5), @() 0.02*(rand() - 0.5), @() 0.06*(rand() - 0.5)};

D = 200;
N = D;
Nu = D;
lambda = 1;


for i = 1 : length(noises)
    [y, u, E, yzad] = policzDMC(D, N, Nu, lambda, 600, 6, noises{i});
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
