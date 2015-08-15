function angle=getAtan(lines)
angle=zeros(size(lines,1),1);

for lineIndex=1:size(lines,1)
    if lines(lineIndex,1)>lines(lineIndex,2)
        x1=lines(lineIndex,2);
        x2=lines(lineIndex,1);
        y1=lines(lineIndex,4);
        y2=lines(lineIndex,3);
    else
        x1=lines(lineIndex,1);
        x2=lines(lineIndex,2);
        y1=lines(lineIndex,3);
        y2=lines(lineIndex,4);
        
    end
       
    angle(lineIndex) = atan((y2-y1)/(x2-x1));
end
