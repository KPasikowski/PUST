W1 = 50;
G1 = 29;
T1 = 34.5;
liczba_pomiarow = 300;
skok = 0;
Tsk = 30;
U = ones(1,liczba_pomiarow);
U(1:Tsk) = U(1:Tsk)*G1;
U(Tsk+1 : liczba_pomiarow) = U(Tsk+1 : liczba_pomiarow)*(G1+skok);

Y = ones(1,liczba_pomiarow);

addpath ('F:\SerialCommunication'); % add a path
initSerialControl COM14 % initialise com port
sendControls (1,W1);
figure;
for i = 1:liczba_pomiarow

pomiary = readMeasurements(1) ;


Y(i) = pomiary;

sendNonlinearControls(U(i));

stairs(Y);
pause(0.01);

waitForNewIteration();
end
% 
% fileTitle = ['odpskok_y_',num2str(skok),'.txt'];
% filename = fopen(fileTitle,'w');
% for i=1:liczba_pomiarow
%     fprintf(filename,'%5d ',i);
%     fprintf(filename,'%5d\n',Y(i));
% end
% fclose(filename);
% 
% fileTitle = ['odpskok_u_',num2str(skok),'.txt'];
% filename = fopen(fileTitle,'w');
% for i=1:liczba_pomiarow
%     fprintf(filename,'%5d ',i);
%     fprintf(filename,'%5d\n',U(i));
% end
% fclose(filename);
