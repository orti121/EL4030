clear
clc
nbits = 100;
nchannels = 64;
fbasechannel = 800;
fs = 44100;
fswitch = 20;
deltaf = 120;

matload = load(['c' num2str(nchannels) 'b' num2str(nbits) '.mat']);
testmatrix = matload.testmatrix;
%testmatrix = random('bino',1,0.5,[nchannels nbits]);

%%% BPSK test %%%
mixB = matBchirp(testmatrix, fbasechannel, fs, fswitch, nchannels, deltaf);
sound(mixB,fs)

% filename = 'pollito_14x14.png'; % nombre de archivo
% marcianito=imread(filename); % matriz RGB
%%%%% Pasar a bin y paquetizar, caso particular imagen %%%%%%
%[Rbin, Gbin, Bbin]=img2bin(marcianito);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tiempo_audio = length(mixB)/fs;
disp(['Tiempo de transmisión  = ',num2str(tiempo_audio),'segundos'])
disp(['Velocidad de transmisión = ', num2str(nchannels*fswitch) 'bps'])
