function salida = gentestsoundQ(bitstream,fsym,fs,fswitch,nchannels)
    delta = 150;
    salida = QPSK(bitstream,fsym,fs,fswitch);
    for i = 1:nchannels-1  
        channeln = random('bino',1,0.5,size(bitstream));
        ruido = QPSK(channeln,fsym+(i+1)*delta,fs,fswitch);
        salida = salida+ruido;
    end
    salida = salida/max(salida);
end