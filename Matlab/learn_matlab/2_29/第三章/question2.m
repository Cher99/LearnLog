% Yijiang Chen,2.26
% 题中采样频率不符合采样定律，若想恢复原始信号，需有Fc >= 10000Hz.
clear all;clc;
%Fc=20000;
Fc=100;
f=5000;
t=0:1/Fc:500/Fc;
y=sin(2*pi*f.*t).*(t>0&t<=1)+0.*(t>1&t<=2)+sin(2*pi*f.*t).*(t>2&t<=3);
stem(y,'.b-')