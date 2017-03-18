parametry;

dirPathFigures = 'wykresy_figury/zad3';
dirPathTxt = 'wykresy_pliki/zad3';
dirPathTxtControl = [dirPathTxt '/skok_sterowania'];
dirPathTxtDist = [dirPathTxt '/skok_zaklocenia'];
mkDirectory(dirPathFigures);
mkDirectory(dirPathTxt);
mkDirectory(dirPathTxtControl);
mkDirectory(dirPathTxtDist);

uStep = 0.4;
zStep = 0.4;

y_u = runStepResponse(uStep, Kk, '', '', 0, 'sterowanie');
y_z = runStepResponse(zStep, Kk, '', '', 0, 'zaklocenie');

s_u = (y_u(7:Kk) - y_u(6)) / uStep;
s_z = (y_z(7:Kk) - y_z(6)) / zStep;

figure;
rysujWykres((1 : length(s_u)), s_u, -1, 'k', 's', '', ['Odpowiedz skokowa dla DMC, skok sterowania = ' num2str(uStep)]);
savefig([dirPathFigures '/zad3_odp_skok_ster_' num2str(uStep) '.fig']);

figure;
rysujWykres((1 : length(s_z)), s_z, -1, 'k', 's', '', ['Odpowiedz skokowa dla DMC, skok zaklocenia = ' num2str(zStep)]);
savefig([dirPathFigures '/zad3_odp_skok_zakl_' num2str(zStep) '.fig']);

zapiszDoPliku([dirPathTxtControl '/odp_skok_ster_'  num2str(uStep) '.txt'], s_u);
zapiszDoPliku([dirPathTxtDist '/odp_skok_zakl_'  num2str(zStep) '.txt'], s_z);


