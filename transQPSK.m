clear
clc
nbits = 100;
nchannels = 96;
fbasechannel = 800;
fs = 44100;
fswitch = 100;
deltaf = 200;

matload = load(['c' num2str(nchannels) 'b' num2str(nbits) '.mat']);
testmatrix = matload.testmatrix;
%testmatrix = random('bino',1,0.5,[nchannels nbits]);
%testmatrix = random('bino',1,0.5,[1 nbits]);
%nchannels = 1;

%Test de 96 canales con el perrito
perrito = imread('perrito.bmp');
rearrange = [perrito(1:96,:),perrito(97:192,:),perrito(193:288,:)];
%imshow(rearrange)
testmatrix = rearrange;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% QPSK test %%%
mixQ = matQchirp(testmatrix, fbasechannel, fs, fswitch, nchannels, deltaf);
sound(mixQ,fs)

% filename = 'pollito_14x14.png'; % nombre de archivo
% marcianito=imread(filename); % matriz RGB
%%%%% Pasar a bin y paquetizar, caso particular imagen %%%%%%
%[Rbin, Gbin, Bbin]=img2bin(marcianito);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tiempo_audio = length(mixQ)/fs;
disp(['Tiempo de transmisión  = ', num2str(tiempo_audio),'segundos'])
disp(['Velocidad de transmisión = ', num2str(nchannels*fswitch*2) 'bps'])