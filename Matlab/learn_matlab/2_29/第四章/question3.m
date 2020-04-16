% Yijiang Chen. 2.27
% 用人民币替代美元

clear all;clc;
pay=input('your pay:');
rmb_0p1=0.1;rmb_0p5=0.5;
rmb_1=1;rmb_5=5;rmb_10=10;
rmb_20=20;rmb_50=50;

num_0p1=0;num_0p5=0;
num_1=0;num_5=0;num_10=0;
num_20=0;num_50=0;

change=100-pay;
disp(['找零：',num2str(change),'元'])
rest=change;
num_50=num_50+fix(rest/50);
rest=rest-50*fix(rest/50);
num_20=num_20+fix(rest/20);
rest=rest-20*fix(rest/20);

num_10=num_10+fix(rest/10);
rest=rest-10*fix(rest/10);
num_5=num_5+fix(rest/5);
rest=rest-5*fix(rest/5);
num_1=num_1+fix(rest/1);
rest=rest-1*fix(rest/1);

num_0p5=num_0p5+fix(rest/0.5);
rest=rest-0.5*fix(rest/0.5);
num_0p1=num_0p1+fix(rest/0.1);
rest=rest-0.1*fix(rest/0.1);

disp([num2str(num_50),'张50元 ',...
    num2str(num_20),'张20元 ',...
    num2str(num_10),'张10元 ',...
    num2str(num_5),'张5元 ',...
    num2str(num_1),'张1元 ',...
    num2str(num_0p5),'张5角 ',...
    num2str(num_0p1),'张1角'])

    


