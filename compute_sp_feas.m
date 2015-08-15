function compute_sp_feas(image_file_name,feat_path)



addpath(genpath('./SUN_source_code_v2'));
addpath(genpath('./SUN_source_code_v2/code/vgg-mkl-class-1.1'));
addpath(genpath('./SUN_source_code_v2/code/gist'));
addpath(genpath('./SUN_source_code_v2/code/GeometricContext_dhoiem'));
addpath(genpath('./SUN_source_code_v2/code/vgg-mkl-class-1.1'));
addpath(genpath('./SUN_source_code_v2/code/scene_sun'));
addpath(genpath('./SUN_source_code_v2/code/LabelMeToolbox'));
addpath('/scratch/vision/bxiong/code_v2/SUN_source_code_v2/code/vlfeat-0.9.17/toolbox');
vl_setup;

[a,b]=fileparts(feat_path);
feat_dir=fullfile(a,b);
if ~exist(feat_dir,'dir')
    mkdir(feat_dir)
end

img_path='';

for i=1:numel(image_file_name)
    image_file_name{i}=fullfile('./',image_file_name{i});
    
end



global GVARS;

GVARS.data_path = pwd;
GVARS.code_path = fullfile(GVARS.data_path, 'SUN_source_code_v2/code/');
GVARS.attributes = '';
GVARS.images=image_file_name;
GVARS.test_train_set_path=feat_path;

calc_feature_set(img_path,feat_path);

