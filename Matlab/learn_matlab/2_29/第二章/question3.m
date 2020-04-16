%Yijiang Chen .2.26
clear all;clc;
N=1:1:80;
L=1e6;
r=5.6e-2;
P=r.*L.*power((1+r./12),12.*N)./(12.*(power((1+r./12),12.*N)-1));
plot(P)
xlabel('N/Äê')
ylabel('P/Ôª')
text(50,8e4,'L=100£¬0000£»r=5.6%')