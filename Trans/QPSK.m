function [ mod,duration,t ] = QPSK( bitstream,fsym,fs,fswitch )
largo=length(bitstream);

tswitchus=1000000/fswitch;
tswitch = tswitchus/1000000;

tsus = 1000000/fs;
ts = tsus/1000000;
t=0:ts:tswitch;

signal=[];

for i=1:largo/2
   % Ver qué combinación de bits es cada chunk para definir n
   test = bitstream(2*i-1:2*i);
   
   if test == [0 0]
       n=1;
   elseif test == [0 1]
       n=2;
   elseif test == [1 0]
       n=3;
   else
       n=4;
   end
   
   phase = [pi/4 3*pi/4 5*pi/4 7*pi/4];
   chunkmod = cos(2*pi*fsym*t + phase(n)).*((sin(2*pi*fswitch/2*t)).^2);
   signal = [signal chunkmod];
end

mod=signal;
duration=max(t);
end

