%Yijiang Chen 2.26
clear all;clc;
userData=input('�����������õ�����');
cost=(userData<=180)*userData*0.588+...
    (userData<=350&&userData>180)*(180*0.638+(userData-180)*0.638)+...
    (userData>350)*(180*0.588+170*0.638+(userData-350)*0.888);
disp(['���ĵ��Ϊ��',num2str(cost)])