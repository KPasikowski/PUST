W1 = 50;
W2 = 50;
G1 = 29;
G2 = 34;
T1 = 34;
liczba_pomiarow = 400;
skok = 30;
Tsk = 30;
U1 = ones(1,liczba_pomiarow);
U2 = ones(1,liczba_pomiarow);
U1(1:liczba_pomiarow) = U1(1:liczba_pomiarow)*G1;
U2(1:liczba_pomiarow) = U2(1:liczba_pomiarow)*G2;
%U(Tsk+1 : liczba_pomiarow) = U(Tsk+1 : liczba_pomiarow)*(G1+skok);

Y1 = ones(1,liczba_pomiarow);
Y2 = ones(1,liczba_pomiarow);

addpath ('F:\SerialCommunication'); % add a path
initSerialControl COM14 % initialise com port
sendControls ([1,2,5,6],[W1, W2, G1, G2]);
figure;

for i = 1:liczba_pomiarow

pomiary1 = readMeasurements(1) ;

Y1(i) = pomiary1;

pomiary2 = readMeasurements(2) ;

Y2(i) = pomiary2;

%sendControls ([1,2,5,6],[W1, W2, U1(i), U2(i)]);


plot(Y1); hold on;
plot(Y2); hold off;

%drawnow;
pause(0.01);

waitForNewIteration();
end

% fileTitle = ['zad2_odpskok_y_', num2str(skok), '.txt'];
% filename = fopen(fileTitle,'w');
% for i=1:liczba_pomiarow
%     fprintf(filename,'%5d ',i);
%     fprintf(filename,'%5d\n',Y(i));
% end
% fclose(filename);
% 
% fileTitle = ['zad2_odpskok_z_',num2str(skok),'.txt'];
% filename = fopen(fileTitle,'w');
% for i=1:liczba_pomiarow
%     fprintf(filename,'%5d ',i);
%     fprintf(filename,'%5d\n',Z(i));
% end
% fclose(filename);
