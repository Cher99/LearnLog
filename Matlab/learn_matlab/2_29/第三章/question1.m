% Yijiang Chen, 2.26
% Test as you like :)

clear all;clc;
a=input('ax+by=c中 a值：');
b=input('ax+by=c中 b值：');
c=input('ax+by=c中 c值：');
d=input('dx+ey=f中 d值：');
e=input('dx+ey=f中 e值：');
f=input('dx+ey=f中 f值：');

if a==0 && b==0
    if c~=0
        disp(['ax+by=c为无效表达式，参数输入错误'])
    end
end
if d==0 && e==0
    if f~=0
        disp(['dx+ey=f为无效表达式，参数输入错误'])
    end
end

if a*e==b*d
    if a*f==d*c && e*f==b*c
        disp(['两直线重合，二元方程组有无穷解'])
    else
        disp(['两直线平行，二元方程组无解'])
    end
else
    % to get result of y variable
    py=[-(b*d-a*e),d*c-a*f];
    y=roots(py);
    
    % to get result of x variable
    px=[-(b*d-a*e),b*f-c*e];
    x=roots(px);
    disp(['两直线相交，二元方程组有唯一解：','[x,y]=','[',num2str(x),',',...
        num2str(y),']'])
end
    
    
        