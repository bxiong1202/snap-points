function low_data=reconstruct_pca(test_data,data_mean,Evec_retained)

stand_data=test_data'- repmat(data_mean,1,size(test_data,1));
low_data=Evec_retained'*stand_data;
