%function of 7.1
function [my_y]=my_exp(x)
    %
    my_y=x==x;
    for ii=1:200
        help_x=power(x,ii)
        help_ii=factorial(ii);
        my_y=my_y+(help_x/help_ii).*(abs(help_x/help_ii)>1e-6);
    end
        
        