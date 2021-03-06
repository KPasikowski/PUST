parametry;

dirPathFigures = 'wykresy_figury/zad4';
dirPathTxt = 'wykresy_pliki/zad4';
subDirPathPID = [dirPathTxt '/PID'];
mkDirectory(dirPathFigures);
mkDirectory(subDirPathPID);

Kps = [0.6 0.5 0.5];
Tis = [10 10 9];
Tds = [0.5 0.6 0.6];

Es = zeros(1, length(Kps));


figure;
for i = 1 : length(Kps)
    
    [y, u, E, yzad] = policzPID(Kps(i), Tis(i), Tds(i), Kk);

    zapiszDoPliku([subDirPathPID '/wyjscie_Kp='  num2str(Kps(i)) '_Ti=' num2str(Tis(i)) '_Td=' num2str(Tds(i)) '.txt'], y);
    zapiszDoPliku([subDirPathPID '/sterowanie_Kp='  num2str(Kps(i)) '_Ti=' num2str(Tis(i)) '_Td=' num2str(Tds(i)) '.txt'], u);
    
    subplot(2,1,1);
    rysujWykres((1 : length(y)), y, -1, 'k', 'y', '', 'Wyjscie obiektu');
    hold on
    rysujWykres((1 : length(yzad)), yzad, -1, 'k', 'y', '', 'Wyjscie obiektu');
    hold on
    
    subplot(2,1,2);
    rysujWykres((1 : length(u)), u, -1, 'k', 'u', '', 'Sterowanie obiektu');
    hold on
    
    Es(i) = E;
    E
end

zapiszDoPliku([subDirPathPID '/wartosc_zadana.txt'], yzad);

savefig([dirPathFigures '/sterowanie_wyjscie_PID.fig']);
zapiszDoPliku([subDirPathPID '/bledy.txt'], Es);
