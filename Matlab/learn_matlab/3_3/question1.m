%Yijiang Chen
clear all;clc;
a=[-1,0,3];b=[0,3,1];
disp(['~a:',num2str(~a)])
disp(['a&b:',num2str(a&b)])
disp(['a|b:',num2str(a|b)])
disp(['xor(a,b):',num2str(xor(a,b))])
disp(['a>0 & b>0:',num2str(a>0 & b>0)])
disp(['~a>0:',num2str(~a>0)])
disp(['a+(~b):',num2str(a+(~b))])
disp(['a>~b:',num2str(a>~b)])
disp(['~a>b:',num2str(~a>b)])
disp(['~(a>b):',num2str(~(a>b))])