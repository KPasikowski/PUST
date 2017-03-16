parametry ;

% porownanie odpowiedzi skokowych
% step(transCiagla,'b',transDyskr,'r-') ;
% xlabel('CZAS') ;
% ylabel('y') ;
% title('odpowiedz skokowa obiektu ciaglego i dyskretnego') ;
% legend( 'odpowiedz ciagla', 'odpowiedz dyskretna') ;

% porownanie wzmocnien statycznych
wzmocStatCiagle = evalfr( transCiagla, 0 ) ;
wzmocStatDyskr = evalfr( transDyskr, 1 ) ;