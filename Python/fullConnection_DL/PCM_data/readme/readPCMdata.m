clear all;
fileId = fopen('c4_211.pcm','r');
data = fread(fileId,inf,'int16');
fclose(fileId);
data1=data(1:2:end);
data2=data(2:2:end);
SpecShow1(data2);