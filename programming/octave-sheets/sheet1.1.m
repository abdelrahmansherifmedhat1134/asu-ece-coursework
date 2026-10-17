clc;
clear;
close all;
%%fm=100;
%%fc=10000;
fm=10;
fc=500;

%%Time domain

ts=0.1/fc;


%%plotting period

T=2/fm;
%% number of samples
N=ceil(T/ts);

%%time vector
t=0:ts:((N-1)*ts);

%%frequency domain


fs=1/ts;
df=fs/N;

%%even
if(rem(N,2)==0)
f=-(0.5*fs):df:(0.5*fs-df);

else %%odd
f= -(0.5*fs-0.5*df):df:(0.5*fs-0.5*df);

end


%%baseband signal
m=sin(2*pi*fm*t);
figure(1)
plot(t,m)
xlabel("time")
ylabel("m(t)")
box off


%%carrier frequency
c=cos(2*pi*fc*t);
figure(2)
plot(t,c)
ylabel("carrier c(t)")
xlabel("time")
box off


%%modulated signal
s=m.*c;
figure(3)
plot(t,s)
xlabel(time)
ylabel("modulated s")
box off

%%spectrum
M=fftshift(fft(m)*(1/N));
figure(4)
plot(f,abs(M))
xlabel("frequency")
ylabel("baseband M(f)")
box off



S=fftshift(fft(s)*(1/N));
figure(5)
plot(f,abs(S))
xlabel("frequency")
ylabel("modulated S(f)")
box off
