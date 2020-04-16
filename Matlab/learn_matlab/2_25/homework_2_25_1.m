% Yijiang Chen .2.25
clear all;clc;
data_fu=-10;
data_zheng=10;
sum=sqrt(data_fu)+log(data_fu)+asin(data_zheng);
diff=sqrt(data_fu)-log(data_fu)-asin(data_zheng);
product=sqrt(data_fu)*log(data_fu)*asin(data_zheng);
quotient=sqrt(data_fu)/log(data_fu)/asin(data_zheng);
sum,diff,product,quotient
