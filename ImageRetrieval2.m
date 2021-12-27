clear;
close all;

ImageHeight = 112;
ImageWidth = 92;

Tau = 22000000;

load QueryVecImage.mat QueryVecImage;
load DBVecImages.mat DBVecImages;
load QuerySSD.mat SSDVal;

%%% initialise the vector with columns big enough to store a DBVecImage
RetrievedVecImages = zeros(10304, 1);

%%% initilise integer to count the number of images under the threshold
NumRetrievedImages = 0;

%%% TIME TO BEAT IS 0.00386

%%% Convert column vector to row vector
SSDRow = SSDVal.';

%%% Add SSDRow to the top of the DBVecImages matrix
SortDBVecImages = [SSDRow; DBVecImages];

%%% Sort columns according to ascending order of the SSD values
Sorted = sortrows(SortDBVecImages.', 1).';

%%% while SSD value is less  than Tau, iterate through Sorted
%%% Add VecImages to RetreivedImages without the SSD value in row 1
n=1;
tic
while Sorted(1, n) < Tau
    RetrievedVecImages(:, n) = Sorted(2:end, n);
    n= n+1;
end
toc

%%% Set NumRetrievedImages to the number or iterations through sorted -1
NumRetrievedImages = n -1;

figure(1);
DisplayPatches(RetrievedVecImages', NumRetrievedImages, ImageHeight, ImageWidth, NumRetrievedImages);
