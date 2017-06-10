parametry;

lowerBound=[0,0,0,1e-5,1e-5,1e-5,0,0,0];
upperBound=[Inf,Inf,Inf,Inf,Inf,Inf,Inf,Inf,Inf];
x0= [1, 20, 0.1, 1, 20, 1, 1, 15, 0.8];


x = fmincon(@(x)(optPID(x)),x0,[],[],[],[],lowerBound,upperBound);
[y, u, E, yzad] = policzPID(x(1), x(2), x(3), x(4), x(5), x(6), x(7), x(8), x(9), Kk, 1);


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
subDirPathPID = [dirPathTxt '/PID'];
mkDirectory(subDirPathPID);
zapiszDoPliku([subDirPathPID '/zad5PID_parametry.txt'], x);
zapiszDoPliku([subDirPathPID '/zad5PID_E.txt'], E);
zapiszDoPliku([subDirPathPID '/zad5PID_yzad.txt'], yzad);
zapiszDoPliku([subDirPathPID '/zad5PID_y.txt'], y);
zapiszDoPliku([subDirPathPID '/zad5PID_u.txt'], u);