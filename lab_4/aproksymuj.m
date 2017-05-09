function [ E, S, Sapr ] = aproksymuj( in )


T1 = in(1);
T2 = in(2);
K  = in(3);
Td = in(4);

s=load('odpskok_y_21.txt');
Ysk = (s(:,2) - 32) / 21;
%S = Ysk((Td+3):end);
S = Ysk(1:end);
Usk = ones(1,300);
%Usk(1:30) = 0;
%Usk(1 : 400) = 1;


al1 = exp(-1/T1);
al2 = exp(-1/T2);

a1 = al1 - al2;
a2 = al1 * al2;

b1 = K*(1/(T1-T2))*(al1*T1*(1-al1) - al2*T2*(1-al2));
b2 = K*(1/(T1-T2))*(al1*T2*(1-al2) - al2*T1*(1-al1));

Sapr = zeros(1, 300);

for i = (Td+3):300
    Sapr(i) = b1*Usk(i - Td - 1) + b2*Usk(i - Td -  2) - a1*Sapr(i - 1) - a2*Sapr(i - 2);
end
%Sapr  = Sapr((Td+3):end);
S=S';
E = (S - Sapr)*(S - Sapr)';
% fileTitle = ['zad3_norm_yz.txt'];
% filename = fopen(fileTitle,'w');
% for i=1:liczba_pomiarow
%     fprintf(filename,'%5d ',i);
%     fprintf(filename,'%5d\n',Y(i));
% end
% fclose(filename);
% fileTitle = ['zad3_apr_yz.txt'];
% filename = fopen(fileTitle,'w');
% for i=1:liczba_pomiarow
%     fprintf(filename,'%5d ',i);
%     fprintf(filename,'%5d\n',Y(i));
% end
% fclose(filename);
