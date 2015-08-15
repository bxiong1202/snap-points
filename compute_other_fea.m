% image_file_name: cell of images to compute
% fea_path: path to save line, blur and bow features

function compute_other_fea(image_file_name,fea_path)

save_path_line=fullfile(fea_path,'line');
save_path_blur=fullfile(fea_path,'blur');
save_path_bow=fullfile(fea_path,'bow');

mkdirIfNon(save_path_line);
mkdirIfNon(save_path_blur);
mkdirIfNon(save_path_bow);

save_path_line=fullfile(save_path_line,'line.mat');
save_path_blur=fullfile(save_path_blur,'blur.mat');
save_path_bow=fullfile(save_path_bow,'bow.mat');


save_line(image_file_name,save_path_line);
save_blur(image_file_name,save_path_blur);
save_bow_feature(image_file_name,save_path_bow);



end


function mkdirIfNon(folder_path)
    if ~exist(folder_path,'dir')
        mkdir(folder_path);
    end
end