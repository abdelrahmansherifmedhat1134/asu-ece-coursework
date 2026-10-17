% Define the sequences
x1 = [1, 2, 3, 4, 5];
x2 = [2, -1, 1, -1];
N = 5;
% using MATLAB's built-in circular convolution:
y = cconv(x1, x2, N);

disp('Circular Convolution Result:');
disp(y);