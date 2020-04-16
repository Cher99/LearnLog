%Yijiang Chen.3.12
% 7.1
clear all;clc;
x=-10:0.1:10;
my_y=my_exp(x);
y_real=exp(x);
plot(x,my_y,'b--');hold on
plot(x,y_real,'r:');
legend('估计值','真实值')
grid on