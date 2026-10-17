function analyze_saturated_motor
    clc; close all;
    
    % --- 1. Define Global Parameters ---
    % These must exist for the Simulink model to run successfully
    global Ka Kb Ra La b Ea Tf
    Ka = 1e-2;
    Kb = 1e-1;
    Ra = 1e-1;
    La = 1e-2;
    b  = 5e-3;
    Ea = 10;   
    Tf = 2.0;  % Ensure this is long enough for the system to settle
    
    % --- 2. Run SATURATED Simulation ---
    model_name = "figure4_motor";
    
    try
        res_sat = sim(model_name);
    catch
        error(['Could not run model: ' model_name '.slx. Make sure the file is on your path.']);
    end
    
    % --- 3. Extract Data Safely ---
    t_sat     = res_sat.tout;       
    theta_raw = res_sat.simout;     % Output Angle
    
    % Handle data types (Timeseries object vs Array)
    if isa(theta_raw, 'timeseries')
        y = theta_raw.Data;
    else
        y = theta_raw;
    end
    
    % --- 4. Calculate 2% Error Bands ---
    % We assume the final value in the simulation is the Steady State value.
    y_final = pi/2;
    
    % Calculate the +2% and -2% limits
    upper_limit = y_final * 1.02; % +2%
    lower_limit = y_final * 0.98; % -2%
    
    fprintf('Final Value: %.4f rad\n', y_final);
    fprintf('Upper Limit (1.02): %.4f rad\n', upper_limit);
    fprintf('Lower Limit (0.98): %.4f rad\n', lower_limit);

    % --- 5. Plot Output with Error Bands ---
    figure('Name', 'Saturated Response Analysis', 'Color', 'w');
    
    % Plot the System Response
    plot(t_sat, y, 'b', 'LineWidth', 2); hold on;
    
    % Plot the Steady State Reference Line (Green)
    yline(y_final, 'g-', 'Steady State', 'LineWidth', 1);
    
    % Plot the 2% Error Bands (Red Dashed)
    yline(upper_limit, 'r--', '+2% Error', 'LabelHorizontalAlignment', 'left');
    yline(lower_limit, 'r--', '-2% Error', 'LabelHorizontalAlignment', 'left');
    
    % Formatting
    grid on;
    title(['Saturated Motor Response with 2% Error Bands']);
    xlabel('Time (s)'); 
    ylabel('Angle (rad)');
    legend('System Response', 'Steady State', '2% Bounds');
    
    % Adjust Y-axis limits to verify the bands clearly
    % (Zoom in slightly around the final value if desired, or keep auto)
    ylim([0, y_final * 1.2]); 
end