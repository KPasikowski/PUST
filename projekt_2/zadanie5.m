parametry;

z(1 : Kk) = 0;

% z1(1 : 200) = 0;
% z1(201 : Kk) = 1;

% x = (1 : 1 : Kk);
% f = 500;
% fs = 8000;
% z2 = sin(2*pi*f/fs*x);

[y1, u1, E1] = policzDMC(200, 200, 200, 200, 10, Kk, z, 0);
% [y2, u2, E2] = policzDMC(200, 200, 200, 200, 10, Kk, z1, 1);