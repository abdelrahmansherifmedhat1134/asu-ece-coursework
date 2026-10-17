function plot_figure7_control_effort
    clc; close all;
    
    % --- 1. Define Parameters (Ensure these match your design) ---
    % Use the values you calculated in Phase II
    Kp = 19.19;    % Replace with your calculated Kp if different
    Td = 0.008;    % Replace with your calculated Td if different
    
    % Push variables to Workspace so Simulink can see them
    assignin('base', 'Kp', Kp);
    assignin('base', 'Td', Td);
    
    % --- 2. Run Simulations ---
    % Make sure these names match your actual Simulink filenames
    model_linear = 'figure3_motor.slx'; 
    model_sat    = 'figure4_motor.slx'; 

    fprintf('Simulating Linear Model (%s)...\n', model_linear);
    res_lin = sim(model_linear);
    
    fprintf('Simulating Saturated Model (%s)...\n', model_sat);
    res_sat = sim(model_sat);
    
    % --- 3. Extract Control Signals (u) ---
    % 'simout1' is the Control Signal based on your block diagrams
    [u_lin, t_lin] = get_data(res_lin, 'simout1');
    [u_sat, t_sat] = get_data(res_sat, 'simout1');
    
    % --- 4. Generate Figure 7 ---
    figure('Name', 'Figure 7: Control Effort Comparison');
    set(gcf, 'Color', 'w'); % Make background white for the report
    
    % Plot Linear Signal
    plot(t_lin, u_lin, 'b', 'LineWidth', 1.5); hold on;
    
    % Plot Saturated Signal
    plot(t_sat, u_sat, 'r--', 'LineWidth', 1.5);
    
    % Add Limit Lines (Visual Reference for +/- 10V)
    yline(10, 'k:', 'Saturation Limit (+10V)');
    yline(-10, 'k:', 'Saturation Limit (-10V)');
    
    % Formatting
    grid on;
    xlabel('Time (s)', 'FontSize', 12);
    ylabel('Control Voltage (V)', 'FontSize', 12);
    title('Comparison of Control Effort: Linear vs. Saturated', 'FontSize', 14);
    legend('Linear Controller Output', 'Saturated Controller Output', 'Location', 'Best');
    
    % Adjust Y-axis to see the linear spike clearly (optional)
    % ylim([-15 15]); 
    
    fprintf('Figure 7 generated successfully.\n');
end

% --- Helper to extract data safely ---
function [vals, time] = get_data(res, varName)
    if isa(res.(varName), 'timeseries')
        vals = res.(varName).Data;
        time = res.(varName).Time;
    elseif isa(res.(varName), 'struct')
        vals = res.(varName).signals.values;
        time = res.(varName).time;
    else
        % Dataset format
        ds = res.yout.get(varName);
        vals = ds.Values.Data;
        time = ds.Values.Time;
    end
end