S = load('odpskok1');
S = S.S;
% tmp = zeros(21,1);
% tmp(22:500) = S;
% S = tmp;
lambda = 5;
D = 450;
N = D;
Nu = N;

sD = S(1:D);
sN = S(1:N); 

M  = zeros(N,Nu);
M(:,1) = sN;
for iter=1:(Nu-1)
    sN = sN([end 1:end-1]);
    sN(1) = 0;
    M(:,iter+1) = sN;
end;
K = (M'*M+lambda*eye(Nu))\M';
ke1 = sum(K(1,:));

Mp = zeros(N,D-1);
for i=1:(D-1)
    for j=1:N
        if (i+j) <= D
            Mp(j,i) = sD(j+i,1)-sD(i,1);
        else
            Mp(j,i) = sD(D,1)-sD(i,1);
        end
    end
end
ku1 = K(1,:)*Mp;

S = load('odpskok2');
S = S.S;
% tmp = zeros(21,1);
% tmp(22:500) = S;
% S = tmp;
lambda = 10;
D = 450;
N = D;
Nu = N;

sD = S(1:D);
sN = S(1:N);   
M  = zeros(N,Nu);
M(:,1) = sN;
for iter=1:(Nu-1)
    sN = sN([end 1:end-1]);
    sN(1) = 0;
    M(:,iter+1) = sN;
end;
K = (M'*M+lambda*eye(Nu))\M';
ke2 = sum(K(1,:));

Mp = zeros(N,D-1);
for i=1:(D-1)
    for j=1:N
        if (i+j) <= D
            Mp(j,i) = sD(j+i,1)-sD(i,1);
        else
            Mp(j,i) = sD(D,1)-sD(i,1);
        end
    end
end
ku2 = K(1,:)*Mp;