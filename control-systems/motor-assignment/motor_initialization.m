clc;clear;close all;
function motor_test
clc
global Ka Kb Ra La b Ea Tf

Ka=1e-2;
Kb=1e-1;
Ra=1e-1;
La=1e-2;
b=5e-3;
Ea=10;
Tf=0.2;

res=sim("Motor_1_2021a.slx");
c_t=res.simout;
t=res.tout;
plot(t,c_t);grid;
end 

motor_test;


