% Yijiang Chen, 2.26
% Test as you like :)

clear all;clc;
a=input('ax+by=c�� aֵ��');
b=input('ax+by=c�� bֵ��');
c=input('ax+by=c�� cֵ��');
d=input('dx+ey=f�� dֵ��');
e=input('dx+ey=f�� eֵ��');
f=input('dx+ey=f�� fֵ��');

if a==0 && b==0
    if c~=0
        disp(['ax+by=cΪ��Ч���ʽ�������������'])
    end
end
if d==0 && e==0
    if f~=0
        disp(['dx+ey=fΪ��Ч���ʽ�������������'])
    end
end

if a*e==b*d
    if a*f==d*c && e*f==b*c
        disp(['��ֱ���غϣ���Ԫ�������������'])
    else
        disp(['��ֱ��ƽ�У���Ԫ�������޽�'])
    end
else
    % to get result of y variable
    py=[-(b*d-a*e),d*c-a*f];
    y=roots(py);
    
    % to get result of x variable
    px=[-(b*d-a*e),b*f-c*e];
    x=roots(px);
    disp(['��ֱ���ཻ����Ԫ��������Ψһ�⣺','[x,y]=','[',num2str(x),',',...
        num2str(y),']'])
end
    
    
        