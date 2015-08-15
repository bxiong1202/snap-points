function bluriness=save_blur(image_file_name,save_path)

bluriness=zeros(numel(image_file_name),1);
for i=1:numel(image_file_name)
    bluriness(i)=blurMetric(imread(image_file_name{i}));
end

save(save_path,'bluriness');