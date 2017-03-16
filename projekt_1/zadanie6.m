parametry;

%PID
[paramsPID1, ~, ~] = fmincon(@policzPID, [2 10 3.2], [], [], [], [], [0 0.1 0], []); 
[paramsPID2, ~, ~] = ga(@policzPID, 3, [], [], [], [], [0 0.1 0], []);

%DMC
% [paramsDMC1, ~, ~] = fmincon(@policzDMC, [125 125 10], [], [], [], [], [0 0 0], []); 
[paramsDMC2, ~, ~] = ga(@policzDMC, 3, [], [], [], [], [1 1 0], [Kk Kk Inf], [], [1 2]);