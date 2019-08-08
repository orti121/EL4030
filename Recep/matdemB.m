function demodmatrix = matdemB(x,fsym,fs,fswitch,nchannels,delta,cable)

tswitchus=1000000/fswitch;
tswitch = tswitchus/1000000;

tsus = 1000000/fs;
ts = tsus/1000000;
t=0:ts:tswitch;
symlen = length(t);

symqty = floor(length(x)/symlen); % Cantidad de símbolos
demodmatrix = zeros([nchannels symqty]);

for i = 1:nchannels
    demodi = demBPSK(x,fsym+(i-1)*delta,fs,fswitch);
    if cable
        demodmatrix(i,:) = ~demodi;
    else
        demodmatrix(i,:) = demodi;
    end
end
end