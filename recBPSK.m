clear
clc
nbits = 100;
nchannels = 64;
fbasechannel = 800;
fs = 44100;
fswitch = 20;
deltaf = 120;
cable = 0; % 1 por cable, 0 por aire
record_duration = 15;
%%% Para comparar el resultado %%%
matload = load(['c' num2str(nchannels) 'b' num2str(nbits) '.mat']);
testmatrix = matload.testmatrix;
%testmatrix = random('bino',1,0.5,[nchannels nbits]);

%%% BPSK test %%%
disp('Escuchando Sonido...')
recObj = audiorecorder(44100,16,1);             %grabar audio
recordblocking(recObj, record_duration);    %grabación final
y = getaudiodata(recObj);           %play(recObj);

[Bsync,startlagB,stoplagB] = sincronizar(y,fs);
testdemodB = matdemB(transpose(Bsync), fbasechannel, fs, fswitch,nchannels,deltaf,cable);

effBPSK = sum(testmatrix==testdemodB,2);
%plot(Bsync)