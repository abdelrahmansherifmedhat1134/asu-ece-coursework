% =========================================================================
% ECE 431: Semiconductor Laser Simulation
% Student ID: 2300100
% =========================================================================
clear; clc; close all;

%% 1. Parameters Definition
% Constants
q = 1.602e-19;      % Electron charge (C)
c = 2.998e10;       % Speed of light in vacuum (cm/s)
h = 6.626e-34;      % Planck's constant (J*s)
lambda = 1.55e-4;   % Emission wavelength (cm) - Assumed 1550 nm

% ID Derived Parameters (ID: 2300100)
X = 0;
Y = 0;
L_um = 200 + 30 * X;         % Cavity Length (um)
R = 0.3 + 0.02 * Y;          % Reflectivity

% --- ADDED OUTPUT: Display L and R to Command Window ---
fprintf('=======================================\n');
fprintf('Student ID: 2300100\n');
fprintf('Calculated Cavity Length (L): %.2f um\n', L_um);
fprintf('Calculated Mirror Reflectivity (R): %.2f\n', R);
fprintf('=======================================\n');

% Convert geometry to cm for calculations
L = L_um * 1e-4;             % Cavity length (cm)
W = 2 * 1e-4;                % Active region width (cm)
d = 0.2 * 1e-4;              % Active layer thickness (cm)
V = L * W * d;               % Active volume (cm^3)

% Table Parameters
Gamma = 0.3;                 % Confinement factor
n_g = 4;                     % Group refractive index
alpha_int = 40;              % Internal loss (cm^-1)
B = 2.5e-16;                 % Differential gain (cm^2)
No = 1e18;                   % Transparency carrier density (cm^-3)
tau = 2.2e-9;                % Carrier lifetime (s)
beta_sp = 1e-4;              % Spontaneous emission factor

% Derived Optical Parameters
vg = c / n_g;                        % Group velocity (cm/s)
alpha_m = (1 / L) * log(1 / R);      % Mirror loss (cm^-1)
tau_p = 1 / (vg * (alpha_int + alpha_m)); % Photon lifetime (s)

% Group parameters into a struct to pass to the ODE solver
params.q = q; params.V = V; params.vg = vg; params.B = B; 
params.No = No; params.tau = tau; params.Gamma = Gamma; 
params.tau_p = tau_p; params.beta_sp = beta_sp;

%% 2. Theoretical Threshold Current Calculation
g_th = (alpha_int + alpha_m) / Gamma;
N_th = No + g_th / B;
I_th_theory = (q * V * N_th) / tau;
fprintf('Theoretical Threshold Current (I_th): %.2f mA\n', I_th_theory * 1000);
fprintf('=======================================\n');

%% 3. Task A: Transient Response
% I is stepped from 0 to 50mA at t = 1ns
I_steady = 50e-3; % 50 mA

% Time span for the solver
tspan1 = [0 1e-9];   % 0 to 1 ns (I = 0)
tspan2 = [1e-9 5e-9]; % 1 ns to 5 ns (I = 50mA)

% Initial conditions [N(0), S(0)]
y0 = [0; 0];

% Solve for t = 0 to 1ns (I = 0)
options = odeset('RelTol', 1e-6, 'AbsTol', 1e-12);
[t1, y1] = ode15s(@(t, y) rate_equations(t, y, 0, params), tspan1, y0, options);

% Solve for t = 1ns to 5ns (I = 50mA)
y_initial_2 = y1(end, :); % Take the last state as initial condition
[t2, y2] = ode15s(@(t, y) rate_equations(t, y, I_steady, params), tspan2, y_initial_2, options);

% Combine time and results
t_total = [t1; t2];
S_total = [y1(:, 2); y2(:, 2)];

% Plot Transient Response
figure(1);
plot(t_total * 1e9, S_total, 'b', 'LineWidth', 1.5);
grid on;
xlabel('Time (ns)');
ylabel('Photon Density S (cm^{-3})');
title('Transient Response - ID: 2300100');

%% 4. Task B: Static L-I Characteristic
I_sweep = linspace(0, 60e-3, 60); % 0 to 60 mA sweep
P_out = zeros(size(I_sweep));

% Steady-state solver loop
for i = 1:length(I_sweep)
    % Run simulation long enough to reach steady state (e.g., 10 ns)
    [~, y_ss] = ode15s(@(t, y) rate_equations(t, y, I_sweep(i), params), [0 10e-9], [0; 0], options);
    
    % Extract steady state photon density
    S_ss = y_ss(end, 2);
    
    % Calculate single-facet output power (Watts)
    % P_out = (1/2) * vg * alpha_m * S * (V/Gamma) * (h*c/lambda)
    E_photon = (h * c * 100) / lambda; % Photon energy in Joules (lambda in cm converted to m)
    P_out(i) = 0.5 * vg * alpha_m * S_ss * (V / Gamma) * E_photon;
end

% Plot L-I Curve
figure(2);
plot(I_sweep * 1000, P_out * 1000, 'r', 'LineWidth', 2); % Plot in mA and mW
grid on;
xlabel('Injection Current I (mA)');
ylabel('Single-Facet Output Power (mW)');
title('L-I Characteristic Curve - ID: 2300100');

%% 5. Rate Equations Function
function dy = rate_equations(~, y, I, p)
    % Unpack state variables
    N = y(1); % Carrier density
    S = y(2); % Photon density
    
    % Material gain
    g = p.B * (N - p.No);
    
    % Differential equations
    dN_dt = I / (p.q * p.V) - N / p.tau - p.vg * g * S;
    dS_dt = p.Gamma * p.vg * g * S - S / p.tau_p + p.Gamma * p.beta_sp * N / p.tau;
    
    dy = [dN_dt; dS_dt];
end