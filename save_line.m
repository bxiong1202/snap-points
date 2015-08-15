function lineOriHist=save_line(image_file_name,save_path)


lineAngles={};
lineOriHist=[];


for imindex=1:numel(image_file_name)
    lines = saveLineFeature1(image_file_name{imindex},'');
    angle0=getAtan(lines);
    lineAngles{imindex}=angle0;
    
    
    lineHist=hist(angle0,-pi/2+pi/128:pi/64:pi/2);
    
    if sum(lineHist)~=0
        lineHist=  [numel(angle0) lineHist/sum(lineHist)];
    else
        lineHist=  [0 lineHist];
    end
    lineOriHist=[lineOriHist; lineHist]; 
    
end



save(save_path,'lineOriHist');
