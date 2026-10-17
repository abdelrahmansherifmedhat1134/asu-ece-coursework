% Telecommunication Networks - Assignment 1 CRC Validation
clc; clear;

% 1. Setup Data and Polynomial
% Data stream given in the assignment
data = [0 1 1 0 1 0 0 1 1 0 1 0 1 0 1 1 1 0 1]; 

% Generator polynomial x^5 + x^3 + 1 translates to 101001
poly = [1 0 1 0 0 1]; 
k = length(poly) - 1; % Number of CRC bits (degree of polynomial is 5)

%% --- Part 2: Calculate CRC Field & Transmitted Stream ---
fprintf('--- Part 2: Transmitted Stream ---\n');

% Append k zeros to the original data
padded_data = [data, zeros(1, k)];
temp = padded_data;

% Perform Modulo-2 division (XOR) simulating long division
for i = 1:length(data)
    if temp(i) == 1
        % XOR the polynomial with the current bits
        temp(i:i+k) = bitxor(temp(i:i+k), poly);
    end
end

% The remainder is the last k bits
crc_field = temp(end-k+1:end);
transmitted_stream = [data, crc_field];

disp('1. Calculated CRC Field:');
disp(crc_field);
disp('2. Full Transmitted Stream:');
disp(transmitted_stream);

%% --- Part 3: Calculate Remainder at Receiver (No Error) ---
fprintf('\n--- Part 3: Receiver Check (No Error) ---\n');

temp_rx = transmitted_stream;

% Perform Modulo-2 division at the receiver
for i = 1:length(data)
    if temp_rx(i) == 1
        temp_rx(i:i+k) = bitxor(temp_rx(i:i+k), poly);
    end
end

remainder_no_error = temp_rx(end-k+1:end);
disp('Receiver Remainder (Should be all zeros):');
disp(remainder_no_error);

%% --- Part 4: Calculate Remainder if Error in 6th Bit ---
fprintf('\n--- Part 4: Receiver Check (Error in 6th bit) ---\n');

% Introduce error in the 6th transmitted bit
rx_with_error = transmitted_stream;
% The ~ operator flips the bit (0 becomes 1, or 1 becomes 0)
rx_with_error(6) = ~rx_with_error(6); 

temp_rx_error = rx_with_error;

% Perform Modulo-2 division at the receiver on the corrupted data
for i = 1:length(data)
    if temp_rx_error(i) == 1
        temp_rx_error(i:i+k) = bitxor(temp_rx_error(i:i+k), poly);
    end
end

remainder_with_error = temp_rx_error(end-k+1:end);
disp('Receiver Remainder (Error detected):');
disp(remainder_with_error);