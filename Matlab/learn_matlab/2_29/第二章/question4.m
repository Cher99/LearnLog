%Yijiang Chen , 2.26
clear all;clc;
for x=1:9
    str=' ';
    for y=1:x
       str=[str,num2str(x),'x',num2str(y),'=',num2str(x*y),' '];
    end
    disp([str])
end