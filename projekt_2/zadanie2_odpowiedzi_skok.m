parametry;

dirPathFigures = 'wykresy_figury/zad2';
dirPathTxt = 'wykresy_pliki/zad2';
dirPathTxtControl = [dirPathTxt '/skok_sterowania'];
dirPathTxtDist = [dirPathTxt '/skok_zaklocenia'];
mkDirectory(dirPathFigures);
mkDirectory(dirPathTxt);
mkDirectory(dirPathTxtControl);
mkDirectory(dirPathTxtDist);


delta_u = [0.4 0.8 -0.4 -0.8];
delta_z = [0.4 0.8 -0.4 -0.8];
u = zeros(Kk, 1);
z = zeros(Kk, 1);
y_u = zeros(Kk, 1) + Ypp;
y_z = zeros(Kk, 1) + Ypp;

figure;
for i = 1 : length(delta_u)
    u(1:6) = Upp;
    u(7:Kk) = Upp + delta_u(i);
    
    for k = 7 : Kk
       y_u(k) = symulacja_obiektu3y(u(k - 5), u(k - 6), z(k - 2), z(k - 3), y_u(k - 1), y_u(k - 2));
    end

    %wykres y_u
    subplot(2,1,1);
    rysujWykres((1 : length(y_u)), y_u, -1, 'k', 'y', '', 'Odpowiedz skokowa obiektu (skok sterowania)');
    hold on

    %wykres u
    subplot(2,1,2);
    rysujWykres((1 : length(u)), u, -1, 'k', 'u', '', 'Sygnal sterowania');
    hold on
    
    zapiszDoPliku([dirPathTxtControl '/wyjscie_skok_'  int2str(delta_u(i)) '.txt'], y_u);
    zapiszDoPliku([dirPathTxtControl '/sterowanie_skok_' int2str(delta_u(i)) '.txt'], u);

end

savefig([dirPathFigures '/zad2_odp_skok_ster.fig']);

u(1:Kk) = 0;
figure;
for i = 1 : length(delta_z)
    z(1:6) = Zpp;
    z(7:Kk) = Zpp + delta_z(i);
    
    for k = 7 : Kk
       y_z(k) = symulacja_obiektu3y(u(k - 5), u(k - 6), z(k - 2), z(k - 3), y_z(k - 1), y_z(k - 2));
    end
    
    %wykres y_z
    subplot(2,1,1);
    rysujWykres((1 : length(y_z)), y_z, -1, 'k', 'y', '','Odpowiedz skokowa obiektu (skok zaklocenia)');
    hold on

    %wykres z
    subplot(2,1,2);
    rysujWykres((1 : length(z)), z, -1, 'k', 'z', '', 'Sygnal zaklocenia');
    hold on
    
    zapiszDoPliku([dirPathTxtDist '/wyjscie_skok_' int2str(delta_z(i)) '.txt'], y_z);
    zapiszDoPliku([dirPathTxtDist '/zaklocenie_skok_' int2str(delta_z(i)) '.txt'], z);

end

savefig([dirPathFigures '/zad2_odp_skok_zakl.fig']);
