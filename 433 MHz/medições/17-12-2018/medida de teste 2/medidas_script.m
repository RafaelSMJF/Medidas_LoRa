clear all;
close all;
clc;
load('matlab.mat')
lat_ini =  -21.778875;
long_ini = -43.373710;
DIST=distance(lat_ini,long_ini,LA,LO)
DIST2=DIST*100000

figure
plot(MEDIDA,RSSI)
title('RSSI')
xlabel('medida')
ylabel('RSSI')


figure
semilogx(DIST2,RSSI,'*')
title('Medida')
xlabel('Dist�ncia (m)')
ylabel('RSSI')

figure
plot(MEDIDA,DIST2)
title('Dist�ncia')
xlabel('medida')
ylabel('Dist�ncia (m)')

figure
plot(MEDIDA,ALTITUDE)
title('altitude')
xlabel('medida')
ylabel('altitude (cm)')