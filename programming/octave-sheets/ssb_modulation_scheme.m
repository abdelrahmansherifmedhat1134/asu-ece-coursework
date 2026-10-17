clc;
clear
close all
pkg load signal



fm=18;
fc=50;
%%assuming fc=50khz not 50 hz
%%fc=50000;

ts=0.1/fc;
T=100/fm;
N=ceil(T/ts);
t=0:ts:(N-1)*ts;
fs=1/ts;
df=fs/N;

if(rem(N,2)==0)
f=-(0.5*fs):df:((0.5*fs)-df);
else
f=-((0.5*fs)-(0.5*df)):df:((0.5*fs)-(0.5*df));
end
%%

%%baseband
m=cos(2*pi*fm*t);
m(t>9)=0;

%%baseband spectrum
M=fftshift(fft(m)*ts);

%%carrier
c=cos(2*pi*fc*t);

%%modulated
s=c.*m;


%%spectrum of modulated
S=fftshift(fft(s)*ts);



%%eneergy calculation
energy_total_frequency=sum(abs(M).^2)*df;
%%or
energy_total_time=sum(m.^2)*ts;
%%bandwidth
min_freq=find(f==0);
max_freq=length(f);
energy_acc=0;
for index=min_freq:max_freq
  energy_acc=(df*(abs(M(index)).^2))+energy_acc;
  if (energy_acc>=(0.5*0.99*energy_total_frequency))
    bw=f(index);
    break
  end
end
%%



%%bandpass filter first way using bandwidth
H1=zeros(size(f));
H1(f<fc & f>fc-bw)=1;
H1(f<(-(fc-bw)) & f>(-fc))=1;
figure(1)
plot(f,abs(H1))
hold on
plot(f,abs(S))
legend("filter","modulated")
xlabel("frequency")
box off

%ssb11
S11=S.*H1;


%%LPF filter second way from -fc to fc
H2=abs(f)<fc;
figure(2)
plot(f,abs(H2))
hold on
plot(f,abs(S))
legend("filter","modulated")
xlabel("frequency")
box off
%%SSb12
S12=S.*H2;



%%quadrature cancelling second way
%%hilbert transform
c1=cos(2*pi*fc*t);
c2=sin(2*pi*fc*t);

mh=imag(hilbert(m));   %%hilbert is the imaginary part of analytic
s2=(m.*c1)+(mh.*c2);
S2=fftshift(fft(s2)*ts);
%%SSB2
S2=abs(S2);

%%comparison of quadrature with first filter
figure(3)
plot(f,S2/max(S2))
hold on
plot(f,S11/max(S11))
legend("S11","S2")
box off

%%comparison of quadrature with second filter
figure(4)
plot(f,S2/max(S2))
hold on
plot(f,abs(S12/max(S12)))
legend("S12","S2")
box off


%%%%yes it can be restored by coherent detector

%%step 1: multiply by carrier
s=ifft(ifftshift(S2)*1/ts);
g=s.*c;

%%step 2: LPF to remove high frequency component
G=fftshift(fft(g)*ts);
H3=abs(f)<fc;
G=H3.*G;
%%display both orginal and received
figure(5)
plot(f,abs(G/max(G)));
hold on
plot(f,abs(M/max(M)))
legend("received","original")
xlabel("frequency")
box off
