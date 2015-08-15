%Input: imgFilename - path to image
%Output: hists - dense sift computed on multiple scales 
function sift_hists=save_bow_feature(image_file_name,save_path)


conf.phowOpts = {'Sizes', 8, 'Step', 5} ;
conf.quantizer = 'kdtree' ;
model.phowOpts = conf.phowOpts ;
model.numSpatialX = 2 ;
model.numSpatialY = 2 ;
model.quantizer = conf.quantizer ;

load('./mat_file/bow-1000-ego.vocab.mat');
model.vocab = vocab ;
model.kdtree = vl_kdtreebuild(vocab) ;


sift_hists=[];
for i=1:numel(image_file_name)
    im = imread(image_file_name{i}) ;
    sift_hist = getImageDescriptor(model, im);
    sift_hists=[sift_hists sift_hist];
end
sift_hists=sift_hists';

save(save_path,'sift_hists');




function hist = getImageDescriptor(model, im)
% -------------------------------------------------------------------------

im = standarizeImage(im) ;
width = size(im,2) ;
height = size(im,1) ;
numWords = size(model.vocab, 2) ;

% get PHOW features
[frames, descrs] = vl_phow(im, model.phowOpts{:}) ;

% quantize local descriptors into visual words
switch model.quantizer
  case 'vq'
    [~, binsa] = min(vl_alldist(model.vocab, single(descrs)), [], 1) ;
  case 'kdtree'
    binsa = double(vl_kdtreequery(model.kdtree, model.vocab, ...
                                  single(descrs), ...
                                  'MaxComparisons', 50)) ;
end

for i = 1:length(model.numSpatialX)
  binsx = vl_binsearch(linspace(1,width,model.numSpatialX(i)+1), frames(1,:)) ;
  binsy = vl_binsearch(linspace(1,height,model.numSpatialY(i)+1), frames(2,:)) ;

  % combined quantization
  bins = sub2ind([model.numSpatialY(i), model.numSpatialX(i), numWords], ...
                 binsy,binsx,binsa) ;
  hist = zeros(model.numSpatialY(i) * model.numSpatialX(i) * numWords, 1) ;
  hist = vl_binsum(hist, ones(size(bins)), bins) ;
  hists{i} = single(hist / sum(hist)) ;
end
hist = cat(1,hists{:}) ;
hist = hist / sum(hist) ;


function im = standarizeImage(im)
% -------------------------------------------------------------------------

im = im2single(im) ;
if size(im,1) > 320, im = imresize(im, [320 NaN]) ; end