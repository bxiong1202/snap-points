function [m_mean,Evec_retained]=perform_pac(train_data,num_retain)



%gistTrainImagesDescriptor=ego.trainFeature{2} ;
%gistTestImagesDescriptor=ego.utSmallSet{2} ;
%gistTrainImagesDescriptor=ego.gistTrain;
%gistTestImagesDescriptor=ego.gistTest;

xdata = train_data';
%p=size(train_datagistTrainImagesDescriptor,1);
m_mean = mean(xdata,2); 
x = xdata - repmat(m_mean,1,size(train_data,1)); % subtract the mean
S = cov(x'); % covariance of the data
[Evec,Evalm] = eig(S); Eval = diag(Evalm); % find the e-vals and e-vecs
[evals,index]=sort(Eval); 
index=flipud(index); % find the largest e-vals
Evec_retained = Evec(:,index(1:num_retain)); % get the largest e-vecs
%x_lowerdim_Train1 = Evec_retained'*x; % lower dimensional representation
%x_test = gistTestImagesDescriptor'- repmat(m,1,size(gistTestImagesDescriptor,1));
%x_lowerdim_Test1 = Evec_retained'*x_test;