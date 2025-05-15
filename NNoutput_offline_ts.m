% --- parameters ----------------------------------------------------
Ts      = 0.001;                 % sample time (s)  ← 50 s / 50 000 steps
csvFile = 'predictions_all_hcwu_1';

% --- read file -----------------------------------------------------
M          = readmatrix(csvFile);        % size = [50 001  2]
throttle   = M(:,1);
Efd        = M(:,2);
t          = (0:size(M,1)-1)' * Ts;      % time vector 0 … 50 s

% --- build a single array [t  throttle  Efd] -----------------------
simInput_hcwu = [t  throttle  Efd];           % size = [50 001  3]

% vars base workspace so Simulink can see it
assignin('base','simInput',simInput_hcwu);
Ka = 200;
Ta = 0.03;
Efd_max = 7; 
Efd_min = 0; 