clear;
close all;

ImageHeight = 112;
ImageWidth = 92;

load QueryVecImage.mat QueryVecImage;
load DBVecImages.mat DBVecImages;

[~,NumDBImages] = size(DBVecImages);

SSDVal = zeros(NumDBImages,1);

%%% loop through each column of DBVecImages
%%% calculate the SSD of the query image and the ith DBVecImage
%%% add to SSDVal
for i=1:NumDBImages
    SSDVal(i, :) = SSD(QueryVecImage, DBVecImages(:, i));
end

save QuerySSD.mat SSDVal;

for i=1:10
    display(sprintf('Image%03d: SSD value = %f',i,SSDVal(i)));
end
