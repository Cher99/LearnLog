%Yijiang Chen 3.6
clear all;clc;
x=[-8.3 6.6 3.2 1.1 -5.3];
y=[55.2 60.2 19.4 6.8 20.5];
A=polyfit(x,y,2);
A=round(A*100)/100;%保留小数点后两位
x_fit=-10:0.1:10;
y_fit=polyval(A,x_fit);
figure;
plot(x,y,'*r');hold on
plot(x_fit,y_fit,'-b')
grid on