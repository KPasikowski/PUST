parametry;

dirPathFigures = 'wykresy_figury/zad2';
dirPathTxt = 'wykresy_pliki/zad2';
dirPathTxtControl = [dirPathTxt '/skok_sterowania'];
dirPathTxtDist = [dirPathTxt '/skok_zaklocenia'];
mkDirectory(dirPathFigures);
mkDirectory(dirPathTxt);
mkDirectory(dirPathTxtControl);
mkDirectory(dirPathTxtDist);


delta_u = [0.4 0.8 -0.4 -0.8];
delta_z = [0.4 0.8 -0.4 -0.8];

runStepResponse(delta_u, Kk, dirPathFigures, dirPathTxtControl, 'sterowanie');
runStepResponse(delta_z, Kk, dirPathFigures, dirPathTxtDist, 'zaklocenie');

