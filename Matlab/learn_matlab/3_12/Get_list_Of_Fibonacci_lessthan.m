%Yijiang Chen.3.12
%function of 8.1
function[lists]=Get_list_Of_Fibonacci_lessthan(N)
    %
    if N<=1
        summ=NaN;
        disp(['对于小于等于1的自然数N，斐波那契数列中没有相应小于N值的元素']);
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