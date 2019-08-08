function [ mod,duration,t ] = BPSK( bitstream,fsym,fs,fswitch )
largo=length(bitstream);

tswitchus=1000000/fswitch;
tswitch = tswitchus/1000000;

tsus = 1000000/fs;
ts = tsus/1000000;
t=0:ts:tswitch;

signal=[];

for i=1:largo
   % Ver qué combinación de bits es cada chunk para definir n
   n = bitstream(i);
   
   chunkmod = cos(2*pi*fsym*t + n*pi).*((sin(2*pi*fswitch/2*t)).^2);
   
   signal = [signal chunkmod];
end

mod=signal;
duration=max(t);
end

