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
title('ԭ���ݷֲ�')
hist(x,bins);
title('ԭ���ݷֲ�')
figure(2)
%------gauss���------
var=var(x)/12;
mean=mean(x);
y=normrnd(mean,var,N);
title('��˹��Ͻ��');
hist(y,bins);
title('��˹��Ͻ��');

