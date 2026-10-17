% --- ECE 331 Exp 1: Q4 Solution (Updated with Transmission) ---
clc; clear; close all;

% 1. Define Range of Angles (0 to 90 degrees)
theta_deg = 0:0.1:90;
theta_i = deg2rad(theta_deg);

% 2. Define Refractive Indices
n1 = 1.0; % Air
n2 = 1.3; % <--- YOUR GROUP 2 VALUE (1 + 2*0.15)

% 3. Anonymous Function for Fresnel Coefficients
% Calculates both Reflection (R) and Transmission (T)
calc_fresnel_RT = @(n1, n2, theta_i) deal( ...
    abs( (n1 .* cos(theta_i) - n2 .* sqrt(1 - (n1./n2 .* sin(theta_i)).^2)) ./ ...
         (n1 .* cos(theta_i) + n2 .* sqrt(1 - (n1./n2 .* sin(theta_i)).^2)) ).^2, ... % Rs
    abs( (n2 .* cos(theta_i) - n1 .* sqrt(1 - (n1./n2 .* sin(theta_i)).^2)) ./ ...
         (n2 .* cos(theta_i) + n1 .* sqrt(1 - (n1./n2 .* sin(theta_i)).^2)) ).^2  );  % Rp

% 4. Compute Reflection Coefficients (R)
[Rs, Rp] = calc_fresnel_RT(n1, n2, theta_i);

% 5. Compute Transmission Coefficients (T = 1 - R)
Ts = 1 - Rs;
Tp = 1 - Rp;

% 6. Plot Everything (Matching Figure 5 in Manual)
figure;
plot(theta_deg, Rs, 'b--', 'LineWidth', 1.5); hold on; % S-Reflect (Blue Dashed)
plot(theta_deg, Rp, 'r--', 'LineWidth', 1.5);         % P-Reflect (Red Dashed)
plot(theta_deg, Ts, 'b-', 'LineWidth', 2);            % S-Transmit (Blue Solid)
plot(theta_deg, Tp, 'r-', 'LineWidth', 2);            % P-Transmit (Red Solid)

% Formatting
title(['Power Coefficients for Group 2 (n_2 = ' num2str(n2) ')']);
xlabel('Angle of Incidence (degrees)');
ylabel('Power Coefficient (Ratio)');
legend('Rs (Reflection S)', 'Rp (Reflection P)', ...
       'Ts (Transmission S)', 'Tp (Transmission P)', 'Location', 'best');
grid on;
axis([0 90 0 1]);

% 7. Output Brewster Angle
brewster_angle = rad2deg(atan(n2/n1));
fprintf('Brewster Angle for n=%.2f is %.2f degrees.\n', n2, brewster_angle);