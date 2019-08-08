%https://www.mathworks.com/help/signal/ref/xcorr.html
% Para delay en segundos, dividir lag por fs
function [lagDiff] = getlag(s1,s2)
    [acor,lag] = xcorr(s1,s2);
    [~,I] = max(abs(acor));
    lagDiff = lag(I);
end