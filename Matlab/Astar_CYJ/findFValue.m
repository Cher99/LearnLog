function [cost,heuristic,posinds] = findFValue(posind,costsofar,field,goalind,heuristicmethod)
% This function finds the movement COST for each tile surrounding POSIND in
% FIELD, returns their position indices POSINDS. They are ordered: right,
% left, down, up.

n = length(field); % length of the field

% convert linear index into [row column]
[currentpos(1) currentpos(2)] = ind2sub([n n],posind); 
[goalpos(1) goalpos(2)] = ind2sub([n n],goalind); %获得目标点的行列坐标,很重要！

% places to store movement cost value and position
cost = Inf*ones(4,1); heuristic = Inf*ones(4,1); pos = ones(4,2);

% if we can look left, we move from the right 向左查询，那么就是从右边来
newx = currentpos(2) - 1; 
newy = currentpos(1);

if newx > 0 
    pos(1,:) = [newy newx]; 

    switch lower(heuristicmethod)
        case 'euclidean' 
        heuristic(1) = abs(goalpos(2)-newx) + abs(goalpos(1)-newy); 

        case 'taxicab'
        heuristic(1) = abs(goalpos(2)-newx) + abs(goalpos(1)-newy);
    end

    cost(1) = costsofar + field(newy,newx);
end

% if we can look right, we move from the left 
newx = currentpos(2) + 1; newy = currentpos(1);
if newx <= n
    pos(2,:) = [newy newx];
    
    switch lower(heuristicmethod)
        case 'euclidean'
        heuristic(2) = abs(goalpos(2)-newx) + abs(goalpos(1)-newy);

        case 'taxicab'
        heuristic(2) = abs(goalpos(2)-newx) + abs(goalpos(1)-newy);
    end

    cost(2) = costsofar + field(newy,newx);
end

% if we can look up, we move from down 
newx = currentpos(2); newy = currentpos(1)-1;
if newy > 0
    pos(3,:) = [newy newx];
    
    switch lower(heuristicmethod)
        case 'euclidean'
        heuristic(3) = abs(goalpos(2)-newx) + abs(goalpos(1)-newy);

        case 'taxicab'
        heuristic(3) = abs(goalpos(2)-newx) + abs(goalpos(1)-newy);
    end

    cost(3) = costsofar + field(newy,newx);
end

% if we can look down, we move from up
newx = currentpos(2); newy = currentpos(1)+1;
if newy <= n
    pos(4,:) = [newy newx];
    
    switch lower(heuristicmethod)
        case 'euclidean'
        heuristic(4) = abs(goalpos(2)-newx) + abs(goalpos(1)-newy);

        case 'taxicab'
        heuristic(4) = abs(goalpos(2)-newx) + abs(goalpos(1)-newy);
    end
    
    cost(4) = costsofar + field(newy,newx);
end

% return [row column] to linear index
posinds = sub2ind([n n],pos(:,1),pos(:,2)); 

end