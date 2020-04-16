%Yijiang Chen.3.23

Time=input('请输入天数：');
Num_contacted=input('请输入接触人数：');
%100*100个房间/单元
%概率1表示健康概率。
rooms=ones(10000,10000);

rooms(10000,10000)=0;%该患者患病。
for day=1:Time
    day
    Num_all_protential_patients=power((Num_contacted+1),day-1);%第1天开始时，仅有1人可能/已经患病。
    for patient_i=1:Num_all_protential_patients
        %第i个可能患病者所随即接触到的人：
        row_index=randperm(9999,Num_contacted);
        col_index=randperm(9999,Num_contacted);
        for ii =1:Num_contacted
            %凡是接触者，健康概率变为原来的15%.
            rooms(row_index(ii),col_index(ii))=0.15*rooms(row_index(ii),col_index(ii));
        end
    end
end

%-患病概率图
help_map=1-rooms;
figure(1)
mesh(help_map);
