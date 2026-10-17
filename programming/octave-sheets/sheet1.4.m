clc;
close all
clear
pkg load signal

fc=200;
ts=0.1/fc;
T=100;
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

%%bandpass
m=besselj(0,t).*cos(2*pi*10*t);
m(t>10)=0;
figure(1)
plot(t,m)
box off

%%spectrum
M=fftshift(fft(m)*ts);
figure(2)
plot(f,abs(M))
box off
%%energy calculation
energy_total_time=sum((abs(m).^2))*ts;
energy_total_frequency=sum(abs(M).^2)*df
min_frequency=find(f==0);
max_frequency=length(f);
energy_acc=0;
for index=min_frequency:max_frequency
  energy_acc=df*(abs(M(index)).^2)+energy_acc;
  if(energy_acc>=(0.5*0.99*energy_total_frequency))
  bw=f(index);
  break
end
end
%%transmitting the upper side band only
%%carrier
c=cos(2*pi*fc*t);
%%modulated
s=m.*c;
figure(3)
plot(t,s)
box off
%%spectrum
S=fftshift(fft(s)*ts);
figure(4)
plot(f,abs(S))
hold on
box off

%%%%%%%%%%%%%%%%%%
HBPF=zeros(size(f));
HBPF(f>fc & f<bw+fc)=1;
HBPF(f<-fc & f>-fc-bw)=1;

plot(f,HBPF)
S=S.*HBPF;
figure(5)
plot(f,abs(S))


%%receiving the signal
s=ifft(ts*ifftshift(S));
g=s.*c;
G = fftshift(fft(g)*ts);
figure(6)
plot(f,abs(G))
hold all

%%LPF
HLPF=abs(f)<bw;
plot(f,abs(HLPF))
legend("signal","filter")

%%
MO=G.*HLPF;
figure(7)
plot(f,abs(MO))

mo=real(ifft(ts*ifftshift(MO)));
figure(8)
plot(t,mo/max(mo))
hold all
plot(t,m/max(m))
legend("received","transmitted")
