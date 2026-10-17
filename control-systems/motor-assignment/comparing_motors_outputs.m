R=pi/2;
sim_time=20*Tm;
function compare_motors
    clc;close all;
    
    
    global Ka Kb Ra La b Ea Tf
    Ka = 1e-2;
    Kb = 1e-1;
    Ra = 1e-1;
    La = 1e-2;
    b  = 5e-3;
    Ea = 10;   % Note: In closed loop, this might be overridden by the controller
    Tf = 2.0;  % Simulation time (increased to 2s to see settling)

 
    res_lin = sim("figure3_motor.slx"); 
    
    t_lin     = res_lin.tout;       % Time vector
    theta_lin = res_lin.simout;     % Output Angle (c)
    u_lin     = res_lin.simout1;    % Controller Output (u)
    e_lin     = res_lin.simout2;    % Error Signal (e)

    res_sat = sim("figure4_motor.slx");
    
    t_sat     = res_sat.tout;       % Time vector
    theta_sat = res_sat.simout;     % Output Angle (c)
    u_sat     = res_sat.simout1;    % Controller Output (u)
    e_sat     = res_sat.simout2;    % Error Signal (e)


    figure('Name', 'Comparison: Angle');
  
    
    if isa(theta_lin, 'timeseries'), y1 = theta_lin.Data; else, y1 = theta_lin; end
    if isa(theta_sat, 'timeseries'), y2 = theta_sat.Data; else, y2 = theta_sat; end
    
    plot(t_lin, y1, 'r', 'LineWidth', 1.5); hold on;
    plot(t_sat, y2, 'b--', 'LineWidth', 1.5);
    grid on;
    legend('Linear', 'Saturated');
    title('Output Angle c(t)');
    xlabel('Time (s)'); ylabel('Angle (rad)');

    figure('Name', 'Comparison: Control Signal');
    
    if isa(u_lin, 'timeseries'), u1 = u_lin.Data; else, u1 = u_lin; end
    if isa(u_sat, 'timeseries'), u2 = u_sat.Data; else, u2 = u_sat; end

    plot(t_lin, u1, 'r', 'LineWidth', 1.5); hold on;
    plot(t_sat, u2, 'b--', 'LineWidth', 1.5);
    grid on;
    legend('Linear', 'Saturated');
    title('Controller Output u(t)');
    xlabel('Time (s)'); ylabel('Voltage (V)');


   
    function score = calculate_IAE(time_vec, error_obj)
    
        if isa(error_obj, 'timeseries')
            e_data = error_obj.Data;
        else
            e_data = error_obj;
        end
        
      
        dt = diff(time_vec);
        

        score = sum(abs(e_data(1:end-1)) .* dt);
    end

  
    iae_linear = calculate_IAE(t_lin, e_lin);
    iae_sat    = calculate_IAE(t_sat, e_sat);
    
    fprintf('--------------------------------------------------\n');
    fprintf('PART F RESULTS: IAE Comparison\n');
    fprintf('--------------------------------------------------\n');
    fprintf('Linear Model IAE    : %.4f\n', iae_linear);
    fprintf('Saturated Model IAE : %.4f\n', iae_sat);
    fprintf('--------------------------------------------------\n');
end
compare_motors;
