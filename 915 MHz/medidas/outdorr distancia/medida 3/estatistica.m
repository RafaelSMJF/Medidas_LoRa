clear all;
close all;
clc;
load('medidas915.mat')
lat_ini =  -21.778823;
long_ini = -43.373600;

%minimos quadrados
DIST915=distance(lat_ini,long_ini,LA915,LO915)
DIST915=DIST915*100000
