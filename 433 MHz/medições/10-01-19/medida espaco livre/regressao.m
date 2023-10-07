clear all;
close all;
clc;
load('matlab.mat')
lat_ini =  -21.778875;
long_ini = -43.373710;
DIST=distance(lat_ini,long_ini,LA,LO)
DIST2=DIST*100000
%minimos quadrados

% Passo 1 - Obter x e y (dados de um experimento)
 
x = DIST2;
n = length(x);
y=RSSI;
 
 
% Passo 2 - Analizar os dados e decidir qual curva utilizar
semilogx(x,y,'.');
 
% Passo 3 - Utilizar Método dos mínimos quadrados para encontrar os 
%parametros (a,b,c...). Para não confundir iremos chamá-lo de theta (th). 
%Portanto, y_ap = A*th (no video eu expliquei como y_ap = A*X)
 
A = [10*log(x)];
 
th = inv(A'*A)*A'*y;
th2 = pinv(A)*y;
 
y_ap = A*th;
hold on
semilogx(x, y_ap,'r')
 
% Passo 4 (Opcional) - Avaliar o erro.
e  = y - y_ap;
E = (e'*e)/n % sum(e.^2) = e'*e
disp('coeficientes n e P0')
disp(th)
%%%%%%%%%%%%%%




figure
plot(MEDIDA,RSSI)
title('RSSI')
xlabel('medida','FontSize',14)
ylabel('RSSI','FontSize',14)


figure
plot(DIST2,RSSI,'.')
title('Medida')
xlabel('Distância (m)','FontSize',14)
ylabel('RSSI','FontSize',14)
hold on
plot(x, y_ap,'r')

figure
plot(MEDIDA,DIST2)
title('Distância')
xlabel('medida','FontSize',14)
ylabel('Distância (m)','FontSize',14)

figure
plot(MEDIDA,ALTITUDE)
title('altitude')
xlabel('medida','FontSize',14)
ylabel('altitude (cm)','FontSize',14)