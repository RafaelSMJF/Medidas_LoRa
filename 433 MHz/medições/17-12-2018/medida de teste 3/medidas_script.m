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
xlabel('medida','FontSize',14)
ylabel('RSSI','FontSize',14)


figure
semilogx(DIST2,RSSI,'*')
title('Medida')
xlabel('Distância (m)','FontSize',14)
ylabel('RSSI','FontSize',14)

figure
plot(MEDIDA,DIST)
title('Distância','FontSize',14)
xlabel('medida','FontSize',14)
ylabel('Distância (m)','FontSize',14)

figure
plot(MEDIDA,ALTITUDE)
title('altitude')
xlabel('medida','FontSize',14)
ylabel('altitude (cm)','FontSize',14)