function lines = saveLineFeature1(imdir,outdir)
img=imread(imdir);
if size(img,3)==3
    img=rgb2gray(img);
end
line_limit = (size(img,1)^2+size(img,2)^2)^(1/2)*0.02;
lines = APPgetLargeConnectedEdges(img, line_limit);

%figure(1), hold off, imshow(img)
%figure(1), hold on, plot(lines(:, [1 2])', lines(:, [3 4])')

%save(outdir,'lines');
