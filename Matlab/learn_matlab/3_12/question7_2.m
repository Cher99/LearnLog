%Yijiang Chen.3.12
% 7.2
clear all;clc;
x=-10:0.1:10;
sample_y=x.^3;
ideal_y=3*x.^2;
[coeffi,y_differ]=get_y_differ(x,sample_y);
calcu_y=polyval(coeffi,x);
plot(x,ideal_y,'k:');hold on
plot(x,calcu_y,'r*');
legend('���뵼����������','���Ƶ�����������')
grid on
hold off
