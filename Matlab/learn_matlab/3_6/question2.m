%Yijiang Chen.3.6
clear all;clc;
name1=input('请输入第一个名字：','s');
name2=input('请输入第二个名字：','s');
name3=input('请输入第三个名字：','s');
names=[name1 name2;name2 name3;name3 name1];
dis12=countStrDis(name1,name2);
dis23=countStrDis(name2,name3);
dis31=countStrDis(name1,name3);
dis=[dis12;dis23;dis31];
mindis=min(dis);
[row cols]=find(dis==mindis);
target=names(row,:);
disp(['距离最近者:',target])
