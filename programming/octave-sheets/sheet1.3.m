clc;
clear
close all
pkg load signal;

ts=0.001;
T=100
N=ceil(T/ts);
t=0:ts:((N-1)*ts);

fs=1/ts;
df=fs/N;

if(rem(N,2)==0)
f=-(0.5*fs):df:((0.5*fs)-df);
else
f=-((0.5*fs)-(0.5*df)):df:((0.5*fs)-(0.5*df));
end
%%


%%baseband signal
m=besselj(0,t);
m(t>10)=0;
figure(1)
plot(t,m)
xlabel("time")
ylabel("m(t)")
box off
%%spectrum
M=fftshift(fft(m)*ts);
figure(2)
plot(f,abs(M));
xlabel("frequency")
ylabel("M(f)")
box off


%%energy calculation
energy_time_domain=sum(abs(m).^2)*ts;
energy_total_frequency=sum(abs(M).^2)*df;


%%bandwidth
zero_frequency=find(f==0);
max_frequency=length(f);
energy_acc=0;
for index=zero_frequency:max_frequency
  energy_acc = (df*abs(M(index).^2)) + energy_acc;
  if (energy_acc>0.5*0.99*energy_total_frequency)
    bw=f(index);
    break
  end
end
%%


ka=-1/min(m);
envelope=1+ka*m;

%%carrier
fc=10*bw;
c=cos(2*pi*fc*t);
s=envelope.*c;

figure(2)
plot(t,envelope)
box off
figure(3)
plot(t,s)
box off
 %%spectrum

M=fftshift(fft(s)*ts);
figure(4)
plot(f,abs(M))
box off
 %% received
 g=abs(hilbert(s));
 figure(5)
 plot(t,g)
 hold on
 plot(t,m)
