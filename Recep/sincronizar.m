function [ysync,startlag,stoplag]=sincronizar(y,fs)
    % Los chirps generados deben ser igual que los de transmisión
    tchirp = 0:1/fs:0.5; %Chirps de sincronización
    startchirp = chirp(tchirp,1000,0.5,2000);
    stopchirp = fliplr(startchirp); %generación de chirp inverso para indicar fin
    interdelay = 10000; %Duración del retardo (en samples)
    
    startlag = getlag(y, startchirp);
    stoplag = getlag(y, stopchirp);
    largo = stoplag-interdelay-startlag - length(startchirp)- interdelay;
    ysync = y(startlag+length(startchirp)+interdelay+1:stoplag-interdelay);
end
