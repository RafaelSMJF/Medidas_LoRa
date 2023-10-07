clear all;
close all;
clc;
load('matlab2.mat')
load('matlab3.mat')
lat_ini =  -21.778875;
long_ini = -43.373710;
DIST=distance(lat_ini,long_ini,LA,LO)
DIST2=DIST*100000
%minimos quadrados

% Passo 1 - Obter x e y (dados de um experimento)
 
x = DIST2;
y=RSSI;
x2 = DIST3;
n = length(x);
n2 = length(x2);
y2=RSSI3;
 
x2 = DIST3;
n2 = length(x2);
y2=RSSI3;
 
% Passo 2 - Analizar os dados e decidir qual curva utilizar
semilogx(x,y,'.');
hold on
 semilogx(x2,y2,'*');
% Passo 3 - Utilizar Método dos mínimos quadrados para encontrar os 
%parametros (a,b,c...). Para não confundir iremos chamá-lo de theta (th). 
%Portanto, y_ap = A*th (no video eu expliquei como y_ap = A*X)
 
A = [10*log10(x) x.^0];
A2 = [10*log10(x2) x2.^0];
th = inv(A'*A)*A'*y;
th2 = pinv(A)*y;
 th3 = inv(A2'*A2)*A2'*y2;
th4 = pinv(A2)*y2;
y_ap = A*th;
y_ap2 = A2*th3;

semilogx(x, y_ap,'r')
 semilogx(x2, y_ap2,'--')
% Passo 4 (Opcional) - Avaliar o erro.
e  = y - y_ap;
E = (e'*e)/n % sum(e.^2) = e'*e
e2  = y2 - y_ap2;
E2 = (e2'*e2)/n2 
disp('coeficientes n e P0')
disp(th)
%%%%%%%%%%%%%%




figure
plot(RSSI)
hold on
plot(RSSI3)
title('RSSI')
xlabel('medida','FontSize',14)
ylabel('RSSI','FontSize',14)
hold off

figure
plot(DIST2,RSSI,'.')
hold on
plot(DIST3,RSSI3,'*')

title('Medida')
xlabel('Distância (m)','FontSize',14)
ylabel('RSSI','FontSize',14)

plot(x, y_ap,'r')
plot(x2, y_ap2,'--')
%figure
%plot(MEDIDA,DIST2)
%title('Distância')
%xlabel('medida','FontSize',14)
%ylabel('Distância (m)','FontSize',14)

%figure
%plot(MEDIDA,ALTITUDE)
%title('altitude')
%xlabel('medida','FontSize',14)
%ylabel('altitude (cm)','FontSize',14)