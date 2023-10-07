
clear all;
close all;
clc;
load('byte48.mat');
total=48*8;
correto=0;
bits_erro=0;
bits_erro=biterr(Byte48,65);
B=bits_erro <= 0;
corrreto=sum(B);

disp('bits errados: ')
disp(sum(bits_erro))
disp('caracteres corretos: ')
disp(corrreto)

disp('total de bits: ')
disp(total)
disp('total de bits: ')
disp(total)
disp('BER (%): ')
disp(sum(bits_erro)*100/(total))