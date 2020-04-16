function axishandle = createFigure(field,costchart,startposind,goalposind)
% This function creates a pretty figure
% If there is no figure open, then create one

if isempty(gcbf) %g返回图像的句柄
    f1 = figure('Position',[450 150 500 500],'Units','Normalized','MenuBar','none'); 
    %这里的Position属性值为一个四元数组 rect = [left, bottom, width, height]，第一、二个参数表示窗口位置，都是从屏幕的左下角计算的

    %normalized — Units map the lower-left corner of the figure window to (0,0) and the upper-right corner to (1.0,1.0).
    Caxes2 = axes('position', [0.01 0.01 0.98 0.98],'FontSize',12,'FontName','Helvetica'); 
else
    % get the current figure, and clear it
    gcf; cla;
end

n = length(field);

% plot field where walls are black, and everything else is white 
field(field < Inf) = 0; 
pcolor([1:n+1],[1:n+1],[field field(:,end); field(end,:) field(end,end)]); %多了一行一列

% set the colormap for the ploting the cost and looking really nice
cmap = flipud(colormap('jet')); %flipud用于反转矩阵 colormap为产生jet类型的颜色表 jet ranges from blue to red

% make first entry be white, and last be black
cmap(1,:) = zeros(3,1); cmap(end,:) = ones(3,1); %改变颜色表将尾色变为(0,0,0)是黑色，起色变为(1,1,1)是白色

% apply the colormap, but make red be closer to goal 红色是更接近目标的颜色
colormap(flipud(cmap));

hold on;

% now plot the f values for all tiles evaluated
axishandle = pcolor([1:n+1],[1:n+1],[costchart costchart(:,end); costchart(end,:) costchart(end,end)]);

% plot goal as a yellow square, and start as a green circle
[goalposy,goalposx] = ind2sub([n,n],goalposind); %注意返回的列和行的位置
[startposy,startposx] = ind2sub([n,n],startposind);
plot(goalposx+0.5,goalposy+0.5,'ys','MarkerSize',10,'LineWidth',6); %加0.5是为了把坐标移到方块中央，'ys'中y表示yellow,s表示Square(方形)
plot(startposx+0.5,startposy+0.5,'go','MarkerSize',10,'LineWidth',6); %'go'中g表示green,o表示Circle(圆形)

% add a button so that can re-do the demonstration
uicontrol('Style','pushbutton','String','RE-DO', 'FontSize',12,'Position', [1 1 60 40], 'Callback','astardemo');

end

% end of this function