clear
clc
nbits = 100;
nchannels = 96;
cable = 0; % 1 por cable, 0 por aire
if cable == 1
% %%% Parámetros por cable %%%
    fbasechannel = 800;
    fs = 44100;
    fswitch = 100;
    deltaf = 200;
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%
else
%%% Parámetros por sonido %%%
    fbasechannel = 800;
    fs = 44100;
    fswitch = 100;
    deltaf = 200;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end
record_duration = 15;
%%% Para comparar el resultado %%%
matload = load(['c' num2str(nchannels) 'b' num2str(nbits) '.mat']);
testmatrix = matload.testmatrix;
%testmatrix = random('bino',1,0.5,[nchannels nbits]);

%Test de 96 canales con el perrito
perrito = imread('perrito.bmp');
rearrange = [perrito(1:96,:),perrito(97:192,:),perrito(193:288,:)];
%imshow(rearrange)
testmatrix = rearrange;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%% QPSK test %%%
disp('Escuchando Sonido...')
recObj = audiorecorder(44100,16,1);             %grabar audio
recordblocking(recObj, record_duration);    %grabación final
y = transpose(getaudiodata(recObj));           %play(recObj);

[Qsync,startlagQ,stoplagQ] = sincronizar(y,fs);
testdemodQ = matdemQ(Qsync, fbasechannel, fs, fswitch,nchannels,deltaf,cable);

effQPSK = sum(testmatrix==testdemodQ,2);
BER = (1-sum(effQPSK)/(1440*nchannels))*100
%BER = (1-sum(effQPSK)/(nbits*nchannels))*100

% Mostrar las imágenes para comparar

% Reordenar para probar perrito
testmatrix = [testmatrix(:,1:480);testmatrix(:,481:960);testmatrix(:,961:1440)];
testdemodQ = [testdemodQ(:,1:480);testdemodQ(:,481:960);testdemodQ(:,961:1440)];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(1)
imshow(testmatrix)
title('Imagen Enviada')

figure(2)
imshow(testdemodQ)
title('Imagen Recibida')