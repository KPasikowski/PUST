parametry;

dirPathFigures = 'wykresy_figury/zad2';
dirPathTxt = 'wykresy_pliki/zad2';
dirPathTxtU1Y1 = [dirPathTxt '/skok_sterowania_u1_y1'];
dirPathTxtU1Y2 = [dirPathTxt '/skok_sterowania_u1_y2'];
dirPathTxtU2Y1 = [dirPathTxt '/skok_sterowania_u2_y1'];
dirPathTxtU2Y2 = [dirPathTxt '/skok_sterowania_u2_y2'];
mkDirectory(dirPathFigures);
mkDirectory(dirPathTxt);
mkDirectory(dirPathTxtU1Y1);
mkDirectory(dirPathTxtU1Y2);
mkDirectory(dirPathTxtU2Y1);
mkDirectory(dirPathTxtU2Y2);


delta_u = [0.4 0.8 -0.4 -0.8];

runStepResponse(delta_u, Kk, dirPathFigures, dirPathTxtU1Y1, 1, 'u1', 'y1');
runStepResponse(delta_u, Kk, dirPathFigures, dirPathTxtU1Y2, 1, 'u1', 'y2');
runStepResponse(delta_u, Kk, dirPathFigures, dirPathTxtU2Y1, 1, 'u2', 'y1');
runStepResponse(delta_u, Kk, dirPathFigures, dirPathTxtU2Y2, 1, 'u2', 'y2');

