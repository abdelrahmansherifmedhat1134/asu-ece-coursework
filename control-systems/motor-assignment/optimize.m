
function optimize_controller_robust
    clc; clear; close all;
    R=pi/2;
    % Define Optimization Parameters
    Kp_range = 5:5:30;        % Range for Kp
    Td_range = 0.01:0.05:0.3; % Range for Td
    
    model_name = 'figure4_motor'; 

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

    %  Cascaded Loops 
    for i = 1:length(Kp_range)
        for j = 1:length(Td_range)
            
            
            current_Kp = Kp_range(i);
            current_Td = Td_range(j);
            
           
            assignin('base', 'Kp', current_Kp);
            assignin('base', 'Td', current_Td);
            
            % Run Simulation
            try
             
                res = sim(model_name); 
            catch ME
                warning('Sim failed for Kp=%.2f, Td=%.2f: %s', current_Kp, current_Td, ME.message);
                continue;
            end
            
          
            [e_vals, dt] = get_signal_data(res, 'simout2'); % Error signal
            [u_vals, ~]  = get_signal_data(res, 'simout1'); % Control signal
            
            % Calculate Cost
            n = min(length(e_vals), length(u_vals));
            e_vals = e_vals(1:n);
            u_vals = u_vals(1:n);
            
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
            end
        end
    end
    
    % Final Verification
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
    
    % for plotting
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

% HANDLE ALL DATA TYPES
function [vals, time_vec] = get_signal_data(sim_res, var_name)
    % 1. Check if the variable exists in the SimulationOutput
    if ~isprop(sim_res, var_name)
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
    
    %  "Timeseries" Object
    if isa(raw_data, 'timeseries')
        vals = raw_data.Data;
        time_vec = raw_data.Time;
        
    %Structure with Time"
    elseif isstruct(raw_data) && isfield(raw_data, 'signals') && isfield(raw_data, 'time')
        vals = raw_data.signals.values;
        time_vec = raw_data.time;
        
    % "Array"
    elseif isnumeric(raw_data)
        if isprop(sim_res, 'tout')
            time_vec = sim_res.tout;
            if length(raw_data) == length(time_vec)
                vals = raw_data;
            else
                [r, c] = size(raw_data);
                if c > 1 && length(raw_data) == length(time_vec)
                    vals = raw_data(:, 2:end); 
                else
                    vals = raw_data; 
                end
            end
        else
            vals = raw_data;
            time_vec = 1:length(vals);
        end
        
    % "Dataset" Object
    elseif isa(raw_data, 'Simulink.SimulationData.Dataset')
         el = raw_data.get(1);
         vals = el.Values.Data;
         time_vec = el.Values.Time;
    else
        error('Unknown data format for variable %s.', var_name);
    end
end