parametry;

dirPathFigures = 'wykresy_figury/zad2';
dirPathTxt = 'wykresy_pliki/zad2';
dirPathTxtControl = [dirPathTxt '/odpowiedzi_skokowe'];
mkDirectory(dirPathFigures);
mkDirectory(dirPathTxt);
mkDirectory(dirPathTxtControl);

delta_u = [0.4 0.8 -0.4 -0.8];

runStepResponse(delta_u, Kk, dirPathFigures, dirPathTxtControl, 1, 'sterowanie');


