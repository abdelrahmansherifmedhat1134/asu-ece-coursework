% Slab Waveguide Confinement Factor - Separate Graphs for Each Eta
clear; clc; close all;

n1 = 1.5;
n2 = 1.4;
eta_values = [1.0, 1.070, 1.14]; % 1.0 is TE, >1 is TM
m_values = [0, 1, 2];            % Modes m = 0, 1, 2
V_max = 10;                      % Max V-number for the x-axis

colors = {'b', 'r', 'g'}; % Blue for m=0, Red for m=1, Green for m=2

for e_idx = 1:length(eta_values)
    eta = eta_values(e_idx);
    
    % Create a brand new figure window for each eta value
    figure; 
    hold on;
    legend_entries = {};
    
    for m_idx = 1:length(m_values)
        m = m_values(m_idx);
        
        % Sweep U between its strict physical limits for mode m
        % Adding 1e-4 prevents dividing by zero at the exact boundaries
        U_min = m * pi / 2 + 1e-4;
        U_max = (m + 1) * pi / 2 - 1e-4;
        
        U = linspace(U_min, U_max, 1000);
        
        % 1. Calculate W directly from the dispersion relation
        W = eta .* U .* tan(U - m * pi / 2);
        
        % 2. Calculate V directly
        V = sqrt(U.^2 + W.^2);
        
        % 3. Filter the arrays to only plot up to V_max = 10
        valid_idx = V <= V_max;
        U_valid = U(valid_idx);
        W_valid = W(valid_idx);
        V_valid = V(valid_idx);
        
        if isempty(V_valid)
            continue;
        end
        
        % 4. Calculate Confinement Factor (Gamma)
        P_core = 1 + cos(m*pi) .* sin(2*U_valid) ./ (2*U_valid);
        P_clad = (cos(U_valid - m*pi/2)).^2 ./ W_valid;
        
        Gamma = P_core ./ (P_core + eta .* P_clad);
        
        % Plot the curve
        plot(V_valid, Gamma, 'Color', colors{m_idx}, 'LineWidth', 2);
        
        % Format legend strings based on TE vs TM
        if eta == 1.0
            mode_str = 'TE';
        else
            mode_str = 'TM';
        end
        legend_entries{end+1} = sprintf('%s_%d', mode_str, m);
    end
    
    % Graph formatting for this specific figure
    grid on;
    ylim([0 1]);
    xlim([0 V_max]);
    xlabel('V-number');
    ylabel('Confinement Factor (\Gamma)');
    title(sprintf('Confinement Factor vs V-number (\\eta = %.3f)', eta));
    legend(legend_entries, 'Location', 'southeast');
end