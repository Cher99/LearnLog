% Yijiang Chen, 2.26

clear all;clc;
A1=input('直角三角形A边：');
B1=input('直角三角形B边：');
C1=sqrt(power(A1,2)+power(B1,2));
disp(['直角三角形斜边：',num2str(C1)]);

A2=input('三角形A边：');
B2=input('三角形B边：');
theta=input('三角形theta角：');
C2=sqrt(power(A2,2)+power(B2,2)-2*A2*B2*cos(theta));
disp(['三角形C边：',num2str(C2)]);