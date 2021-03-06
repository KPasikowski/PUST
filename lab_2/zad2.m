W1 = 50;
G1 = 29;
T1 = 34;
liczba_pomiarow = 400;
skok = 30;
Tsk = 30;
U = ones(1,liczba_pomiarow);
Z = ones(1,liczba_pomiarow);
U(1:liczba_pomiarow) = U(1:liczba_pomiarow)*G1;
Z(1:Tsk) = Z(1:Tsk)*0;
Z(Tsk+1:liczba_pomiarow) = Z(Tsk+1:liczba_pomiarow)*skok;
%U(Tsk+1 : liczba_pomiarow) = U(Tsk+1 : liczba_pomiarow)*(G1+skok);

Y = ones(1,liczba_pomiarow);

addpath ('F:\SerialCommunication'); % add a path
initSerialControl COM16 % initialise com port
sendControls ([1,5],[W1,U(i)]);
figure;
for i = 1:liczba_pomiarow

pomiary = readMeasurements(1) ;


Y(i) = pomiary;


sendControlsToG1AndDisturbance(U(i), 0);

stairs(Y);
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
