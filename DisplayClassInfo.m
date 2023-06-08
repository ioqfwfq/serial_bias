function Class = DisplayClassInfo
d1 = 10;   %10;% max distance, degree
RowLable = cumsum(ones(5,5),1);
ColLable = cumsum(ones(5,5),2);
xLable = (ColLable-3)*d1/2;
yLable = (flipud(RowLable)-3)*d1/2;
untiClockLoc =[3 3;3 5;2 5;1 5; 1 4;1 3;1 2; 1 1;2 1; 3 1;4 1;5 1;5 2;5 3;5 4; 5 5;4 5;...
               3 4;2 4; 2 3; 2 2; 3 2;4 2;4 3; 4 4];
nClass = 0;
Class = [];
for n = 1 : 5
    for m = 1 : 5
        nClass = nClass+1;
        xLoc = untiClockLoc(nClass,1);
        yloc = untiClockLoc(nClass,2);
        Class(nClass,:) = [xLable(xLoc,yloc) yLable(xLoc,yloc)]
    end
end

Class;