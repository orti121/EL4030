function wave = matBchirp(bitmatrix,fsym,fs,fswitch,nchannels,delta)
    soundmat = [];
    for i = 1:nchannels  
        modi = BPSK(bitmatrix(i,:),fsym+(i-1)*delta,fs,fswitch);
        soundmat(i,:) = modi;
    end
    mixbruto = sum(soundmat,1);
    salida = mixbruto/max(mixbruto);
    
    tchirp = 0:1/fs:0.5; %Chirps de sincronización
    startchirp = chirp(tchirp,1000,0.5,2000);
    stopchirp = fliplr(startchirp);
    delay = zeros(1,10000);
    
    wave = [delay,startchirp, delay, salida, delay, stopchirp,delay];
end