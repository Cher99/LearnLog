% Yijiang Chen, 2.26

clear all;clc;
A1=input('ֱ��������A�ߣ�');
B1=input('ֱ��������B�ߣ�');
C1=sqrt(power(A1,2)+power(B1,2));
disp(['ֱ��������б�ߣ�',num2str(C1)]);

A2=input('������A�ߣ�');
B2=input('������B�ߣ�');
theta=input('������theta�ǣ�');
C2=sqrt(power(A2,2)+power(B2,2)-2*A2*B2*cos(theta));
disp(['������C�ߣ�',num2str(C2)]);