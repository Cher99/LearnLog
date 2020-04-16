%Yijiang Chen.3.6
clear all;clc;
randomIndex=randperm(4);
str_table=zeros(4,4);
str_tar_table=zeros(4,13);
str1=input('输入成语：','s');
[row col]=find(randomIndex==1);
str_table(col,:)=str1;
str2=input('输入成语：','s');
[row col]=find(randomIndex==2);
str_table(col,:)=str2;
str3=input('输入成语：','s');
[row col]=find(randomIndex==3);
str_table(col,:)=str3;
str4=input('输入成语：','s');
[row col]=find(randomIndex==4);
str_table(col,:)=str4;
disp(['随机排列后成语顺序为：'])
disp([char(str_table)])
str_tar_table(1,1:4)=str_table(1,:);
row_index=1;
for ii=1:3
    findrow=find(str_table(1:4)==str_table(row_index,4));
    str_tar_table(ii+1,ii*3+1:ii*3+4)=str_table(findrow,:);
    row_index=findrow;
end
str_tar_table(str_tar_table==0)=' ';
disp(['最终排序结果：'])
disp([char(str_tar_table)])