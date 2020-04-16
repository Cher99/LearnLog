%function of 7.2
function [coeffi,y_differ]=get_y_differ(x,sample_y)
    x_2=x(2:end-1);
    y_differ=(x_2-x_2);
    for ii=1:length(x_2)
        if ii+2>=length(sample_y)
            break
        end
        y_differ(ii)=(sample_y(ii+2)-sample_y(ii))/2/(x(ii+1)-x(ii));
    end
    coeffi=polyfit(x_2,y_differ,5);
    