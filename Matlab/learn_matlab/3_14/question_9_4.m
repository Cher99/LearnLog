% 9.4
% Yijiang Chen.3.12
clear all;clc;
n=1:1000;
r=sqrt(n);
d1=137.51;d2=137.45;d3=137.65;d4=137.92;
theta1=pi*d1*n/180; theta2=pi*d2*n/180;
theta3=pi*d3*n/180; theta4=pi*d4*n/180;

x1=r.*cos(theta1);y1=r.*sin(theta1);
x2=r.*cos(theta2);y2=r.*sin(theta2);
x3=r.*cos(theta3);y3=r.*sin(theta3);
x4=r.*cos(theta4);y4=r.*sin(theta4);

%-------开始画图--------
h=figure(1);
ax=axes('Parent',h);
ax.YAxis.Visible='off';
ax.XAxis.Visible='off';
hold on %此处一定要加hold on,从而使上述设置保留
plot(x1,y1,x2,y2,x3,y3,x4,y4)