function p = findWayBack(goalposind,fieldpointers)
% This function will follow the pointers from the goal position to the
% starting position

n = length(fieldpointers); % length of the field
posind = goalposind;

% convert linear index into [row column]
[py,px] = ind2sub([n,n],posind);

% store initial position
p = [py px];

% until we are at the starting position
while ~strcmp(fieldpointers{posind},'S')
    switch fieldpointers{posind}
        case 'L' 
        px = px - 1;
        
        case 'R' % move right
        px = px + 1;

        case 'U' % move up
        py = py - 1;

        case 'D' % move down
        py = py + 1;

    end
p = [p; py px];

% convert [row column] to linear index
posind = sub2ind([n n],py,px);
end

end