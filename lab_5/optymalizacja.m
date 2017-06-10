
for Td = 1:400
    [wynik, e, ~] = fmincon(@(x)(aproksymuj([x(1) x(2) x(3) Td])), [1 2 3], [], [], [], [], [0 0 0], []); 
    W(Td,:) = wynik;
    E(Td) = e;
end
% % % 
% % % fileTitle = ['zad3_aproks_W.txt'];
% % % filename = fopen(fileTitle,'w');
% % % for i=1:50(
% % %     fprintf(filename,'%5d ',i);
% % %     fprintf(filename,'%5d\n',W(i,:));
% % % end
% % % fclose(filename);
% % % 
% % % 
% % % fileTitle = ['zad3_aproks_E.txt'];
% % % filename = fopen(fileTitle,'w');
% % % for i=1:50
% % %     fprintf(filename,'%5d ',i);
% % %     fprintf(filename,'%5d\n',E(i));
% % % end
% % % fclose(filename);