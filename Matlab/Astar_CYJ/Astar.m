%% ASTARDEMO Demonstration of ASTAR algorithm
%
% Copyright Bob L. Sturm, Ph. D., Assistant Professor
% Department of Architecture, Design and Media Technology
% formerly Medialogy
% Aalborg University i Ballerup
% formerly Aalborg University Copenhagen
%
% $Revision: 0.1 $ $Date: 2011 Jan. 15 18h24:24$

%% 地图读入并弥补为方阵
OMap=imread('Mmap.png');
Gmap=rgb2gray(OMap);
M_size=size(Gmap);
disp(['========地图信息=======长：',num2str(M_size(2)),',宽：',num2str(M_size(1))]);
OMap=[ones(300,M_size(2),3);OMap;ones(M_size(2)-M_size(1)-300,M_size(2),3)];
n = input('分辨率n：'); % 将原地图设置为n分辨率的栅格化地图。
Num = input('障碍物个数 Num：');

%% A* start:
[field, startposind, goalposind, costchart, fieldpointers]=initializeField(n,Num,OMap);
setOpen = startposind;
setOpenCosts = 0;
setOpenHeuristics = Inf;
setClosed = [];
setClosedCosts = [];
movementdirections = {'R','L','D','U'};

% keep track of the number of iterations to exit gracefully if no solution
counterIterations = 1;

% create figure so we can witness the magic
axishandle = createFigure(field,costchart,startposind,goalposind);

% as long as we have not found the goal or run out of spaces to explore
while ~max(ismember(setOpen,goalposind)) && ~isempty(setOpen) %ismember(A,B)返回与A同大小的矩阵，其中元素1表示A中相应位置的元素在B中也出现，0则是没有出现
    % for the element in OPEN with the smallest cost
    
    [temp, ii] = min(setOpenCosts + setOpenHeuristics); %从OPEN表中选择花费最低的点temp,ii是其下标(也就是标号索引)
    
    % find costs and heuristic of moving to neighbor spaces to goal
    % in order 'R','L','D','U'
    [costs,heuristics,posinds] = findFValue(setOpen(ii),setOpenCosts(ii),field,goalposind,'euclidean');
    %扩展temp的四个方向点，获得其坐标posinds，各个方向点的实际代价costs，启发代价heuristics
    
    % put node in CLOSED and record its cost
    setClosed = [setClosed; setOpen(ii)]; %将temp插入CLOSE表中
    setClosedCosts = [setClosedCosts; setOpenCosts(ii)]; %将temp的花费计入ClosedCosts
    
    % update OPEN and their associated costs 更新OPEN表 分为三种情况
    if (ii > 1 && ii < length(setOpen)) %temp在OPEN表的中间，删除temp
        setOpen = [setOpen(1:ii-1); setOpen(ii+1:end)];
        setOpenCosts = [setOpenCosts(1:ii-1); setOpenCosts(ii+1:end)];
        setOpenHeuristics = [setOpenHeuristics(1:ii-1); setOpenHeuristics(ii+1:end)];
    elseif (ii == 1)
        setOpen = setOpen(2:end); %temp是OPEN表的第一个元素，删除temp
        setOpenCosts = setOpenCosts(2:end);
        setOpenHeuristics = setOpenHeuristics(2:end);
    else %temp是OPEN表的最后一个元素，删除temp
        setOpen = setOpen(1:end-1);
        setOpenCosts = setOpenCosts(1:end-1);
        setOpenHeuristics = setOpenHeuristics(1:end-1);
    end
    
    % for each of these neighbor spaces, assign costs and pointers;
    % and if some are in the CLOSED set and their costs are smaller,
    % update their costs and pointers
    
    for jj=1:length(posinds) %对于扩展的四个方向的坐标
        
        % if cost infinite, then it's a wall, so ignore
        if ~isinf(costs(jj)) %如果此点的实际代价不为Inf,也就是没有遇到墙
            
            % if node is not in OPEN or CLOSED then insert into costchart and
            % movement pointers, and put node in OPEN
            if ~max([setClosed; setOpen] == posinds(jj)) %如果此点不在OPEN表和CLOSE表中
                fieldpointers(posinds(jj)) = movementdirections(jj); %将此点的方向存在对应的fieldpointers中 
                costchart(posinds(jj)) = costs(jj); %将实际代价值存入对应的costchart中
                setOpen = [setOpen; posinds(jj)]; %将此点加入OPEN表中
                setOpenCosts = [setOpenCosts; costs(jj)]; %更新OPEN表实际代价
                setOpenHeuristics = [setOpenHeuristics; heuristics(jj)]; %更新OPEN表启发代价
                
                % else node has already been seen, so check to see if we have
                % found a better route to it.
            elseif max(setOpen == posinds(jj)) %如果此点在OPEN表中
                I = find(setOpen == posinds(jj)); %找到此点在OPEN表中的位置
                
                % update if we have a better route
                if setOpenCosts(I) > costs(jj) %如果在OPEN表中的此点实际代价比现在所得的大 
                    costchart(setOpen(I)) = costs(jj); %将当前的代价存入costchart中，注意此点在costchart中的坐标与其自身坐标是一致的（setOpen(I)其实就是posinds(jj)），下同fieldpointers
                    setOpenCosts(I) = costs(jj); %更新OPEN表中的此点代价，注意此点在setOpenCosts中的坐标与在setOpen中是一致的，下同setOpenHeuristics
                    setOpenHeuristics(I) = heuristics(jj); %更新OPEN表中的此点启发代价(窃以为这个是没有变的)
                    fieldpointers(setOpen(I)) = movementdirections(jj); %更新此点的方向
                end
                
                % else node has already been CLOSED, so check to see if we have
                % found a better route to it.
            else %如果此点在CLOSE表中，说明已经扩展过此点
                
                % find relevant node in CLOSED
                I = find(setClosed == posinds(jj));
                
                % update if we have a better route
                if setClosedCosts(I) > costs(jj) %如果在CLOSE表中的此点实际代价比现在所得的大（有一个问题，经过此点扩展的点还需要更新当前代价呢!!!）
                    costchart(setClosed(I)) = costs(jj); %将当前的代价存入costchart中
                    setClosedCosts(I) = costs(jj); %更新CLOSE表中的此点代价
                    fieldpointers(setClosed(I)) = movementdirections(jj); %更新此点的方向 
                end
                
            end
            
        end
        
    end
    
    if isempty(setOpen)
        break;
    end %当OPEN表为空，代表可以经过的所有点已经查询完毕
    
    set(axishandle,'CData',[costchart costchart(:,end); costchart(end,:) costchart(end,end)]);
    
    % hack to make image look right
    
    set(gca,'CLim',[0 1.1*max(costchart(find(costchart < Inf)))]); %CLim将CData中的值与colormap对应起来: [cmin cmax] Color axis limits （不过不太明白为什么要*1.1）
    
    drawnow; %cmin is the value of the data mapped to the first color in the colormap. cmax is the value of the data mapped to the last color in the colormap
    
end

if max(ismember(setOpen,goalposind)) %当找到目标点时
    disp('Solution found!'); %disp： Display array， disp(X)直接将矩阵显示出来，不显示其名字，如果X为string，就直接输出文字X
    % now find the way back using FIELDPOINTERS, starting from goal position
    
    p = findWayBack(goalposind,fieldpointers);
    
    % plot final path
    
    plot(p(:,2)+0.5,p(:,1)+0.5,'Color',0.2*ones(3,1),'LineWidth',4);
    
    drawnow;
    
else
    if isempty(setOpen)
        disp('No Solution!');
    end
end



