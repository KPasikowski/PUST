parametry;


delta_u = [0.4 0.8 -0.4 -0.8];
u = zeros(Kk, 1);

y = zeros(Kk, 1) + 0.8;

figure ;
for i = 1 : length(delta_u)
    u(1:11) = Upp;
    u(12:Kk) = Upp + delta_u(i);
    
    for k = 12 : Kk
       y(k) = symulacja_obiektu4Y(u(k-10), u(k-11), y(k-1), y(k-2));
    end

    %wykres y
    subplot(2,1,1);
    stairs(y) ;
    xlabel('k') ;
    ylabel('y') ;
    title('Odpowiedz skokowa obiektu') ;
    hold on

    %wykres u
    subplot(2,1,2);
    stairs(u) ;
    xlabel('k') ;
    ylabel('u') ;
    title('Sygnal sterowania') ;
    
    hold on

end
