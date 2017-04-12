parametry;

dirPathFigures = 'wykresy_figury/zad2';
dirPathTxt = 'wykresy_pliki/zad2';
dirPathTxtCharStat = [dirPathTxt '/char_stat'];
mkDirectory(dirPathTxtCharStat);

u = (-1 : 0.01 : 1);
z = (-1 : 0.01 : 1);
ys = zeros(length(u), length(z));
czas_sym = 120;

for i = 1 : length(u)
    
    for k = 1 : length(z) 
        y = zeros(czas_sym, 1) + Ypp;
    
        for j = 3 : czas_sym
            y(j) = symulacja_obiektu3y(u(i), u(i), z(k), z(k), y(j - 1), y(j - 2));
        end
        
        ys(i, k) = y(czas_sym);
    end
    
end

figure;
rysujWykres(z, u, ys, 'zaklocenie', 'sterowanie', 'y', 'Charakterystyka statyczna procesu y(u,z)');
%savefig([dirPathFigures '/zad2_char_stat.fig']);
