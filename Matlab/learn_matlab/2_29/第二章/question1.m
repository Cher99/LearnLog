% Yijiang Chen.2.26
clear all;clc;
N=round(input('���������1000������N��'));
%=========��ʽһ��ѭ����ʽ============
sum_1=0;
disp(['ѭ����ʽ:']);
tic
for i=1:1:N
    sum_1=sum_1+6/power(i,2);
end
toc
disp(['��ͽ����',num2str(sum_1)]);

%=========��ʽ����������ʽ============
i_vector=1:1:N;
disp(['������ʽ:'])
tic
sum_2=sum(6./power(i_vector,2));
toc
disp(['��ͽ��:',num2str(sum_2)])
sum_2=sum(6./power(i_vector,2));