%Yijiang Chen 3.23
clear all;clc;
N=10000;
bins=100;
x=[];
for ii=1:N
    x=[x,sum(rand(12,1))];
end
[histfreq,histXout]=hist(x,bins);
figure(1);
title('原数据分布')
hist(x,bins);
title('原数据分布')
figure(2)
%------gauss拟合------
var=var(x)/12;
mean=mean(x);
y=normrnd(mean,var,N);
title('高斯拟合结果');
hist(y,bins);
title('高斯拟合结果');

