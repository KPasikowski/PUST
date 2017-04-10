function [ y ] = runStepResponse( deltas , Kk, dirPathFigures, dirPathTxt, toSaveAndPlot, controlSignal, outSignal )
    
    if strcmp(controlSignal, 'u1') && strcmp(outSignal, 'y1')
        plotYTitle = 'Odpowiedz skokowa obiektu ( u1 na y1 )';
        plotYLabel = 'u1';
        plotInSignalTitle = 'Sygnal sterowania u1';
        inSignalSubPath = '/sterowanie1_y1_skok_';
        outSignalSubPath = '/wyjscie_y1_u1_skok_';
        saveFigSubPath = '/zad2_odp_skok_ster_y1_u1.fig';
    elseif strcmp(controlSignal, 'u1') && strcmp(outSignal, 'y2')
        plotYTitle = 'Odpowiedz skokowa obiektu ( u1 na y2 )';
        plotYLabel = 'u1';
        plotInSignalTitle = 'Sygnal sterowania u1';
        inSignalSubPath = '/sterowanie1_y2_skok_';
        outSignalSubPath = '/wyjscie_y2_u1_skok_';
        saveFigSubPath = '/zad2_odp_skok_ster_y2_u1.fig';
    elseif strcmp(controlSignal, 'u2') && strcmp(outSignal, 'y1')
        plotYTitle = 'Odpowiedz skokowa obiektu ( u2 na y1 )';
        plotYLabel = 'u2';
        plotInSignalTitle = 'Sygnal sterowania u2';
        inSignalSubPath = '/sterowanie2_y1_skok_';
        outSignalSubPath = '/wyjscie_y1_u2_skok_';
        saveFigSubPath = '/zad2_odp_skok_ster_y1_u2.fig';
    elseif strcmp(controlSignal, 'u2') && strcmp(outSignal, 'y2')
        plotYTitle = 'Odpowiedz skokowa obiektu ( u2 na y2 )';
        plotYLabel = 'u2';
        plotInSignalTitle = 'Sygnal sterowania u2';
        inSignalSubPath = '/sterowanie2_y2_skok_';
        outSignalSubPath = '/wyjscie_y2_u2_skok_';
        saveFigSubPath = '/zad2_odp_skok_ster_y2_u2.fig';
    end
    
    u1 = zeros(Kk, 1);
    u2 = zeros(Kk, 1);
    y = zeros(Kk, 1);

    if toSaveAndPlot == 1
        figure;
    end
    
    for i = 1 : length(deltas)
        if strcmp(controlSignal, 'u1')
            u1(1:7) = 0;
            u1(8:Kk) = deltas(i);
            in = u1;
        else
            u2(1:7) = 0;
            u2(8:Kk) = deltas(i);
            in = u2;
        end

        for k = 8 : Kk
            if strcmp(outSignal, 'y1')
                y(k) = symulacja_obiektu6y1(u1(k-6), u1(k-7), u2(k-3), u2(k-4), y(k-1), y(k-2));
            else
                y(k) = symulacja_obiektu6y2(u1(k-5), u1(k-6), u2(k-6), u2(k-7), y(k-1), y(k-2));
            end
        end
      
        if toSaveAndPlot == 1
            subplot(2,1,1);
            rysujWykres((1 : length(y)), y, -1, 'k', outSignal, '', plotYTitle);
            hold on

            subplot(2,1,2);
            rysujWykres((1 : length(in)), in, -1, 'k', plotYLabel, '', plotInSignalTitle);
            hold on

            zapiszDoPliku([dirPathTxt outSignalSubPath  num2str(deltas(i)) '.txt'], y);
            zapiszDoPliku([dirPathTxt inSignalSubPath num2str(deltas(i)) '.txt'], in);
        end
    end

    if toSaveAndPlot == 1
        savefig([dirPathFigures saveFigSubPath]);
    end

end

