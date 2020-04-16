function [field, startposind, goalposind, costchart, fieldpointers] =initializeField(n,Num,FMap)
%% Yijiang Chen.2020.4.16
%   n:      resolution of Ur ideal field.
%   Num:    number of obstacles.
%   FMap:   the Origin Map. **Should Be a Square Image**

%% 获得图像信息
Map_gray=rgb2gray(FMap);
M_size=size(Map_gray);
N=ceil(M_size(1)/n);
%% 建立Astar中相关状态矩阵
field=ones(N,N)+5*rand(N,N);
%% 根据显示地图，选择障碍物、起点及终点信息
figure(1)
imshow(FMap)
disp(['请在原图上选择障碍物信息'])
obstacles=[];
for choice=1:Num
    k1=waitforbuttonpress;
    point1=get(gca,'CurrentPoint');
    k2=waitforbuttonpress;
    point2=get(gca,'CurrentPoint');
    point1=point1(1,1:2)
    point2=point2(1,1:2)
    pp1=min(floor(point1),floor(point2))
    pp2=max(floor(point1),floor(point2))
    %obstacle=[pp1(2);pp1(1);pp2(2);pp2(1)]
    obstacle=[pp1(1);pp1(2);pp2(1);pp2(2)]
    obstacles=[obstacles,obstacle];
    disp(['障碍物：',num2str(choice),'信息选择完成']);
end
disp(['请在原图上点击-起点-中心'])
point_s=ginput;
disp(['请在原图上点击-终点-中心'])
point_e=ginput;

%% 设置Astar状态矩阵初始值
% 将obstacles中，图像上的坐标转化为field矩阵中的索引值；
obstacles=round(obstacles/n);% M_size(1)/col == x_n/x_index; x_n=ceil(M_size(1)/n);
ii=1;
while ii<=Num
    field(obstacles(1,ii):obstacles(3,ii),obstacles(2,ii):obstacles(4,ii))=Inf*ones(obstacles(3,ii)-obstacles(1,ii)+1,obstacles(4,ii)-obstacles(2,ii)+1);
    ii=ii+1;
end
point_s=round(point_s/n);
point_e=round(point_e/n);
startposind=sub2ind([N,N],ceil(point_s(1)),ceil(point_s(2)));
goalposind=sub2ind([N,N],ceil(point_e(1)),ceil(point_e(2)));
field(startposind)=0; field(goalposind) = 0;
costchart = NaN*ones(N,N); costchart(startposind) = 0;
fieldpointers = cell(N,N);
fieldpointers{startposind} = 'S'; fieldpointers{goalposind} = 'G';
fieldpointers(field == Inf) = {0};

end