clear;
close all;
clc;

b=[0.18,0.1,0.3,0.1,0.18];
a=[1,-1.15,1.5,-0.7,0.25];
n=[0:100];

%%impulse response
H_impulse=impz(b,a,101);
figure;
stem(n,H_impulse,"filled");
title("impulse response")

%%step response 
u_step=ones(101,1);
y_step=filter(b,a,u_step);
figure;
stem(n,y_step,"filled");
title('filter for step input')

%%convolution
y_conv=conv(H_impulse,u_step);
figure;
n_conv=[0:200];
stem(n_conv,y_conv,"filled");
title("convolution")

%%filter 
y_filter=filter(H_impulse,1,u_step);
figure;
stem(n,y_filter,"filled");
title("filter for impulse and i/p")
