parametry;

[s, u] = policz_odp_skok();

%wykres y
subplot(2,1,1);
stairs(s) ;
xlabel('k') ;
ylabel('s') ;
title('Odpowiedz skokowa znormalizowana') ;

%wykres u
subplot(2,1,2);
stairs(u) ;
xlabel('k') ;
ylabel('u') ;
title('Sygnal sterowania') ;