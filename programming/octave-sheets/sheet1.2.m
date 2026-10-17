clc;
clear
close all


fm=10;
fc=10000;

T=2/fm;
ts=0.1/fc;

N=T/ts;

fs=1/ts;
df=fs/N;

t=0:ts:((N-1)*ts);

if(rem(N,2)==0)

f=(-0.5*fs):df:((0.5*fs)-(df))
else
f=(-(0.5*fs)+(0.5*df)):df:((0.5*fs)-(0.5*df))
end

%%baseband
m=cos(2*pi*fm*t);

%%carrier
c=cos(2*pi*fc*t);

%%modulated
s=m.*c;
figure(1)
plot(t,s)
xlabel("time")
ylabel("modulated s(t)")
box off

%%modulated spectrum
S=fftshift(fft(s)*(1/N));
figure(2)
plot(f,abs(S))
xlabel("frequency")
ylabel("modulated s(f)")
box off



%%demodulated
g=s.*c;
figure(3)
plot(t,g)
xlabel("time")
ylabel("demodulated g(t)")
box off

%%modulated spectrum
G=fftshift(fft(g)*(1/N));
figure(4)
plot(f,abs(G))
xlabel("frequency")
ylabel("demodulated G(f)")
box off
hold on


%%LPF
LPF_BW=110;

H=abs(f)<LPF_BW;
%%figure(5)
plot(f,abs(H))

%%after LPF
MO=G.*H;
figure(5)
plot(f,abs(MO))
xlabel("frequency")
ylabel("restored")
box off

%%time domain of restored
mo=ifft(ifftshift(MO)*N);
figure(7)
plot(t,mo);
hold on
plot(t,m)
legend("received msg","transmitted msg")
xlabel("time")
ylalbel("g(t)")
box off

