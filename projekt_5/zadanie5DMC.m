parametry;

lowerBound=[0,0,0,0,0,0,0];
upperBound=[Inf,Inf,Inf,Inf,Inf,Inf,Inf];
lambda = [1 1 1 1];
psi = [1 1 1 ];
x0= [lambda psi];


x = fmincon(@(x)(optDMC([x(1), x(2), x(3), x(4)], [x(5), x(6), x(7)])),x0,[],[],[],[],lowerBound,upperBound);
[y, u, E, yzad] = policzDMC(200, 200, 200, [x(1), x(2), x(3), x(4)], [x(5), x(6), x(7)], Kk);


subplot(6,1,1);
rysujWykres((1 : length(y(1,:))), y(1,:), 'k', 'y1', 'Wyjscie y1 obiektu');
hold on
rysujWykres((1 : length(yzad(1,:))), yzad(1,:), 'k', 'y1', 'Wyjscie y1 obiektu');
hold on

subplot(6,1,2);
rysujWykres((1 : length(y(2,:))), y(2,:), 'k', 'y2', 'Wyjscie y2 obiektu');
hold on
rysujWykres((1 : length(yzad(2,:))), yzad(2,:), 'k', 'y2', 'Wyjscie y2 obiektu');
hold on

subplot(6,1,3);
rysujWykres((1 : length(y(3,:))), y(3,:), 'k', 'y3', 'Wyjscie y3 obiektu');
hold on
rysujWykres((1 : length(yzad(3,:))), yzad(3,:), 'k', 'y3', 'Wyjscie y3 obiektu');
hold on

subplot(6,1,4);
rysujWykres((1 : length(u(1,:))), u(1,:), 'k', 'u1', 'Sterowanie u1');
hold on

subplot(6,1,5);
rysujWykres((1 : length(u(2,:))), u(2,:), 'k', 'u', 'Sterowanie u2');
hold on

subplot(6,1,6);
rysujWykres((1 : length(u(3,:))), u(3,:), 'k', 'u', 'Sterowanie u4');
hold on

dirPathTxt = 'wykresy_pliki/zad5';
subDirPathDMC = [dirPathTxt '/DMC'];
mkDirectory(subDirPathDMC);
zapiszDoPliku([subDirPathDMC '/zad5DMC_parametry.txt'], x);
zapiszDoPliku([subDirPathDMC '/zad5DMC_E.txt'], E);
zapiszDoPliku([subDirPathDMC '/zad5DMC_yzad.txt'], yzad);
zapiszDoPliku([subDirPathDMC '/zad5DMC_y.txt'], y);
zapiszDoPliku([subDirPathDMC '/zad5DMC_u.txt'], u);