clc;
clear
close all
fm = 100;
fc = 10000;
ts=0.1/fc; %%sampling frequency "should be greater than 2fc so i chose here to be equal 10fc "
T= 2/fm;
N=ceil(T/ts);
t= 0 : ts : (N-1)*ts;
fs=1/ts;
df=fs/N;
if (rem(N,2)==0) %%even N
  f = -fs/2 : df : (fs/2)-df ;
else %% odd
  f = -((fs/2)-df) : df : ((fs/2)-df);
end %% end
%%

%%baseband signal
m=sin(2*pi*fm*t);
figure(1)
plot(t,m)
xlabel('time domain')
ylabel('m(t)')
box off

%%carrier signal
c= cos(2*pi*fc*t);
figure(2)
plot(t,c)
xlabel('time domain')
ylabel('c(t)')
box off

%%modulated signal
s=m.*c;
figure(3)
plot(t,s)
xlabel('time domain')
ylabel('modulated')
box off

%% baseband in frequency domain
M=fftshift( fft( m ))/N ;
figure(4)
plot(f,abs(M))
stem(f,abs(M))
xlabel('m(f)')
ylabel('frequency domain')
box off
%% modulated in frequency domain
S = fftshift( fft( s ) )/N;
figure(5)
stem(f,abs(S))
xlabel('frequency domain')
ylabel('S(f)')
box off

%%demodulation
g = s.*c;
G = fftshift( fft( g ) )/N;
figure(6)
plot(f,abs(G))
xlabel('frequency')
ylabel('G')
box off

