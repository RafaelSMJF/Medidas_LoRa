
clear all;
close all;
clc;
load('byte8.mat');
total=8*8;
correto=0;
bits_erro=0;
bits_erro=biterr(Byte8,65);
B=bits_erro <= 0;
correto=sum(B);

disp('bits errados: ')
disp(sum(bits_erro))
disp('caracteres corretos: ')
disp(correto)

disp('total de bits: ')
disp(total)
disp('BER (%): ')
disp(sum(bits_erro)*100/(total))
