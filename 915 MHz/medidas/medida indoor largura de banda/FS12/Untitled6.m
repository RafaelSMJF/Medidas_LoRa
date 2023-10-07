clear all;
close all;
clc;
load('8byte.mat')
load('16byte.mat')
load('32byte.mat')
load('48byte.mat')

figure
plot(BAND,BER,'-');
hold on;
plot(BAND,BER2,'-.');
plot(BAND,BER3,'--');
plot(BAND,BER4,':');
xlabel('Largura de Banda (kHz)','FontSize',14)
ylabel('BER (%)','FontSize',14)
hold off

figure
plot(BAND,BITERR,'-');
hold on;
plot(BAND,BITERR2,'-.');
plot(BAND,BITERR3,'--');
plot(BAND,BITERR4,':');
xlabel('Largura de Banda (kHz)','FontSize',14)
ylabel('Bits Errados','FontSize',14)
hold off

figure
plot(BAND,CORRCA,'-');
hold on;
plot(BAND,CORRCA2,'-.');
plot(BAND,CORRCA3,'--');
plot(BAND,CORRCA4,':');
xlabel('Largura de Banda (kHz)','FontSize',14)
ylabel('Caracteres Corretos','FontSize',14)
hold off

figure
plot(BAND,ERR,'-');
hold on;
plot(BAND,ERR2,'-.');
plot(BAND,ERR3,'--');
plot(BAND,ERR4,':');
xlabel('Largura de Banda (kHz)','FontSize',14)
ylabel('Pacotes Errados','FontSize',14)
hold off

figure
plot(BAND,PERD,'-');
hold on;
plot(BAND,PERD2,'-.');
plot(BAND,PERD3,'--');
plot(BAND,PERD4,':');
xlabel('Largura de Banda (kHz)','FontSize',14)
ylabel('Pacotes Perdidos','FontSize',14)
hold off

figure
plot(BAND,CORR,'-');
hold on;
plot(BAND,CORR2,'-.');
plot(BAND,CORR3,'--');
plot(BAND,CORR4,':');
xlabel('Largura de Banda (kHz)','FontSize',14)
ylabel('Pacotes Corretos','FontSize',14)
hold off