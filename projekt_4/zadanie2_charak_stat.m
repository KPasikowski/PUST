parametry;

dirPathFigures = 'wykresy_figury/zad2';
dirPathTxt = 'wykresy_pliki/zad2';
dirPathTxtCharStat = [dirPathTxt '/char_stat'];
mkDirectory(dirPathTxtCharStat);

u = [U_min : 0.01 : U_max];
ys = zeros(length(u), 1);
czas_sym = 120;

for k = 1 : length(u)
    y = zeros(czas_sym, 1) + Ypp;
    
    for i = 3 : czas_sym
        y(i) = symulacja_obiektu6y(u(k), u(k), y(i-1), y(i-2));
    end
    
    ys(k) = y(czas_sym);
end

% zapis do pliku txt
fileVar = fopen([dirPathTxtCharStat '/char_stat.txt'], 'w');

for i = 1 : length(ys)
    fprintf(fileVar,'%5d ', u(i));
    fprintf(fileVar,'%5d\n', ys(i));
end

fclose(fileVar);

%wykres charakterystyki statycznej i zapis do pliku .fig
figure;
rysujWykres(u, ys, -1, 'u', 'y', '', 'Charakterystyka statyczna procesu y(u)');
savefig([dirPathFigures '/zad2_char_stat.fig']);


