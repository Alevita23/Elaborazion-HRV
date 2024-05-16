%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear;
clc;
close all;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

load Hr_pre_A;
load Hr_med_A;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fs = 100;
Ts = 1/fs;

Tmin = ceil(t_pre(1));
Tmax = floor(t_pre(end));
t1    = (Tmin:Ts:Tmax);

Tmin = ceil(t_med(1));
Tmax = floor(t_med(end));
t2    = (Tmin:Ts:Tmax);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

yi1 = interp1(t_pre,hr_pre,t1);
yi1 = yi1 - mean(yi1);
N1 = round(length(yi1)/2);
f1  = (1:N1)*(fs/N1);

yi2 = interp1(t_med,hr_med,t2);
yi2 = yi2 - mean(yi2);
N2 = round(length(yi2)/2);
f2  = (1:N2)*(fs/N2);

YI1 = abs((fft(yi1)).^2);
[maxYI1, ind1] = max(YI1);
YI1 = 1/maxYI1*YI1;

YI2=abs((fft(yi2)).^2);
[maxYI2, ind2] = max(YI2);
YI2 = 1/maxYI2*YI2;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure(1)
subplot(1,2,1);
plot(f1,YI1(2:N1+1),'b');
xlim([0 0.35]);
ylim([0 1.2]);
xlabel('Frequenza (Hz)');
ylabel('Spettro della Potenza Normalizzato (HRV)');
legend('Condizioni normali');
title(['Freq = ' num2str(f1(ind1)) ' Hz'])
grid;
subplot(1,2,2);
plot(f2,YI2(2:N2+1),'r');
xlim([0 0.35]);
ylim([0 1.2]);
xlabel('Frequenza (Hz)');
ylabel('Spettro della Potenza Normalizzato (HRV)');
legend('Stato meditativo');
title(['Freq = ' num2str(f2(ind2)) ' Hz'])
grid;

