function optimize_controller_robust
    clc; clear; close all;
    
    % --- 1. Define Optimization Parameters ---
    Kp_range = 5:5:30;        % Range for Kp
    Td_range = 0.01:0.05:0.3; % Range for Td
    
    model_name = 'figure4_motor'; % <--- CHECK THIS NAME matches your file
    
    % FIX 1: Save the system to prevent the Java "UnsavedChanges" crash
    if bdIsLoaded(model_name)
        save_system(model_name);
    else
        load_system(model_name);
        save_system(model_name);
    end

    min_J = inf;
    best_Kp = 0;
    best_Td = 0;
    
    fprintf('Starting Optimization (Robust Mode)...\n');

    % --- 2. Cascaded Loops ---
    for i = 1:length(Kp_range)
        for j = 1:length(Td_range)
            
            % Update Workspace Variables
            current_Kp = Kp_range(i);
            current_Td = Td_range(j);
            assignin('base', 'Kp', current_Kp);
            assignin('base', 'Td', current_Td);
            
            % Run Simulation
            try
                res = sim(model_name, 'SrcWorkspace', 'current');
            catch ME
                warning('Sim failed for Kp=%.2f, Td=%.2f: %s', current_Kp, current_Td, ME.message);
                continue;
            end
            
            % FIX 2: Universal Data Extractor
            % We pass the whole 'res' object and the variable name we want
            [e_vals, dt] = get_signal_data(res, 'simout2'); % Error signal
            [u_vals, ~]  = get_signal_data(res, 'simout1'); % Control signal
            
            % Calculate Cost
            % Ensure arrays are same length (sometimes off by 1 step)
            n = min(length(e_vals), length(u_vals));
            e_vals = e_vals(1:n);
            u_vals = u_vals(1:n);
            
            % If dt is scalar (fixed step), create vector. If vector, trim it.
            if length(dt) > 1
                dt = dt(1:n); 
            else
                dt = repmat(dt, n, 1);
            end

            sum_error  = sum(abs(e_vals) .* dt);
            sum_effort = sum(abs(u_vals) .* dt);
            
            current_J = sum_error + (0.5 * sum_effort);
            
            if current_J < min_J
                min_J = current_J;
                best_Kp = current_Kp;
                best_Td = current_Td;
                % fprintf('New Best: J=%.4f (Kp=%.2f, Td=%.3f)\n', min_J, best_Kp, best_Td);
            end
        end
    end
    
    % --- 3. Final Verification ---
    fprintf('\n--------------------------------------\n');
    fprintf('OPTIMIZATION COMPLETE\n');
    fprintf('Best Cost (J) : %.4f\n', min_J);
    fprintf('Best Kp       : %.2f\n', best_Kp);
    fprintf('Best Td       : %.3f\n', best_Td);
    fprintf('--------------------------------------\n');
    
    assignin('base', 'Kp', best_Kp);
    assignin('base', 'Td', best_Td);
    
    fprintf('Running final verification simulation...\n');
    res_final = sim(model_name);
    
    % Safe extraction for plotting
    [y_final, t_final] = get_signal_data(res_final, 'simout');   % Angle
    [u_final, ~]       = get_signal_data(res_final, 'simout1');  % Voltage

    figure('Name', 'Optimized Response');
    subplot(2,1,1);
    plot(t_final, y_final, 'LineWidth', 2);
    grid on; title(['Optimized Output (Kp=' num2str(best_Kp) ', Td=' num2str(best_Td) ')']); 
    ylabel('Angle (rad)');
    
    subplot(2,1,2);
    plot(t_final, u_final, 'r', 'LineWidth', 1.5);
    grid on; title('Control Effort'); ylabel('Volts'); xlabel('Time (s)');
end

% --- HELPER FUNCTION TO HANDLE ALL DATA TYPES ---
function [vals, time_vec] = get_signal_data(sim_res, var_name)
    % 1. Check if the variable exists in the SimulationOutput
    if ~isprop(sim_res, var_name)
        % Fallback: Sometimes it's inside a Dataset called 'logsout' or 'yout'
        if isprop(sim_res, 'yout') && isa(sim_res.yout, 'Simulink.SimulationData.Dataset')
            try
                ds = sim_res.yout.get(var_name);
                vals = ds.Values.Data;
                time_vec = ds.Values.Time;
                return;
            catch
            end
        end
        error('Variable "%s" not found in simulation output.', var_name);
    end

    raw_data = sim_res.(var_name);
    
    % 2. Handle "Timeseries" Object (The most common modern format)
    if isa(raw_data, 'timeseries')
        vals = raw_data.Data;
        time_vec = raw_data.Time;
        
    % 3. Handle "Structure with Time"
    elseif isstruct(raw_data) && isfield(raw_data, 'signals') && isfield(raw_data, 'time')
        vals = raw_data.signals.values;
        time_vec = raw_data.time;
        
    % 4. Handle "Array" (Matrix format: [Time, Data] or just [Data])
    elseif isnumeric(raw_data)
        % If we have access to 'tout', use it for time
        if isprop(sim_res, 'tout')
            time_vec = sim_res.tout;
            
            % Check dimensions. If data is transposed relative to time, fix it.
            if length(raw_data) == length(time_vec)
                vals = raw_data;
            else
                % Sometimes Array format includes time in the first column
                % if "Time" checkbox is ticked in SaveToWorkspace block
                [r, c] = size(raw_data);
                if c > 1 && length(raw_data) == length(time_vec)
                    vals = raw_data(:, 2:end); % Assume col 1 is time or redundant
                else
                    vals = raw_data; % Hope for the best
                end
            end
        else
            % No time vector found, just return raw indices
            vals = raw_data;
            time_vec = 1:length(vals);
        end
        
    % 5. Handle "Dataset" Object (Simulink default)
    elseif isa(raw_data, 'Simulink.SimulationData.Dataset')
         % Usually getting the first element is safe if it's a single signal
         el = raw_data.get(1);
         vals = el.Values.Data;
         time_vec = el.Values.Time;
         
    else
        error('Unknown data format for variable %s. Please check Simulink "To Workspace" settings.', var_name);
    end
    
    % Final Check: Return 'dt' (delta time) if asked, or full time vector
    % For this specific script, we return the vector, and calculate dt outside if needed.
end
