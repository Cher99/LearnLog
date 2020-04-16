%Yijiang Chen 3.6
function[distance]=countStrDis(str1,str2)
    %No Matter how long,use this method to count distance between str1 and str2
    length1=length(str1);
    length2=length(str2);
    all_letter=length1+length2;
    distance1=0;
    for ii=1:length1
        for jj=1:length2
            distance1=abs(abs(str1(ii))-abs(str2(jj)))+distance1;
        end
    end
    distance=distance1/all_letter;
        