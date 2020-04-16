% 9.1
%Yijiang Chen.3.12
clear all;clc;
theta=0:0.1:180;
N1=100;d_lamda1=0.5;
N2=50;d_lamda2=2;
B1=Get_Directivity_Distribution(N1,theta,d_lamda1);
B2=Get_Directivity_Distribution(N2,theta,d_lamda2);
theta_2=theta*pi/180;
subplot(1,2,1);
hline=plot(theta,[B1;B2]);
set(hline(1),'linest','-','lineWidth',1,'Color',[0,0.5,0.5]);
set(hline(2),'linest',':','lineWidth',2,'Color',[0.5,0,0.5]);
axis tight
axis square
grid on
xlabel('角度值\Phi/^{o}');
ylabel('指向性函数幅度');
legend('N=100，d/\lambda=0.5','N=50，d/\lambda=2');
title('指向性函数幅值-角度图形')

subplot(1,2,2);
title('指向性分布图')
hline1=polar(theta_2,B1);
set(hline1,'linest','-','lineWidth',1,'Color',[0,0.5,0.5]);
hold on
hline2=polar(theta_2,B2);
set(hline2,'linest','-','lineWidth',2,'Color',[0.5,0,0.5]);
legend('N=100，d/\lambda=0.5','N=50，d/\lambda=2');
axis tight
title('指向性分布图')
