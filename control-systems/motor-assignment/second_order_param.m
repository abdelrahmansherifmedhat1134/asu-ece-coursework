%% Controller Design Script for DC Motor Position Control
%  System: PD Control with Derivative on Measurement
%  Constraints: Damping ratio (xi) = 0.5, Settling Time (ts) = 4*Tm
function [Kp,Td]=second_order_params(Km,Tm)
clc;
% 2. DESIGN REQUIREMENTS
xi = 0.5;  % Damping Ratio (zeta)
%%ts_target = 4 * Tm; % Target Settling Time (2% criterion)
ts_target= 4*Tm;
fprintf('----------------------------------------\n');
fprintf('Design Requirements:\n');
fprintf('   Target Damping (xi): %.2f\n', xi);
fprintf('   Target Settling Time: %.4f s\n', ts_target);
fprintf('----------------------------------------\n');
%CALCULATE GAINS
%Calculate required Natural Frequency (wn)
% Formula: ts = 4 / (xi * wn)  -->  wn = 4 / (xi * ts)
wn = 4 / (xi * ts_target);
%Calculate Td (Derivative Gain)
% Derivation: 2*xi*wn = (1 + K*Td) / Tm
% Rearranging for Td:
Td = (2 * xi * wn * Tm - 1) / Km;
%Calculate Kp (Proportional Gain)
% Derivation: wn^2 = (K * Kp) / Tm
% Rearranging for Kp:
Kp = (wn^2 * Tm) / Km;
% OUTPUT RESULTS
fprintf('Calculated Controller Gains:\n');
fprintf('   Kp = %.4f\n', Kp);
fprintf('   Td = %.4f\n', Td);
fprintf('----------------------------------------\n');

%VERIFICATION (Optional)

% This section verifies if the calculated gains theoretically meet the specs.
fprintf('Verification:\n');
actual_wn = sqrt((Km * Kp) / Tm);
actual_xi = (1 + Km * Td) / (2 * Tm * actual_wn);
actual_ts = 4 / (actual_xi * actual_wn);

fprintf('   Resulting wn: %.4f rad/s\n', actual_wn);
fprintf('   Resulting xi: %.4f (Target: 0.5)\n', actual_xi);
fprintf('   Resulting ts: %.4f s (Target: %.4f s)\n', actual_ts, ts_target);
end

[Kp,Td]=second_order_params(Km,Tm);

