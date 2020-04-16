%function of 8.2
function [summ]=Get_FourierSum_Of_SquareWave(t,N,T)
    % Get a matrix,length(N)*length(t)
    %Attention: param t is a fixed list given by user,which is to help
    %           calculate summmary.
    %           param N is independent param,which determines param summ
    summ=zeros(length(N),length(t));
    for ii=1:length(N)
        help_n=(0:N(ii))';
        summ(ii,:)=(4/pi)*(2.*help_n+1)'*sin((2.*help_n+1)*pi*t/T);
    end
    summ=summ';
end
 
