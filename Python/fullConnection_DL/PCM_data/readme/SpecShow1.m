function SpecShow(data1)
N=4096;% 2 frame
fc=floor(N/2*21/24); % 1792
f_bias=floor(N/2*0.3/24);% 25
fc_bias=floor(N/2*0.06/24);% 5
s1=spectrogram(data1,N,4000,N,48e3);
s1_val=abs(s1);
s1_effi=s1_val(fc-f_bias:fc+f_bias,:);
s1_fu=s1_effi(1:f_bias-fc_bias,:);
s1_zheng=s1_effi(f_bias+fc_bias:end,:);
s1_total=[s1_fu;s1_zheng];
figure;
imagesc(s1_total(:,1:end));
end