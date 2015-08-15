clear;
clc;

%% add pathes
setup_project;

current_dir=pwd;

%% setpath 

%read image from folder test_frames into cell 
%****************************************************
% to test with your own data, please replace 
% image_file_names 
%****************************************************
image_file_names=readImageNames(fullfile(current_dir,'test_frames'));
feat_path=fullfile(current_dir,'test_fea');

%% compute feature
%compute geo/gist/hog/ssim
%image_file_names: cell array of each image path to compute
%feat_path: where to save the features

compute_sp_feature(image_file_names,feat_path);
%compute bluriness,lineHist,Bag-of-word
compute_other_fea(image_file_names,feat_path);


%% load features
imageFea={};

geo_file=fullfile(feat_path,'geo_color_image_features.mat');
load(geo_file);
imageFea{1}=feature_vector;
gis_file=fullfile(feat_path,'gist_image_features.mat');
load(gis_file);
imageFea{2}=feature_vector;
hog_file=fullfile(feat_path,'hog2x2_image_features.mat');
load(hog_file);
imageFea{3}=feature_vector;
ssi_file=fullfile(feat_path,'ssim_image_features.mat'); 
load(ssi_file);
imageFea{4}=feature_vector;

load(fullfile(feat_path,'blur','blur.mat'),'bluriness');
load(fullfile(feat_path,'line','line.mat'),'lineOriHist');
load(fullfile(feat_path,'bow','bow.mat'),'sift_hists');


%% reduce dimension 

%reduce dimension with pca for HOG etc.
load('mat_file/sun_pac_param.mat');
image_low_data={};
for i=1:4    
    fea=imageFea{i};
    temp_fea=reconstruct_pca(fea,sun397_pac_param{i}{1},sun397_pac_param{i}{2});
    image_low_data{i}=temp_fea';
end


% reduce dimension with pca for bow
load(fullfile(feat_path,'bow','bow.mat'));
load('mat_file/sun_bow_pca.mat','m_mean','Evec_retained');
img_low_data_bow = reconstruct_pca(sift_hists,m_mean,Evec_retained);
img_low_data_bow=img_low_data_bow';
%% data pre-processing

%% load Demo SUN data
% Due to the scale of Sun dataset, only a subset is included. 
% You can use this script to compute complete Sun features
load('mat_file/sun_low_data.mat');

%% concatenate all features together

%performance might be imporved by changing parameters here
%how many eigenvectors to keep for each feature
dim_index=[130 30 350 100];

img_low_data=[];
for i=1:4
    
    img_low_data=[img_low_data imageFea{i}(:,1:dim_index(i))];
    
end

imgLine_new=zeros(size(lineOriHist,1),32);


for i=1:32
    imgLine_new(:,i)=lineOriHist(:,i*2)+lineOriHist(:,i*2+1);
end

num_remain=200;
img_low_data_bow_sift=img_low_data_bow(:,1:num_remain);

%% feautures for webPrior and testImage
img_low_data=[img_low_data img_low_data_bow_sift imgLine_new bluriness];


%% Process features
x_lowerdim_Train=sun_low_data;
x_lowerdim_Test=img_low_data;
x_mean=mean(x_lowerdim_Train);    
x_std=std(x_lowerdim_Train);
x_mean_train=repmat(x_mean,size(x_lowerdim_Train,1),1);
x_mean_test=repmat(x_mean,size(x_lowerdim_Test,1),1);
x_std_train=repmat(x_std,size(x_lowerdim_Train,1),1);
x_std_test=repmat(x_std,size(x_lowerdim_Test,1),1);
x_lowerdim_Train=(x_lowerdim_Train-x_mean_train)./x_std_train;
x_lowerdim_Test=(x_lowerdim_Test-x_mean_test)./x_std_test;

% number of neighbors
nn=30;

% replace with your image features
Xr=x_lowerdim_Train;%sun feature
Xt=x_lowerdim_Test;%test feature
M=eye(size(Xt,2));

%% Uncomment if you want to use domain adaptation

%Domain adaptation with GFK
%num_remain=size(x_lowerdim_Train,2);
%d=floor(num_remain/2)-15;


% Ps = princomp(Xr);  % source subspace
% Pt = princomp(Xt);  % target subspace
% M = GFK([Ps,null(Ps')], Pt(:,1:d));


% End domain adaptation

%% compare distance

dist = repmat(diag(Xr*M*Xr'),1,size(Xt,1)) ...
    + repmat(diag(Xt*M*Xt')',size(Xr,1),1)...
    - 2*Xr*M*Xt';

dist1=sort(dist);

%% sort
dis=sum(dist1(1:nn,:),1);
[~,sortedRank] = sort(dis);


%% show top 10 images 
for k=1:min(10,numel(image_file_names))
    subplot(2,5,k)
    imshow(imread(image_file_names{sortedRank(k)}));
end







