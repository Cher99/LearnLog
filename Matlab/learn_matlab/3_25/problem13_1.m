%Yijiang Chen.3.23

Time=input('������������');
Num_contacted=input('������Ӵ�������');
%100*100������/��Ԫ
%����1��ʾ�������ʡ�
rooms=ones(10000,10000);

rooms(10000,10000)=0;%�û��߻�����
for day=1:Time
    day
    Num_all_protential_patients=power((Num_contacted+1),day-1);%��1�쿪ʼʱ������1�˿���/�Ѿ�������
    for patient_i=1:Num_all_protential_patients
        %��i�����ܻ��������漴�Ӵ������ˣ�
        row_index=randperm(9999,Num_contacted);
        col_index=randperm(9999,Num_contacted);
        for ii =1:Num_contacted
            %���ǽӴ��ߣ��������ʱ�Ϊԭ����15%.
            rooms(row_index(ii),col_index(ii))=0.15*rooms(row_index(ii),col_index(ii));
        end
    end
end

%-��������ͼ
help_map=1-rooms;
figure(1)
mesh(help_map);
