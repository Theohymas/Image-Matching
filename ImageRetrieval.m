clear;
close all;

ImageHeight = 112;
ImageWidth = 92;

Tau = 22000000;

load QueryVecImage.mat QueryVecImage;
load DBVecImages.mat DBVecImages;
load QuerySSD.mat SSDVal;

%%% extract column size of DBVecImages
[~,NumDBImages] = size(DBVecImages);

%%% initialise the vector with columns big enough to store a DBVecImage
RetrievedVecImages = zeros(10304, 1);

%%% initilise integer to count the number of images under the threshold
NumRetrievedImages = 0;

%%% Iterate through DBVecImages and concatenate the VecImage column to
%%% RetrievedVecImages if it is under the threshold(Tau).
%%% increment NumRetrieved values if an image is added.

%%% TIME TO BEAT IS 0.00386
tic
for i=1:NumDBImages
    if SSDVal(i, :) < Tau
        RetrievedVecImages(:, NumRetrievedImages+1) = DBVecImages(:,i);
        NumRetrievedImages = NumRetrievedImages + 1;
    end
end
toc

figure(1);
DisplayPatches(RetrievedVecImages', NumRetrievedImages, ImageHeight, ImageWidth, NumRetrievedImages);
