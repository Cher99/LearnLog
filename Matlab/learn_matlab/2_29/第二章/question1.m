% Yijiang Chen.2.26
clear all;clc;
N=round(input('请输入大于1000的整数N：'));
%=========方式一：循环方式============
sum_1=0;
disp(['循环方式:']);
tic
for i=1:1:N
    sum_1=sum_1+6/power(i,2);
end
toc
disp(['求和结果：',num2str(sum_1)]);

%=========方式二：向量方式============
i_vector=1:1:N;
disp(['向量方式:'])
tic
sum_2=sum(6./power(i_vector,2));
toc
disp(['求和结果:',num2str(sum_2)])
sum_2=sum(6./power(i_vector,2));