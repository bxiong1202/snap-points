
% image_file_name: cell of images to compute
% fea_path: path to save line, blur and bow features

function compute_sp_feature(image_file_name,feat_path)


path_to_lower_feature=feat_path;

if ~exist(feat_path,'dir')% lineAngles={};
    mkdir(feat_path)
end
img_path='';


global GVARS;
GVARS.data_path = pwd;
GVARS.code_path = fullfile(GVARS.data_path, 'SUN_source_code_v2/code/');
GVARS.attributes = '';
GVARS.images=image_file_name;
GVARS.test_train_set_path=[path_to_lower_feature '/'];

%if ~ex
save(fullfile(path_to_lower_feature,'image_file_name.mat'),'image_file_name');
calc_feature_set(img_path,feat_path);















