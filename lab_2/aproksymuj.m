function [ E, S, Sapr ] = aproksymuj( in )

s=load('odp_skok_y');
%s = load('zad2_odpskok_z_30');
Ysk = (s.Y - 35) / 10;
%Ysk = (s.Y - 35) / 30;
S = Ysk(32:end);

Usk = ones(1,400);
Usk(1:30) = 0;
Usk(31 : 400) = 1;

T1 = in(1);
T2 = in(2);
K  = in(3);
Td = in(4);

al1 = exp(-1/T1);
al2 = exp(-1/T2);

a1 = -al1 - al2;
a2 = al1 * al2;

b1 = K*(1/(T1-T2))*(T1*(1-al1) - T2*(1-al2));
b2 = K*(1/(T1-T2))*(al1*T2*(1-al2) - al2*T1*(1-al1));

Sapr = zeros(1, 400);

for i = 32:400
    Sapr(i) = b1*Usk(i - Td - 1) + b2*Usk(i - Td -  2) - a1*Sapr(i - 1) - a2*Sapr(i - 2);
end
 
 Sapr  = Sapr(32:end);
 E = (S - Sapr)*(S - Sapr)';
% fileTitle = ['nowe/odp_skok_y_apr.txt'];
% filename = fopen(fileTitle,'w');
% for i=1:length(Sapr)
%     fprintf(filename,'%5d ',i);
%     fprintf(filename,'%5d\n',Sapr(i));
% end
% fclose(filename);
% fileTitle = ['nowe/odp_skok_z_apr.txt'];
% filename = fopen(fileTitle,'w');
% for i=1:length(Sapr)
%     fprintf(filename,'%5d ',i);
%     fprintf(filename,'%5d\n',Sapr(i));
% end
% fclose(filename);

%y:
%Td = 18 T1 = 3.609168861782780 T2 = 61.238792528906856 K = 0.301635313421735
%z:
%Td = 27 T1 = 81.44247 T2 = 0.6081137 K = 0.1504728