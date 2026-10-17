%% FIR Filter Design Specifications
wp = 0.3 * pi;  % Passband edge frequency (rad/sample)
ws = 0.5 * pi;  % Stopband edge frequency (rad/sample)
Ap = 0.5;       % Passband ripple (dB)
As = 50;        % Minimum stopband attenuation (dB)

% Ideal cutoff frequency is the midpoint of the transition band
wc = (wp + ws) / 2;
% Transition bandwidth
delta_w = ws - wp;

%% (a) Fixed Window Design
% To achieve a stopband attenuation of at least 50 dB, we need a Hamming window.
% (Rectangular = ~21dB, Bartlett = ~25dB, Hanning = ~44dB, Hamming = ~53dB)

% The empirical transition width for a Hamming window is approx 8*pi / N.
% Therefore, the required length N is:
N_hamming = ceil(8 * pi / delta_w);

% Ensure the filter length is odd (even order) to create a Type I linear phase filter
if mod(N_hamming, 2) == 0
    N_hamming = N_hamming + 1;
end
order_hamming = N_hamming - 1;

% Design the filter using fir1
% Note: fir1 takes normalized frequency where 1.0 corresponds to pi
h_fixed = fir1(order_hamming, wc/pi, 'low', hamming(N_hamming));


%% (b) Kaiser Window Design
% MATLAB provides 'kaiserord' to automatically compute the optimal filter 
% order and beta parameter based on the exact ripple specifications.

% Convert frequencies to normalized values (0 to 1, where 1 corresponds to pi)
f_edges = [wp/pi, ws/pi]; 
mags = [1 0]; % Desired amplitudes (1 for passband, 0 for stopband)

% Convert dB specifications to linear deviations
dev_p = (10^(Ap/20) - 1) / (10^(Ap/20) + 1);
dev_s = 10^(-As/20);
devs = [dev_p, dev_s];

% Calculate Kaiser parameters
[order_kaiser, Wn, beta, ftype] = kaiserord(f_edges, mags, devs);
N_kaiser = order_kaiser + 1;

% Design the filter
h_kaiser = fir1(order_kaiser, Wn, ftype, kaiser(N_kaiser, beta));


%% Output Comparison to Command Window
fprintf('--- Filter Length Comparison ---\n');
fprintf('Fixed Window (Hamming) Length: %d\n', N_hamming);
fprintf('Kaiser Window Length: %d\n', N_kaiser);
fprintf('--------------------------------\n');


%% Plotting the Results
% Use freqz to compute the frequency response (1024 points for smooth curves)
[H_fixed, w] = freqz(h_fixed, 1, 1024);
[H_kaiser, ~] = freqz(h_kaiser, 1, 1024);

% Convert magnitude to Decibels
mag_fixed_dB = 20*log10(abs(H_fixed));
mag_kaiser_dB = 20*log10(abs(H_kaiser));

figure('Name', 'FIR Filter Design Comparison', 'Position', [100, 100, 800, 500]);

% Plot Fixed Window (Hamming)
subplot(2,1,1);
plot(w/pi, mag_fixed_dB, 'LineWidth', 1.5);
hold on;
yline(-As, 'r--', 'Stopband Spec (-50 dB)');
xline(wp/pi, 'g--', '\omega_p');
xline(ws/pi, 'm--', '\omega_s');
hold off;
title(['(a) Hamming Window FIR Filter (Length N = ', num2str(N_hamming), ')']);
ylabel('Magnitude (dB)');
xlabel('Normalized Frequency (\times \pi rad/sample)');
grid on;
ylim([-100 10]);

% Plot Kaiser Window
subplot(2,1,2);
plot(w/pi, mag_kaiser_dB, 'LineWidth', 1.5);
hold on;
yline(-As, 'r--', 'Stopband Spec (-50 dB)');
xline(wp/pi, 'g--', '\omega_p');
xline(ws/pi, 'm--', '\omega_s');
hold off;
title(['(b) Kaiser Window FIR Filter (Length N = ', num2str(N_kaiser), ')']);
ylabel('Magnitude (dB)');
xlabel('Normalized Frequency (\times \pi rad/sample)');
grid on;
ylim([-100 10]);