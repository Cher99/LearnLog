%Yijiang Chen.3.23

Time=input('������������');
Num_contacted=input('������Ӵ�������');
%100*100������/��Ԫ
%����1��ʾ�������ʡ�
rooms=ones(100,100);
rooms(100,100)=-1;%�û��߻�����
patient_day_before=1;
f=figure(1);
for day=1:Time
    patient_today=power(round(patient_day_before*Num_contacted*0.85),day);
    for patient_i=1:patient_today
        %��i���Ӵ���������
        row_index=round(unifrnd(1,100));
        col_index=round(unifrnd(1,100));
        rooms(row_index,col_index)=-1;
    end
    image(rooms*255);
    title('�����ֲ�����ɫΪ��Ⱦ���񣬻�ɫΪ��������')
    uiwait(f,1);
    patient_before=patient_today;
end