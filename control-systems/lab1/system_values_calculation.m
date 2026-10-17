clc;
clear;
close all;


load('data_pitch_10_8.mat');

function [K, tau] = estimate_first_order_params(time, input_signal, output_signal)
   
    d_input = diff(input_signal);
    threshold = max(abs(d_input)) * 0.5; % Threshold to detect the step
    step_idx = find(abs(d_input) > threshold, 1, 'first');
    
    if isempty(step_idx)
        error('No step input detected.');
    end
   
    idx_start = step_idx + 1;
    t_start = time(idx_start);

    u_initial = mean(input_signal(1:step_idx)); % Average before step
    u_final = mean(input_signal(end-50:end));   % Average at steady state
    delta_u = u_final - u_initial;

    % Output Step Size
    y_initial = output_signal(idx_start);       % Value at moment of step
    y_final = mean(output_signal(end-50:end));  % Steady state value
    delta_y = y_final - y_initial;

    % 3. Calculate Gain (K)
    K = delta_y / delta_u;

    % 4. Calculate Time Constant (tau)
    % Target value is 63.2% of the way from initial to final
    y_target = y_initial + 0.632 * delta_y;

    % Find the index where output crosses the target value
    % We restrict search to times AFTER the step occurred
    post_step_range = idx_start:length(output_signal);
    [~, min_idx] = min(abs(output_signal(post_step_range) - y_target));
    
    % Map back to global index
    idx_63 = post_step_range(min_idx);
    t_63 = time(idx_63);

    tau = t_63 - t_start;

    % Display Results
    fprintf('------------------------------------------------\n');
    fprintf('First-Order System Identification Results:\n');
    fprintf('Step Time:    %.4f s\n', t_start);
    fprintf('Input Step:   %.2f -> %.2f (Delta: %.2f)\n', u_initial, u_final, delta_u);
    fprintf('Steady State: %.2f\n', y_final);
    fprintf('Gain (K):     %.4f\n', K);
    fprintf('Time Const (tau): %.4f s\n', tau);
end



%%10V dataset


fprintf('Processing 10V Dataset...\n');
[K10, tau10] = estimate_first_order_params(time_10, input_10, output_10);

%% 8V dataset
fprintf('\nProcessing 8V Dataset...\n');
[K8, tau8] = estimate_first_order_params(time_8, input_8, output_8);

%% average
K_avg = (K10 + K8) / 2;
tau_avg = (tau10 + tau8) / 2;

fprintf('\nFinal Estimated Model:\n');
fprintf('G(s) = %.4f / (%.4f s + 1)\n', K_avg, tau_avg);