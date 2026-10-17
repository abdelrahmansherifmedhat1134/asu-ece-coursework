clc; 
close all;
load("data_pitch_10_8.mat");

figure;
plot(t,pitch_raw_extracted);
title("accelerometer plot")
xlabel('Time(s)');
ylabel('Pitch Angle (radians)');

figure;
plot(t,pitch_gyro_extracted);
title("gyro plot")
xlabel('Time(s)');
ylabel('Pitch Angle (radians)');


figure;
plot(t,pitch_encoder_extracted);
title("encoder plot")
xlabel('Time(s)');
ylabel('Pitch Angle (radians)');

%%plotting all to compare

figure;

plot(t, pitch_raw_extracted, 'r', 'LineWidth', 1); 
hold on;

plot(t, pitch_gyro_extracted, 'g', 'LineWidth', 1); 

plot(t, pitch_encoder_extracted, 'b', 'LineWidth', 1); 
hold off;

legend('Accelerometer', 'Gyroscope', 'Encoder');
xlabel('Time(s)');
ylabel('Pitch Angle (radians)');
title('Comparison of Pitch Angles: Accelerometer, Gyro, and Encoder');
grid on;
