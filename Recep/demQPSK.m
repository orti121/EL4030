function bitstream = demQPSK(x,fsym,fs,fswitch,cable)
% x: es la se�al
% fsym: frecuencia del simbolo
% fs:frecuencia de muestreo
% fswitch: frecuencia de switcheo
% symdur es la duraci�n de un s�mbolo

tswitchus=1000000/fswitch;
tswitch = tswitchus/1000000;

tsus = 1000000/fs;
ts = tsus/1000000;
t=0:ts:tswitch;
symlen = length(t);

symqty = floor(length(x)/symlen); % Cantidad de s�mbolos

bitstream = [];
for j = 0:symqty-1
    
    window = x((j*symlen+1):((j+1)*symlen));
    %plot(window)
    % Generar se�al correspondiente a 00
    [sym00,~,~] = QPSK ([0 0],fsym,fs,fswitch);
    % Generar se�al correspondiente a 01
    [sym01,~,~] = QPSK ([0 1],fsym,fs,fswitch);
    % Generar se�al correspondiente a 10
    [sym10,~,~] = QPSK ([1 0],fsym,fs,fswitch);
    % Generar se�al correspondiente a 11
    [sym11,~,~] = QPSK ([1 1],fsym,fs,fswitch);
    
    mix00 = sym00(1:end).*window;
    int00 = sum(mix00);
    
    mix01 = sym01(1:end).*window;
    int01 = sum(mix01);
    
    mix10 = sym10(1:end).*window;
    int10 = sum(mix10);
    
    mix11 = sym11(1:end).*window;
    int11 = sum(mix11);

%     %Calcular m�xima correlaci�n de 00 con la ventana
%     [acor00,~] = xcorr(window,sym00);
%     [max00,~] = max(abs(acor00));
%     %Calcular m�xima correlaci�n de 01 con la ventana
%     [acor01,~] = xcorr(window,sym01);
%     [max01,~] = max(abs(acor01));
%     %Calcular m�xima correlaci�n de 10 con la ventana
%     [acor10,~] = xcorr(window,sym10);
%     [max10,~] = max(abs(acor10));
%     %Calcular m�xima correlaci�n de 11 con la ventana
%     [acor11,~] = xcorr(window,sym11);
%     [max11,~] = max(abs(acor11));
    
    integrals = [int00 int01 int10 int11];
    
    if cable
        symvec = [[1 0];[1 1];[0 0];[0 1]];
    else
        symvec = [[0 0];[0 1];[1 0];[1 1]];
    end
    
    [~,I] = max(integrals);
    
    bitstream = [bitstream symvec(I,:)];
end

return

end