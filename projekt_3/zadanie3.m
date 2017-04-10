parametry;

dirPathFigures = 'wykresy_figury/zad3';
dirPathTxt = 'wykresy_pliki/zad3';
dirPathTxtControl = [dirPathTxt '/skok_sterowania'];
dirPathTxtDist = [dirPathTxt '/skok_zaklocenia'];
mkDirectory(dirPathFigures);
mkDirectory(dirPathTxt);
mkDirectory(dirPathTxtControl);
mkDirectory(dirPathTxtDist);

u1Step = 0.4;
u2Step = 0.4;

y1_u1 = runStepResponse(u1Step, Kk, '', '', 0, 'u1', 'y1');
y2_u1 = runStepResponse(u1Step, Kk, '', '', 0, 'u1', 'y2');
y1_u2 = runStepResponse(u2Step, Kk, '', '', 0, 'u2', 'y1');
y2_u2 = runStepResponse(u2Step, Kk, '', '', 0, 'u2', 'y2');

s_y1_u1 = (y1_u1(8:Kk) - y1_u1(7)) / u1Step;
s_y2_u1 = (y2_u1(8:Kk) - y2_u1(7)) / u1Step;
s_y1_u2 = (y1_u2(8:Kk) - y1_u2(7)) / u2Step;
s_y2_u2 = (y2_u2(8:Kk) - y2_u2(7)) / u2Step;

figure;
rysujWykres((1 : length(s_y1_u1)), s_y1_u1, -1, 'k', 's', '', ['Odpowiedz skokowa dla DMC ( u1 na y1 ), skok sterowania = ' num2str(u1Step)]);
savefig([dirPathFigures '/zad3_y1_u1_odp_skok_ster_' num2str(u1Step) '.fig']);

figure;
rysujWykres((1 : length(s_y2_u1)), s_y2_u1, -1, 'k', 's', '', ['Odpowiedz skokowa dla DMC ( u1 na y2 ), skok sterowania = ' num2str(u1Step)]);
savefig([dirPathFigures '/zad3_y2_u1_odp_skok_ster_' num2str(u1Step) '.fig']);

figure;
rysujWykres((1 : length(s_y1_u2)), s_y1_u2, -1, 'k', 's', '', ['Odpowiedz skokowa dla DMC ( u2 na y1 ), skok sterowania = ' num2str(u2Step)]);
savefig([dirPathFigures '/zad3_y1_u2_odp_skok_ster_' num2str(u2Step) '.fig']);

figure;
rysujWykres((1 : length(s_y2_u2)), s_y2_u2, -1, 'k', 's', '', ['Odpowiedz skokowa dla DMC ( u2 na y2 ), skok sterowania = ' num2str(u2Step)]);
savefig([dirPathFigures '/zad3_y2_u2_odp_skok_ster_' num2str(u2Step) '.fig']);

zapiszDoPliku([dirPathTxtControl '/odp_skok_y1_u1_ster_'  num2str(u1Step) '.txt'], s_y1_u1);
zapiszDoPliku([dirPathTxtControl '/odp_skok_y2_u1_ster_'  num2str(u1Step) '.txt'], s_y2_u1);
zapiszDoPliku([dirPathTxtControl '/odp_skok_y1_u2_ster_'  num2str(u2Step) '.txt'], s_y1_u2);
zapiszDoPliku([dirPathTxtControl '/odp_skok_y2_u2_ster_'  num2str(u2Step) '.txt'], s_y2_u2);





