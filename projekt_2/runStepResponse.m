function [ y ] = runStepResponse( deltas , Kk, dirPathFigures, dirPathTxt, toSaveAndPlot, signalType )
    
    if strcmp(signalType, 'sterowanie')
        plotYTitle = 'Odpowiedz skokowa obiektu (skok sterowania)';
        plotYLabel = 'u';
        plotInSignalTitle = 'Sygnal sterowania';
        inSignalSubPath = '/sterowanie_skok_';
        saveFigSubPath = '/zad2_odp_skok_ster.fig';
    else
        plotYTitle = 'Odpowiedz skokowa obiektu (skok zaklocenia)';
        plotYLabel = 'z';
        plotInSignalTitle = 'Sygnal zaklocenia';
        inSignalSubPath = '/zaklocenie_skok_';
        saveFigSubPath = '/zad2_odp_skok_zakl.fig';
    end
    
    u = zeros(Kk, 1);
    z = zeros(Kk, 1);
    y = zeros(Kk, 1);

    if toSaveAndPlot == 1
        figure;
    end
    
    for i = 1 : length(deltas)
        if strcmp(signalType, 'sterowanie')
            u(1:6) = 0;
            u(7:Kk) = deltas(i);
            in = u;
        else
            z(1:6) = 0;
            z(7:Kk) = deltas(i);
            in = z;
        end

        for k = 7 : Kk
           y(k) = symulacja_obiektu3y(u(k - 5), u(k - 6), z(k - 2), z(k - 3), y(k - 1), y(k - 2));
        end
      
        if toSaveAndPlot == 1
            subplot(2,1,1);
            rysujWykres((1 : length(y)), y, -1, 'k', 'y', '', plotYTitle);
            hold on

            subplot(2,1,2);
            rysujWykres((1 : length(in)), in, -1, 'k', plotYLabel, '', plotInSignalTitle);
            hold on

            zapiszDoPliku([dirPathTxt '/wyjscie_skok_'  num2str(deltas(i)) '.txt'], y);
            zapiszDoPliku([dirPathTxt inSignalSubPath num2str(deltas(i)) '.txt'], in);
        end
    end

    if toSaveAndPlot == 1
        savefig([dirPathFigures saveFigSubPath]);
    end

end

