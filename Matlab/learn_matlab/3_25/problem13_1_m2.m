%Yijiang Chen.3.23

Time=input('请输入天数：');
Num_contacted=input('请输入接触人数：');
%100*100个房间/单元
%概率1表示健康概率。
rooms=ones(100,100);
rooms(100,100)=-1;%该患者患病。
patient_day_before=1;
f=figure(1);
for day=1:Time
    patient_today=power(round(patient_day_before*Num_contacted*0.85),day);
    for patient_i=1:patient_today
        %第i个接触到的市民：
        row_index=round(unifrnd(1,100));
        col_index=round(unifrnd(1,100));
        rooms(row_index,col_index)=-1;
    end
    image(rooms*255);
    title('患病分布：蓝色为感染市民，黄色为健康市民')
    uiwait(f,1);
    patient_before=patient_today;
end