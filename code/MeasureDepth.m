function [ rDepth ] = MeasureDepth( BW2 )
% Measures depth of the root
[row,~] = find(BW2>0);
TopPoint=min(row);
BottomPoint=max(row);
Length=BottomPoint-TopPoint;
rDepth=Length;
end

