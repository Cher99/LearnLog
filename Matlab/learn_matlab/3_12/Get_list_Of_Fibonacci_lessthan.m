%Yijiang Chen.3.12
%function of 8.1
function[lists]=Get_list_Of_Fibonacci_lessthan(N)
    %
    if N<=1
        summ=NaN;
        disp(['����С�ڵ���1����Ȼ��N��쳲�����������û����ӦС��Nֵ��Ԫ��']);
    else
        summ=zeros(1,10000);
        summ(1:2)=[1,1];
        ii=3;
        while(summ(ii-2)+summ(ii-1)<N)
            summ(ii)=summ(ii-2)+summ(ii-1);
            ii=ii+1;
        end
        lists=summ(find(summ~=0));
    end