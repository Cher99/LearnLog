% Yijiang Chen,2.26
% ���в���Ƶ�ʲ����ϲ������ɣ�����ָ�ԭʼ�źţ�����Fc >= 10000Hz.
clear all;clc;
%Fc=20000;
Fc=100;
f=5000;
t=0:1/Fc:500/Fc;
y=sin(2*pi*f.*t).*(t>0&t<=1)+0.*(t>1&t<=2)+sin(2*pi*f.*t).*(t>2&t<=3);
stem(y,'.b-')