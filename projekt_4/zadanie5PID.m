parametry;

dirPathFigures = 'wykresy_figury/zad5';
dirPathTxt = 'wykresy_pliki/zad5';
mkDirectory(dirPathFigures);
mkDirectory(dirPathTxt);

Kps = [0.5 1.5 0 0 0 ; 1.5 1 1.5 0 0 ; 1.5 1 1.5 1 0 ; 1.5 1 1.5 1 1];
Tis = [15 10 0 0 0 ; 8 10 12 0 0 ; 8 10 12 12 0 ; 8 10 12 12 12];
Tds = [0.5 0.5 0 0 0 ; 0.05 0.03 0.05 0 0 ; 0.05 0.03 0.05 0.05 0 ; 0.05 0.03 0.05 0.05 0.05];
d = [8 2 3 4];
c = [0.0005 6 4 10];


Es = zeros(1, 4);

for k = 1 : 4
        

        [y, u, E, yzad] = policzPIDzad5(Kps(k, 1 : k+1), Tis(k, 1 : k+1), Tds(k, 1 : k+1), d, c, Kk);
        
        zapiszDoPliku([dirPathTxt '/wyjscie_lr_'  num2str(k+1) '.txt'], y);
        zapiszDoPliku([dirPathTxt '/sterowanie_lr_'  num2str(k+1) '.txt'], u);

        figure;
        subplot(2,1,1);
        rysujWykres((1 : length(y)), y, -1, 'k', 'y', '', ['Wyjscie obiektu, liczba regulator?w = ' num2str(k+1)]);
        hold on
        rysujWykres((1 : length(yzad)), yzad, -1, 'k', 'y', '', ['Wyjscie obiektu, liczba regulator?w = ' num2str(k+1)]);

        subplot(2,1,2);
        rysujWykres((1 : length(u)), u, -1, 'k', 'u', '', 'Sterowanie obiektu');
        
        savefig([dirPathFigures '/sterowanie_wyjscie_PID_lr_' num2str(k+1) '.fig']);

        Es(k) = E;

end

zapiszDoPliku([dirPathTxt '/wartosc_zadana.txt'], yzad);
zapiszDoPliku([dirPathTxt '/bledy.txt'], Es);


