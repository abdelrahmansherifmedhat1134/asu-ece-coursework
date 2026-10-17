clc;clear; close all;

%% 1. System Parameters (From your identification)
Km = 6.5335;      % Motor Gain
Tm = 0.0319;      % Motor Time Constant

%% 2. Design Requirements
zeta = 0.5;       % Damping ratio
ts_req = 4 * Tm;  % Required settling time

% Calculate Natural Frequency (wn)
% Formula: ts = 4 / (zeta * wn)
wn = 4 / (zeta * ts_req);

%% 3. Calculate Controller Gains
% Derivation for your specific "Derivative on Output" diagram:
% Characteristic Eq: s^2 + (1 + Km*Td)/Tm * s + (Km*Kp)/Tm = 0

% A. Calculate Proportional Gain (Kp)
% Matches natural frequency term: wn^2 = (Km * Kp) / Tm
Kp = (wn^2 * Tm) / Km;

% B. Calculate Derivative Gain (Td)
% Matches damping term: 2*zeta*wn = (1 + Km * Td) / Tm
% Note: This Td acts as the total Kd gain in your diagram
Td = ((2 * zeta * wn * Tm) - 1) / Km;

%% 4. Define Reference Input
R = pi/2;  % The value for your 'R' block

%% 5. Display Results
fprintf('--------------------------------------------------\n');
fprintf('Calculated Values for Simulink Workspace:\n');
fprintf('--------------------------------------------------\n');
fprintf('Kp (Proportional Gain) : %.4f\n', Kp);
fprintf('Td (Derivative Gain)   : %.4f\n', Td);
fprintf('R  (Reference Input)   : %.4f (rad)\n', R);
fprintf('--------------------------------------------------\n');
fprintf('You can now run your Simulink model.\n');