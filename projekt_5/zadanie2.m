parametry;

dirPathFigures = 'wykresy_figury/zad2';
dirPathTxt = 'wykresy_pliki/zad2';
dirPathTxtOdpSkok = [dirPathTxt '/odp_skok'];
mkDirectory(dirPathTxtOdpSkok);

nu = 4;
ny = 3;
czas_sym = 304;


u1s = zeros(czas_sym, 1);
u1s(5:czas_sym) = 1;
u2s = zeros(czas_sym, 1);
u3s = zeros(czas_sym, 1);
u4s = zeros(czas_sym, 1);
for i = 1 : nu
    
    y1s = zeros(czas_sym, 1);
    y2s = zeros(czas_sym, 1);
    y3s = zeros(czas_sym, 1);
    
    for j = 5 : czas_sym
        [y1s(j), y2s(j), y3s(j)]  = symulacja_obiektu6( ...
            u1s(j-1), u1s(j-2), u1s(j-3), u1s(j-4), ...
            u2s(j-1), u2s(j-2), u2s(j-3), u2s(j-4), ...
            u3s(j-1), u3s(j-2), u3s(j-3), u3s(j-4), ...
            u4s(j-1), u4s(j-2), u4s(j-3), u4s(j-4), ...
            y1s(j-1), y1s(j-2), y1s(j-3), y1s(j-4), ...
            y2s(j-1), y2s(j-2), y2s(j-3), y2s(j-4), ...
            y3s(j-1), y3s(j-2), y3s(j-3), y3s(j-4));
    end
    figure;
    %utnij chwile przed skokiem
    y1s = y1s(5:length(y1s));
    y2s = y2s(5:length(y2s));
    y3s = y3s(5:length(y3s));
    rysujWykres((1:length(y1s)), y1s, 'sterowanie', 'y', ['Odpowiedz skokowa y1'...
    '(u' num2str(i) ')']);
    figure;
    rysujWykres((1:length(y2s)), y2s, 'sterowanie', 'y', ['Odpowiedz skokowa y2'...
    '(u' num2str(i) ')']);
    figure;
    rysujWykres((1:length(y3s)), y3s, 'sterowanie', 'y', ['Odpowiedz skokowa y3'...
    '(u' num2str(i) ')']);
    zapiszDoPliku([dirPathTxtOdpSkok '/odpskok_y1_u_' num2str(i) '.txt'], y1s);
    zapiszDoPliku([dirPathTxtOdpSkok '/odpskok_y2_u_' num2str(i) '.txt'], y2s);
    zapiszDoPliku([dirPathTxtOdpSkok '/odpskok_y3_u_' num2str(i) '.txt'], y3s);
    %zmien aktywne sterowanie
    tmp1 = u2s; u2s = u1s; tmp2 = u3s; u3s = tmp1; tmp1 = u4s; u4s = tmp2; u1s = tmp1;
    
end
