function axishandle = createFigure(field,costchart,startposind,goalposind)
% This function creates a pretty figure
% If there is no figure open, then create one

if isempty(gcbf) %g����ͼ��ľ��
    f1 = figure('Position',[450 150 500 500],'Units','Normalized','MenuBar','none'); 
    %�����Position����ֵΪһ����Ԫ���� rect = [left, bottom, width, height]����һ������������ʾ����λ�ã����Ǵ���Ļ�����½Ǽ����

    %normalized �� Units map the lower-left corner of the figure window to (0,0) and the upper-right corner to (1.0,1.0).
    Caxes2 = axes('position', [0.01 0.01 0.98 0.98],'FontSize',12,'FontName','Helvetica'); 
else
    % get the current figure, and clear it
    gcf; cla;
end

n = length(field);

% plot field where walls are black, and everything else is white 
field(field < Inf) = 0; 
pcolor([1:n+1],[1:n+1],[field field(:,end); field(end,:) field(end,end)]); %����һ��һ��

% set the colormap for the ploting the cost and looking really nice
cmap = flipud(colormap('jet')); %flipud���ڷ�ת���� colormapΪ����jet���͵���ɫ�� jet ranges from blue to red

% make first entry be white, and last be black
cmap(1,:) = zeros(3,1); cmap(end,:) = ones(3,1); %�ı���ɫ��βɫ��Ϊ(0,0,0)�Ǻ�ɫ����ɫ��Ϊ(1,1,1)�ǰ�ɫ

% apply the colormap, but make red be closer to goal ��ɫ�Ǹ��ӽ�Ŀ�����ɫ
colormap(flipud(cmap));

hold on;

% now plot the f values for all tiles evaluated
axishandle = pcolor([1:n+1],[1:n+1],[costchart costchart(:,end); costchart(end,:) costchart(end,end)]);

% plot goal as a yellow square, and start as a green circle
[goalposy,goalposx] = ind2sub([n,n],goalposind); %ע�ⷵ�ص��к��е�λ��
[startposy,startposx] = ind2sub([n,n],startposind);
plot(goalposx+0.5,goalposy+0.5,'ys','MarkerSize',10,'LineWidth',6); %��0.5��Ϊ�˰������Ƶ��������룬'ys'��y��ʾyellow,s��ʾSquare(����)
plot(startposx+0.5,startposy+0.5,'go','MarkerSize',10,'LineWidth',6); %'go'��g��ʾgreen,o��ʾCircle(Բ��)

% add a button so that can re-do the demonstration
uicontrol('Style','pushbutton','String','RE-DO', 'FontSize',12,'Position', [1 1 60 40], 'Callback','astardemo');

end

% end of this function