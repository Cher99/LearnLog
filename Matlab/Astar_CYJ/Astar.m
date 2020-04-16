%% ASTARDEMO Demonstration of ASTAR algorithm
%
% Copyright Bob L. Sturm, Ph. D., Assistant Professor
% Department of Architecture, Design and Media Technology
% formerly Medialogy
% Aalborg University i Ballerup
% formerly Aalborg University Copenhagen
%
% $Revision: 0.1 $ $Date: 2011 Jan. 15 18h24:24$

%% ��ͼ���벢�ֲ�Ϊ����
OMap=imread('Mmap.png');
Gmap=rgb2gray(OMap);
M_size=size(Gmap);
disp(['========��ͼ��Ϣ=======����',num2str(M_size(2)),',��',num2str(M_size(1))]);
OMap=[ones(300,M_size(2),3);OMap;ones(M_size(2)-M_size(1)-300,M_size(2),3)];
n = input('�ֱ���n��'); % ��ԭ��ͼ����Ϊn�ֱ��ʵ�դ�񻯵�ͼ��
Num = input('�ϰ������ Num��');

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
while ~max(ismember(setOpen,goalposind)) && ~isempty(setOpen) %ismember(A,B)������Aͬ��С�ľ�������Ԫ��1��ʾA����Ӧλ�õ�Ԫ����B��Ҳ���֣�0����û�г���
    % for the element in OPEN with the smallest cost
    
    [temp, ii] = min(setOpenCosts + setOpenHeuristics); %��OPEN����ѡ�񻨷���͵ĵ�temp,ii�����±�(Ҳ���Ǳ������)
    
    % find costs and heuristic of moving to neighbor spaces to goal
    % in order 'R','L','D','U'
    [costs,heuristics,posinds] = findFValue(setOpen(ii),setOpenCosts(ii),field,goalposind,'euclidean');
    %��չtemp���ĸ�����㣬���������posinds������������ʵ�ʴ���costs����������heuristics
    
    % put node in CLOSED and record its cost
    setClosed = [setClosed; setOpen(ii)]; %��temp����CLOSE����
    setClosedCosts = [setClosedCosts; setOpenCosts(ii)]; %��temp�Ļ��Ѽ���ClosedCosts
    
    % update OPEN and their associated costs ����OPEN�� ��Ϊ�������
    if (ii > 1 && ii < length(setOpen)) %temp��OPEN����м䣬ɾ��temp
        setOpen = [setOpen(1:ii-1); setOpen(ii+1:end)];
        setOpenCosts = [setOpenCosts(1:ii-1); setOpenCosts(ii+1:end)];
        setOpenHeuristics = [setOpenHeuristics(1:ii-1); setOpenHeuristics(ii+1:end)];
    elseif (ii == 1)
        setOpen = setOpen(2:end); %temp��OPEN��ĵ�һ��Ԫ�أ�ɾ��temp
        setOpenCosts = setOpenCosts(2:end);
        setOpenHeuristics = setOpenHeuristics(2:end);
    else %temp��OPEN������һ��Ԫ�أ�ɾ��temp
        setOpen = setOpen(1:end-1);
        setOpenCosts = setOpenCosts(1:end-1);
        setOpenHeuristics = setOpenHeuristics(1:end-1);
    end
    
    % for each of these neighbor spaces, assign costs and pointers;
    % and if some are in the CLOSED set and their costs are smaller,
    % update their costs and pointers
    
    for jj=1:length(posinds) %������չ���ĸ����������
        
        % if cost infinite, then it's a wall, so ignore
        if ~isinf(costs(jj)) %����˵��ʵ�ʴ��۲�ΪInf,Ҳ����û������ǽ
            
            % if node is not in OPEN or CLOSED then insert into costchart and
            % movement pointers, and put node in OPEN
            if ~max([setClosed; setOpen] == posinds(jj)) %����˵㲻��OPEN���CLOSE����
                fieldpointers(posinds(jj)) = movementdirections(jj); %���˵�ķ�����ڶ�Ӧ��fieldpointers�� 
                costchart(posinds(jj)) = costs(jj); %��ʵ�ʴ���ֵ�����Ӧ��costchart��
                setOpen = [setOpen; posinds(jj)]; %���˵����OPEN����
                setOpenCosts = [setOpenCosts; costs(jj)]; %����OPEN��ʵ�ʴ���
                setOpenHeuristics = [setOpenHeuristics; heuristics(jj)]; %����OPEN����������
                
                % else node has already been seen, so check to see if we have
                % found a better route to it.
            elseif max(setOpen == posinds(jj)) %����˵���OPEN����
                I = find(setOpen == posinds(jj)); %�ҵ��˵���OPEN���е�λ��
                
                % update if we have a better route
                if setOpenCosts(I) > costs(jj) %�����OPEN���еĴ˵�ʵ�ʴ��۱��������õĴ� 
                    costchart(setOpen(I)) = costs(jj); %����ǰ�Ĵ��۴���costchart�У�ע��˵���costchart�е�������������������һ�µģ�setOpen(I)��ʵ����posinds(jj)������ͬfieldpointers
                    setOpenCosts(I) = costs(jj); %����OPEN���еĴ˵���ۣ�ע��˵���setOpenCosts�е���������setOpen����һ�µģ���ͬsetOpenHeuristics
                    setOpenHeuristics(I) = heuristics(jj); %����OPEN���еĴ˵���������(����Ϊ�����û�б��)
                    fieldpointers(setOpen(I)) = movementdirections(jj); %���´˵�ķ���
                end
                
                % else node has already been CLOSED, so check to see if we have
                % found a better route to it.
            else %����˵���CLOSE���У�˵���Ѿ���չ���˵�
                
                % find relevant node in CLOSED
                I = find(setClosed == posinds(jj));
                
                % update if we have a better route
                if setClosedCosts(I) > costs(jj) %�����CLOSE���еĴ˵�ʵ�ʴ��۱��������õĴ���һ�����⣬�����˵���չ�ĵ㻹��Ҫ���µ�ǰ������!!!��
                    costchart(setClosed(I)) = costs(jj); %����ǰ�Ĵ��۴���costchart��
                    setClosedCosts(I) = costs(jj); %����CLOSE���еĴ˵����
                    fieldpointers(setClosed(I)) = movementdirections(jj); %���´˵�ķ��� 
                end
                
            end
            
        end
        
    end
    
    if isempty(setOpen)
        break;
    end %��OPEN��Ϊ�գ�������Ծ��������е��Ѿ���ѯ���
    
    set(axishandle,'CData',[costchart costchart(:,end); costchart(end,:) costchart(end,end)]);
    
    % hack to make image look right
    
    set(gca,'CLim',[0 1.1*max(costchart(find(costchart < Inf)))]); %CLim��CData�е�ֵ��colormap��Ӧ����: [cmin cmax] Color axis limits ��������̫����ΪʲôҪ*1.1��
    
    drawnow; %cmin is the value of the data mapped to the first color in the colormap. cmax is the value of the data mapped to the last color in the colormap
    
end

if max(ismember(setOpen,goalposind)) %���ҵ�Ŀ���ʱ
    disp('Solution found!'); %disp�� Display array�� disp(X)ֱ�ӽ�������ʾ����������ʾ�����֣����XΪstring����ֱ���������X
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



