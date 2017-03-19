parametry;

dirPathFigures = 'wykresy_figury/zad7';
dirPathTxt = 'wykresy_pliki/zad7';
mkDirectory(dirPathFigures);
mkDirectory(dirPathTxt);

x = (1 : 1 : Kk);

D = 200;
Dz = 200;
N = D;
Nu = D;

lambda = 5;

errors = {@(k) 0, @(k) 0.2, @(k) 0.5*k/Kk}
noises = {@(z) z, @(z) z*(1+0.5*rand()), @(z) z*(1+rand()), @(z) z+0.1*(rand()-0.5), @(z) z+0.5*(rand()-0.5)}

for i = 1 : length(errors)
    z = errors{i};
    for j = 1 : length(noises)
        noise = noises{j};
        [y(j,:), u(j,:), E(j,:)] = policzDMC(D, Dz, N, Nu, lambda, Kk, z, 1, noise);
        zapiszDoPliku([dirPathTxt '/wyjscie_szum_'  num2str(i) num2str(j) '.txt'], y(j,:));
        zapiszDoPliku([dirPathTxt '/sterowanie_szum_'  num2str(i) num2str(j) '.txt'], y(j,:));
    end
        
    figure;
    subplot(2,1,1);
    hold on
    for j = 1 : length(noises)
        rysujWykres((1 : length(y(j,:))), y(j,:), -1, 'k', 'y', '', ['Wyjscie obiektu, (i,j) = ' num2str(i) ',' num2str(j)]);
    end
    
    subplot(2,1,2);    
    hold on

    for j = 1 : length(noises)
        rysujWykres((1 : length(u(j,:))), u(j,:), -1, 'k', 'u', '', ['Sterowanie obiektu, (i,j) = ' num2str(i) ',' num2str(j)]);
    end
end