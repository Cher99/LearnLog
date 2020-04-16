%Yijiang Chen.3.12
% 8.2
clear all;clc;
t=-1.1:0.01:1.1;
N=1:9;% when n varfy from 0 to 9
NN=1:9;
T=1;
summ=Get_FourierSum_Of_SquareWave(t,N,T);
hline=plot(t,summ);
legend('n=1','n=2','n=3','n=4','n=5','n=6','n=7','n=8','n=9')
grid on