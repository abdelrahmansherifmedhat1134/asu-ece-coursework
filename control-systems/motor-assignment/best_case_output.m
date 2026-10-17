function robust_optimization_run
    clc; close all;
    
    %% 1. Setup
    model_name = 'best_simulation.slx';
    
    % Define Grid Search Ranges
    % We start from small numbers to capture the performance curve
    Kp_range = 1 : 1 : 20;       
    Td_range = 0.01 : 0.02 : 0.3; 
    
    % Initialize Matrix for the 3D Plot
    J_surface = zeros(length(Td_range), length(Kp_range));
    
    fprintf('Running Optimization using Simulink Model: %s...\n', model_name);

    %% 2. The Optimization Loop
    for i = 1:length(Td_range)
        for j = 1:length(Kp_range)
            
            % Set gains to Base Workspace
            assignin('base', 'Kp', Kp_range(j));
            assignin('base', 'Td', Td_range(i));
            
            try
                % Run Simulink
                res = sim(model_name);
                
                % Extract Data (Safe Method)
                [e, dt] = get_sim_data(res, 'simout2'); % Error
                [u, ~]  = get_sim_data(res, 'simout1'); % Control Voltage
                
                % Ensure vectors are same length
                n = min(length(e), length(u));
                e = e(1:n); u = u(1:n);
                if length(dt) > 1, dt = dt(1:n); else, dt = repmat(dt, n, 1); end
                
                % COST FUNCTION
                % We slightly increase the penalty on 'u' to create a visible 3D curve
                % J = Sum(|e|) + 0.5 * Sum(|u|)
                J_surface(i, j) = sum(abs(e).*dt) + 0.5 * sum(abs(u).*dt);
                
            catch
                J_surface(i, j) = NaN; % If sim fails, skip point
            end
        end
        % Optional: Print progress dot every row
        fprintf('.');
    end
    fprintf('\nOptimization Complete.\n');

    %% 3. Process Results (Fixing the Plot3 Error)
    
    % Find minimum cost
    min_val = min(min(J_surface));
    
    % Find indices. If there are multiple identical minimums, find() returns a vector.
    [r_opt, c_opt] = find(J_surface == min_val);
    
    % FIX: Force it to pick only the FIRST optimal point found
    r_opt = r_opt(1);
    c_opt = c_opt(1);
    
    best_Kp = Kp_range(c_opt);
    best_Td = Td_range(r_opt);

    fprintf('---------------------------------\n');
    fprintf('Optimal Kp : %.2f\n', best_Kp);
    fprintf('Optimal Td : %.4f\n', best_Td);
    fprintf('Min Cost J : %.4f\n', min_val);
    fprintf('---------------------------------\n');

    %% 4. Plot 3D Surface
    figure('Color', 'w', 'Name', 'Figure 8: 3D Surface');
    
    [X_Kp, Y_Td] = meshgrid(Kp_range, Td_range);
    
    surf(X_Kp, Y_Td, J_surface);
    xlabel('Proportional Gain (K_p)');
    ylabel('Derivative Gain (T_d)');
    zlabel('Cost Function (J)');
    title('3D Performance Surface');
    
    shading interp;
    colormap jet;
    colorbar;
    view(135, 30);
    
    hold on;
    % Now best_Kp and best_Td are guaranteed to be single numbers (scalars)
    plot3(best_Kp, best_Td, min_val, 'ro', 'MarkerSize', 10, 'MarkerFaceColor', 'r');
    legend('Performance Surface', 'Optimal Point');
    
end

% --- Helper Function ---
function [vals, dt] = get_sim_data(sim_res, var_name)
    % Standardizes data extraction from Simulink
    raw = [];
    time = [];
    
    if isprop(sim_res, var_name)
        obj = sim_res.(var_name);
        if isa(obj, 'timeseries')
            raw = obj.Data; time = obj.Time;
        elseif isstruct(obj)
            raw = obj.signals.values; time = obj.time;
        elseif isnumeric(obj)
             % Array format
             if isprop(sim_res, 'tout'), time = sim_res.tout; else, time = (1:length(obj))'; end
             raw = obj;
        end
    elseif isprop(sim_res, 'yout')
        try
            ds = sim_res.yout.get(var_name);
            raw = ds.Values.Data; time = ds.Values.Time;
        catch
            error(['Could not find variable: ' var_name]);
        end
    end
    
    vals = raw;
    if ~isempty(time)
        dt = [diff(time); 0];
    else
        dt = 0.001; % Fallback
    end
end