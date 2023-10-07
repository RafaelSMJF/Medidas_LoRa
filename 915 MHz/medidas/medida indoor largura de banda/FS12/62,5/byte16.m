
clear all;
close all;
clc;
load('byte16.mat');
total=16*8;
correto=0;
bits_erro=0;
bits_erro=biterr(Byte16,65);
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