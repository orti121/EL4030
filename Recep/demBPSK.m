function bitstream = demBPSK(x,fsym,fs,fswitch)
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
    % Generar se�al correspondiente a 0
    [sym0,~,~] = BPSK(0,fsym,fs,fswitch );
    % Generar se�al correspondiente a 1
    [sym1,~,~] = BPSK(1,fsym,fs,fswitch );
    
    mix0 = sym0(1:end).*window;
    integral0 = sum(mix0);
    
    mix1 =sym1(1:end).*window;
    integral1 = sum(mix1);
%     %Calcular m�xima correlaci�n de 0 con la ventana
%     [acor0,~] = xcorr(window,sym0);
%     [max0,i0] = max(abs(acor0));
%     %Calcular m�xima correlaci�n de 1 con la ventana
%     [acor1,~] = xcorr(window,sym1);
%     [max1,i1] = max(abs(acor1));
    
    if (integral0 > integral1)
        bitstream = [bitstream, 0];
    elseif (integral1 > integral0)
        bitstream = [bitstream, 1];
    else
        bitstream = [bitstream, 0];
    end
end

return

end