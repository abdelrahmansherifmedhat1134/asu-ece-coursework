


clc; clear; close all; % 'clear' removes bad variables causing the size mismatch

%% 1. Define System Parameters (Added these so the script can run)
Km = 6.5335;      % Motor Gain
Tm = 0.0319;      % Motor Time Constant
R  = pi/2;        % Reference Input (Scalar value)

%% 2. Optimization Ranges
Kp_range = 10:5:30;
Td_range = 0.005:0.005:0.2;

dt = 0.001;
t = 0:dt:20*Tm;

s = tf('s');
G = Km/(Tm*s + 1);

J = zeros(length(Kp_range), length(Td_range));
IAE = zeros(length(Kp_range), length(Td_range));

%% 3. Optimization Loop
for i = 1:length(Kp_range)
    for j = 1:length(Td_range)
        Kp = Kp_range(i);
        Td = Td_range(j);
        
        % Linear Control Design
        C = Kp*(1 + Td*s);
        sys_cl = feedback(C*G,1);
        
        % Step Response
        % 'c' will be a column vector (N x 1)
        c = step(R*sys_cl, t);
        
        % Error Calculation
        % Since R is a scalar (pi/2) and c is a vector, this subtracts R from every element of c
        e = R - c; 
        
        % Calculate U (Control Effort) theoretically
        de = [0; diff(e)/dt];
        u = Kp*e + Kp*Td*de;
        
        % Cost Functions
        IAE(i,j) = sum(abs(e))*dt;
        J(i,j) = IAE(i,j) + 0.5*sum(abs(u))*dt;
    end
end

%% 4. Find and Display Optimal Values
[Jmin, idx] = min(J(:));
[i_opt, j_opt] = ind2sub(size(J), idx);

Kp_opt = Kp_range(i_opt)
Td_opt = Td_range(j_opt)
disp(['Minimum Cost (J): ', num2str(Jmin)]);

%% 5. Plotting
[Kp_grid, Td_grid] = meshgrid(Td_range, Kp_range); % Note: Meshgrid order X,Y

figure('Color','w');
surf(Kp_grid, Td_grid, J); % Suggestion: Plot J (Cost) instead of IAE to see optimization landscape
xlabel('Derivative Gain (T_d)');
ylabel('Proportional Gain (K_p)');
zlabel('Cost Function (J)');
title('3D Performance Surface');
shading interp;
colorbar;
view(135, 30);