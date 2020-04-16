%Yijiang Chen 3.2
clear all;clc;
user=[210,190,320,280,179,400];
cost=(user<=180).*(user.*0.588)+...
    (user>180&user<=350).*((user-180)*0.638+180*0.588)+...
    (user>350).*((user-350)*0.888+170*0.638+180*0.588);
disp(['用户的电费为：',num2str(cost)])