clc;clear;close all;

time=[0,2,4,5,6,7,8,9,10,11,12,13,14,15,16,17,20,22,24,26,28,30,32,34,36,38,40,42,44,48,52,56,60,64,68,72,76,80,84,90,96];
u=[52.6,53,51.8,47.7,46.5,44.6,42.7,41.6,39.7,38.4,35.6,34.6,33.6,32.5,31.2,30.2,26.6,25.1,23.7,22.5,20.9,19.8,18.9,17.6,16.8,16.4,15.4,14.9,14.4,13.7,12.8,12.5,11.7,11.02,10.8,10.6,10.5,10.5,10.5,10.2,10.2];
y=[3.2,2.9,3.8,6.6,8.1,8.8,10.2,10.9,12.3,13.9,15.1,15.8,16.5,17.3,18.2,18.9,21.5,22.5,23.5,24.3,25.5,26.2,27.1,27.7,28.3,28.6,29.2,29.6,29.9,30.5,31.1,31.3,31.8,32.2,32.4,32.6,32.6,32.7,32.7,32.9,32.9];
desired_height=(time.*0)+40;

% 1. Setup the Figure
figure;
title('Tank Level Control Response');
xlabel('Time (s)');
grid on;

% 2. Left Axis: Plot the Heights (Desired vs Actual)
yyaxis left
plot(time, y, 'b-', 'LineWidth', 2); hold on;
plot(time, desired_height, 'k--', 'LineWidth', 1.5);
ylabel('water level y(t) (cm)');
ylim([0 max(desired_height)*1.2]); % Give it some headroom

% 3. Right Axis: Plot the Control Signal (%)
yyaxis right
plot(time, u, 'r-', 'LineWidth', 1);
ylabel('Control Signal u(t) (%)');
ylim([0 110]); % Fixed range for percentage (0-110%)
hold on;
plot(time,desired_height);
% 4. Legend
legend('Actual Height y(t)', 'Desired Height', 'Control Signal u(t)');

figure;
plot(u,y);
xlabel("control signal u(t)")
ylabel("water level y(t)")



time2=[0,2,4,5,6,7,8,9,10,11,12,13,14,15,16,17,20,22,24,26,28,30,32,34,36,38,40,42,44,48,52,56,60,64,68,72,76,80,84,90,96,112,114,116,220,230,240,250,260,270,274,278,278,282,286,396,402,407,413,416,422,426,432,436,442,450,470,476,485,495,505,516,526];
u2=   [11.6,16.1,20.4,25.3,28.3,30.8,32.4,34.2,35,34.5,34.5,32.9,31.8,30.2,27.3,26,24.2,22.3,19.6,17.9,15.9,14,10.9,9,7.7,5.2,2.4,.6,0,0,0,0,0,0,0,0,0,0,0,0,0,1.3,2.5,2,0.3,0,0,0,.1,2,3.8,8,9,11.2,12.3,15.3,16.8,17,16.2,15.8,15,13.9,13.1,12.2,11.3,10.1,7.7,8.1,9.5,11.1,12.2,13.3,14.3];
y2=   [6.6,7.4,8.1,10.1,11.6,13.1,15,17.2,20.3,22.3,25.5,28,29.8,32,35.2,36.6,38.1,39.6,41.4,42.9,43.4,44.3,45.6,46.3,46.8,47.5,47.9,48.2,48.4,48.6,48.9,49,49.2,49.4,49.6,49.8,49.9,50.1,50.2,50.5,50.6,48.9,47.2,46.4,45.8,45,43.9,42.4,41.3,39.7,38.6,37.9,36.9,36.7,36.7,36.7,37,37.7,38.8,39.4,40.1,40.7,41,41.3,41.4,41.5,41.2,40,39.5,39,38.9,38.9,38.9];



% --- 2. Define Critical Values ---
setpoint = 40;
upper_bound = setpoint * 1.05; % 42
lower_bound = setpoint * 0.95; % 38
[max_y, idx_max] = max(y2);
time_at_max = time2(idx_max);

% =========================================================
% FIGURE 1: Combined Plot (Dual Axis)
% =========================================================
figure('Name', 'Combined Response', 'Color', 'w');
grid on; box on;

yyaxis left
plot(time2, y2, 'b-', 'LineWidth', 2);
ylabel('Output Height y(t)');
yline(setpoint, 'k-.', 'Setpoint (40)'); % Simple setpoint reference
ylim([0 60]);

yyaxis right
plot(time2, u2, 'r-', 'LineWidth', 1.5);
ylabel('Control Signal u(t) (%)');
ylim([-5 40]);

title('Combined System Response: Output vs Control Effort');
xlabel('Time (s)');
legend('Output y(t)', 'Setpoint', 'Control u(t)', 'Location', 'northeast');


% =========================================================
% FIGURE 2: Output y(t) ONLY (With Analysis Labels)
% =========================================================
figure('Name', 'Output Analysis', 'Color', 'w');
hold on; grid on; box on;

% 1. Plot 5% Error Bands (Subtle Dark Green)
% Using a custom dark green RGB [0.2 0.6 0.2] and thinner line
yline(upper_bound, 'Color', [0.2 0.6 0.2], 'LineStyle', '--', 'LineWidth', 1, 'Label', '+5%');
yline(lower_bound, 'Color', [0.2 0.6 0.2], 'LineStyle', '--', 'LineWidth', 1, 'Label', '-5%');

% 2. Plot Setpoint (Red)
yline(setpoint, 'r-.', 'LineWidth', 1.5, 'Label', 'Target (40)', 'LabelHorizontalAlignment', 'right');

% 3. Plot Actual Response (Blue)
plot(time2, y2, 'b-', 'LineWidth', 2);

% 4. Mark Maximum Overshoot (Mp)
plot(time_at_max, max_y, 'ko', 'MarkerFaceColor', 'k'); 
text(time_at_max, max_y + 2, ['M_p = ' num2str(max_y)], 'HorizontalAlignment', 'center', 'FontWeight', 'bold');
text(time_at_max, max_y - 2.5, ['t_p = ' num2str(time_at_max) 's'], 'HorizontalAlignment', 'center', 'FontSize', 8);

title('Output Response y(t) with Critical Points');
xlabel('Time (s)');
ylabel('Height');
ylim([0 55]);
legend('5% Bounds', '', 'Setpoint', 'Response y(t)');


% =========================================================
% FIGURE 3: Control Signal u(t) ONLY
% =========================================================
figure('Name', 'Control Effort', 'Color', 'w');
hold on; grid on; box on;

% 1. Plot Control Signal (Red)
plot(time2, u2, 'r-', 'LineWidth', 2);

% 2. Mark Saturation (u=0)
% Find the saturation region manually for labeling
sat_start = 44; 
sat_end = 112;
% Draw a bracket or line indicating this region
line([sat_start sat_end], [1 1], 'Color', 'k', 'LineWidth', 1);
text((sat_start+sat_end)/2, 3, 'Actuator Saturation', 'HorizontalAlignment', 'center');

title('Control Signal u(t)');
xlabel('Time (s)');
ylabel('Control Effort (%)');
ylim([-2 40]);