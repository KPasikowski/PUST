parametry;

dirPathFigures = 'wykresy_figury/zad5';
dirPathTxt = 'wykresy_pliki/zad5';
mkDirectory(dirPathFigures);
mkDirectory(dirPathTxt);

Kps = [0.11 8 0 0 0 ; 0.11 0.3 10 0 0 ; 0.11 0.4 1.5 10 0 ; 0.11 0.4 1.5 3 10];
Tis = [3.5 1.5 0 0 0 ; 3.5 7 1.5 0 0 ; 3.5 3.2 3 1.5 0 ; 3.5 3.2 3 2.5 1.5];
Tds = [1.5 0.1 0 0 0 ; 1.5 0.25 0.1 0 0 ; 1.5 1 0.8 0.1 0 ; 1.5 1 0.8 0.6 0.1];
d = [10 0 0 0; 10 10 0 0 ; 10 2 12 0; 10 10 8 12];
c = [-0.6 0 0 0 ; -0.7 -0.2 0 0 ; -0.6 -0.3 -0.3 0 ; -0.6 -0.3 -0.35 -0.3];


Es = zeros(1, 4);

for k = 1 : 4
        

        [y, u, E, yzad] = policzPIDzad5(Kps(k, 1 : k+1), Tis(k, 1 : k+1), Tds(k, 1 : k+1), d(k, 1 : k), c(k, 1 : k), Kk);
        
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


