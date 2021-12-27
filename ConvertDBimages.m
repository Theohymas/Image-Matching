clear;
close all;

ImageHeight = 112;
ImageWidth = 92;
VectorSize = ImageHeight*ImageWidth;

ImageFiles = dir('*.png');
NumDBImages = length(ImageFiles);
DBVecImages = zeros(VectorSize,NumDBImages);
for i=1:NumDBImages
    DBImg = imread(ImageFiles(i).name);
    DBImg = double(DBImg);
    %%% convert DBImg matrix to a vector by concatenating the columns
    VecImg = DBImg(:);
    %%% add VecImg to the ith column of DBVecImages
    DBVecImages(:,i) = VecImg;
end

save DBVecImages.mat DBVecImages;

