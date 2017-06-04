parametry;

dirPathFigures = 'wykresy_figury/zad3';
dirPathTxt = 'wykresy_pliki/zad3';
dirPathTxtCharStat = [dirPathTxt '/char_stat'];
mkDirectory(dirPathTxtCharStat);

u1s = (-1 : 0.01 : 1);
u2s = zeros(length(u1s), 1);
u3s = zeros(length(u1s), 1);
u4s = zeros(length(u1s), 1);
ys = zeros(length(u1s), 3);
czas_sym = 120;

for current_u = 1 : 4
    for i = 1 : length(u1s)

            y1s = zeros(czas_sym, 1);
            y2s = zeros(czas_sym, 1);
            y3s = zeros(czas_sym, 1);

            for j = 5 : czas_sym
                [y1s(j), y2s(j), y3s(j)]  = symulacja_obiektu6( ...
                u1s(i), u1s(i), u1s(i), u1s(i), ...
                u2s(i), u2s(i), u2s(i), u2s(i), ...
                u3s(i), u3s(i), u3s(i), u3s(i), ...
                u4s(i), u4s(i), u4s(i), u4s(i), ...
                y1s(j-1), y1s(j-2), y1s(j-3), y1s(j-4), ...
                y2s(j-1), y2s(j-2), y2s(j-3), y2s(j-4), ...
                y3s(j-1), y3s(j-2), y3s(j-3), y3s(j-4));        
            end

            ys(i, 1) = y1s(czas_sym);
            ys(i, 2) = y2s(czas_sym);
            ys(i, 3) = y3s(czas_sym);
    end
    figure;
    rysujWykres((-1 : 0.01 : 1), ys(:,1), 'sterowanie', 'y', ...
        ['Charakterystyka statyczna procesu y1(u' num2str(current_u) ')']);
    figure;
    rysujWykres((-1 : 0.01 : 1), ys(:,2), 'sterowanie', 'y', ...
        ['Charakterystyka statyczna procesu y2(u' num2str(current_u) ')']);
    figure;
    rysujWykres((-1 : 0.01 : 1), ys(:,3), 'sterowanie', 'y', ...
        ['Charakterystyka statyczna procesu y3(u' num2str(current_u) ')']);
    zapiszDoPliku([dirPathTxtCharStat '/charstat_y1_u_' num2str(current_u) '.txt'], ys(:,1));
    zapiszDoPliku([dirPathTxtCharStat '/charstat_y2_u_' num2str(current_u) '.txt'], ys(:,2));
    zapiszDoPliku([dirPathTxtCharStat '/charstat_y3_u_' num2str(current_u) '.txt'], ys(:,3));
    %zmien aktywne sterowanie
    tmp1 = u2s; u2s = u1s; tmp2 = u3s; u3s = tmp1; tmp1 = u4s; u4s = tmp2; u1s = tmp1;
end
