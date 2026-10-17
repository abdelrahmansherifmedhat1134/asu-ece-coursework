clc;
close all;
res=sim("Motor_1_2021a.slx");
c_t=res.simout;
t=res.tout;
global Km; 
global Tm;
Ea_vector=ones(size(t))*Ea;
Ea_vector(1)=0;

function [k,tau] = estimate_parameters(u,y,t)
    %%input signal manipulation
    d_u=diff(u);
    threshold = max(abs(d_u()))*0.5;
    step_idx = find(abs(d_u)>threshold,1,'first');

    %%output signal
    idx_start =step_idx+1;
    t_start=t(idx_start);

    %%input signal data
    u_initial=mean(u(1:step_idx));
    u_final=mean(u(end-50:end));
    delta_u=u_final-u_initial;
    
    %%output manipulation
    y_initial= y(idx_start);
    y_final=mean(y(end-50:end));
    delta_y=y_final-y_initial;

    %%calculating gain k
    k=delta_y/delta_u;

    %%calculating tau
    idx_range=idx_start:length(y);
    y_tau=y_initial+0.632*delta_y;
    tau_step=find(y>y_tau,1,'first');
    [~, min_idx] = min(abs(y(idx_range)-y_tau));

    idx_63=idx_range(min_idx);
    t_63=t(idx_63);
    tau=t_63-t_start;

    %%result printinig
    fprintf("first order system parameters are \n");
    fprintf("step start time %.2f\n",t_start);
    fprintf("input step %.2f\n",u_final);
    fprintf("steady state output %.2f\n",y_final);
    fprintf("Gain(Km) %.4f \n",k);
    fprintf("Time constant(Tm) %.4f \n",tau);

end 

[Km,Tm]=estimate_parameters(Ea_vector,c_t,t);



% --- 1. Generate the Estimated Data ---
% Formula: y(t) = Final_Value * (1 - e^(-t/tau))
y_simple_motor = (Km * Ea) * (1 - exp(-t / Tm));

%plot comparison
figure('Color', 'w'); 
hold on; grid on; box on;

% Plot Actual Simulation (Thick Blue Line)
plot(t, c_t, 'b-', 'LineWidth', 3); 

% Plot Estimated Model (Dashed Red Line)
plot(t, y_simple_motor, 'r--', 'LineWidth', 2);

% --- 3. Add Labels ---
title('Model Validation: Simulation vs. Estimated First-Order Fit');
xlabel('Time (s)');
ylabel('Output Speed (rad/s)');
legend('Actual Simulation Output', 'Estimated First-Order Model', 'Location', 'southeast');

% Optional: Calculate "Goodness of Fit" (R-squared)
res_error = c_t - y_simple_motor;
SStot = sum((c_t - mean(c_t)).^2);
SSres = sum(res_error.^2);
R2 = 1 - SSres/SStot;
text(mean(t), mean(c_t)*0.5, sprintf('Fit R^2 = %.4f', R2), 'BackgroundColor', 'w');