function salida = matsoundB(bitmatrix,fsym,fs,fswitch,nchannels,delta)
    soundmat = [];
    for i = 1:nchannels  
        modi = BPSK(bitmatrix(i,:),fsym+(i-1)*delta,fs,fswitch);
        soundmat(i,:) = modi;
    end
    mixbruto = sum(soundmat,1);
    salida = mixbruto/max(mixbruto);
end