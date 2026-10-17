clc;
clear 
close all
load("data_pitch_10_8.mat");

%%first input
figure;
plot(time_8,input_8);
ylabel("step input of 8")
xlabel("time")

figure;
plot(time_8,output_8);
title("Rotor speed at input 8V")
ylabel("rotor speed")
xlabel("time")


%%second input
figure;
plot(time_10,input_10);
ylabel("step input of 10V")
xlabel("time")

figure;
plot(time_10,output_10);
title("Rotor speed at input 10V")
ylabel("rotor speed")
xlabel("time")


%%plotting both outputs to compare

figure;

plot(time_10, output_8, 'r', 'LineWidth', 1); 
hold on;

plot(time_10,output_10, 'g', 'LineWidth', 1); 

hold off;

legend('8V output', '10V output');
xlabel('Time(s)');
ylabel('Rotor speed');
title('Comparison of output rotor speeds at different step inputs');
grid on;


figure;

subplot(2,1,1);
yyaxis left
plot(time_10, input_10, 'b-', 'LineWidth', 1.5);
ylabel('Motor Voltage (V)');
ylim([0 max(input_10)*1.2]); % Adjust y-limits for better view

yyaxis right
plot(time_10, output_10, 'r-', 'LineWidth', 1.5);
ylabel('Rotor Speed (rad/s or RPM)');
xlabel('Time (s)');
title('Response: Motor Voltage vs Rotor Speed (Dataset 10)');
legend('Voltage', 'Speed');
grid on;

subplot(2,1,2);
yyaxis left
plot(time_8, input_8, 'b-');
ylabel('Motor Voltage (V)');
ylim([0 max(input_8)*1.2]);

yyaxis right
plot(time_8, output_8, 'r-');
ylabel('Rotor Speed (rad/s or RPM)');
xlabel('Time (s)');
title('Response: Motor Voltage vs Rotor Speed (Dataset 8)');
legend('Voltage', 'Speed');
grid on;