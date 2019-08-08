function demodmatrix = matdemQ(x,fsym,fs,fswitch,nchannels,delta,cable)

tswitchus=1000000/fswitch;
tswitch = tswitchus/1000000;

tsus = 1000000/fs;
ts = tsus/1000000;
t=0:ts:tswitch;
symlen = length(t);

symqty = floor(length(x)/symlen); % Cantidad de símbolos
demodmatrix = zeros([nchannels symqty*2]);

for i = 1:nchannels
    demodi = demQPSK(x,fsym+(i-1)*delta,fs,fswitch,cable);
    demodmatrix(i,:) = demodi;
end
end