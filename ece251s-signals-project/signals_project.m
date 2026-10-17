% Read the audio file
[audioData, fs] = audioread("input.wav");  % any audio file; the original team recording is not published

% Time vector
t = (0:length(audioData)-1)/fs;

% Plot the audio signal in time domain
figure;
plot(t, audioData);
xlabel('Time (seconds)');
ylabel('Amplitude');
title('Audio Signal in Time Domain');
grid on;

% Energy from time domain
energy_time = sum(audioData.^2);
disp(['Energy in time domain = ', num2str(energy_time)]);
%----------------------------------------------------------------------
%frequency domain

% Use one channel because stereo
if size(audioData, 2) > 1
    audioData = audioData(:,1);  % Use the left channel
end

N = length(audioData);       % Number of samples
f = fs * (0:(N-1))/N;        % Frequency axis

% FFT and magnitude
Y = fft(audioData);
magY = abs(Y);               % Magnitude spectrum

% Plot only the first half (positive frequencies)
half_N = floor(N/2);
figure;
plot(f(1:half_N), magY(1:half_N));
xlabel('Frequency (Hz)');
ylabel('Magnitude');
title('Frequency Domain Representation');
grid on;

% Energy in frequency domain using Parseval's theorem
energy_freq = sum(abs(Y).^2) / N;
disp(['Energy in frequency domain = ', num2str(energy_freq)]);

%-------------------------------------------------------------------------
%filtering using LPF

% Choose cutoff frequency of low pass filter(in Hz)
cutoff_freq = 4000;  % you can change this

% Normalize the frequency: divide by Nyquist frequency
Wn = cutoff_freq / (fs/2);

% Design 10th-order Butterworth LPF or HPF
[b_lpf, a_lpf] = butter(10, Wn, 'low');  % LPF



% Apply LPF
filtered_lpf = filter(b_lpf, a_lpf, audioData);

% FFT of filtered signal
Y_filt = fft(filtered_lpf);  % or filtered_hpf
magY_filt = abs(Y_filt);

% Frequency axis
N = length(filtered_lpf);
f = fs*(0:N-1)/N;

% Plot
figure;
plot(f(1:floor(N/2)), magY_filt(1:floor(N/2)));
xlabel('Frequency (Hz)');
ylabel('Magnitude');
title('Filtered Signal in Frequency Domain');
grid on;


%two overlapped freq
figure;
plot(f(1:half_N), magY(1:half_N),'b-', 'LineWidth', 0.5);
hold on;
plot(f(1:floor(N/2)), magY_filt(1:floor(N/2)),'r--','LineWidth', 1);
xlabel('Frequency (Hz)');
ylabel('Magnitude');
title('Both Signals in Frequency Domain');
grid on;


%signal in time domain
% Time vector
t = (0:length(filtered_lpf)-1)/fs;

% Plot
figure;
plot(t, filtered_lpf);
xlabel('Time (s)');
ylabel('Amplitude');
title('Filtered Signal in Time Domain');
grid on;

%two overlapped time
figure;
plot(t, filtered_lpf);
hold on;
plot(t, audioData);
xlabel('Time (s)');
ylabel('Amplitude');
title('Both signals in Time Domain');
grid on;
%------------------------------------------------------------------------
%saving the filtered audio file

%ensuring range is from -1 to 1

filtered_lpf = filtered_lpf / max(abs(filtered_lpf));  % Normalize to avoid clipping
audiowrite('filtered_output.wav', filtered_lpf, fs);

%-------------------------------------------------------------------------
%filtering using HPF
% Choose cutoff frequency of high pass filter(in Hz)
cutoff_freq = 350;  % you can change this

% Normalize the frequency: divide by Nyquist frequency
Wn = cutoff_freq / (fs/2);

% Design 10th-order Butterworth LPF or HPF
[b_hpf, a_hpf] = butter(10, Wn, 'high'); % HPF

% Apply HPF
filtered_hpf = filter(b_hpf, a_hpf, audioData);