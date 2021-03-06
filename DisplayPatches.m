function [C] = DisplayPatches(Data, DisplayNumber, PatchHeight, PatchWidth, ColSize)

[PatchNum, PatchSize] = size(Data);

if PatchSize ~= PatchHeight*PatchWidth
    display('Patch size incompatible with data...');
    return;
end

if PatchNum > DisplayNumber
    PatchNum = DisplayNumber;
end

% display patches
DispPatch = zeros(PatchNum, PatchHeight+2, PatchWidth+2);
for i=1: PatchNum,
    DispPatch(i,2:end-1,2:end-1) = reshape(Data(i,:),PatchHeight,PatchWidth);
end

MinVal = min(DispPatch(:));
MaxVal = max(DispPatch(:));
for i=1: PatchNum;
%     if i==1 %%% for displaying pca only
%         MinVal = -1;
%         MaxVal = 1;
%     else
%         MinVal = min(min(DispPatch(i,2:end-1,2:end-1)));
%         MaxVal = max(max(DispPatch(i,2:end-1,2:end-1)));
%     end
    if (MaxVal-MinVal)>0 
        DispPatch(i,2:end-1,2:end-1) = (DispPatch(i,2:end-1,2:end-1)-MinVal)/(MaxVal-MinVal)*255;
    else
        DispPatch(i,:,:) = 0;
    end
end

if nargin < 5
    ColSize = floor(sqrt(PatchNum));
end
RowSize = floor(DisplayNumber/ColSize);
A = squeeze(DispPatch(1,:,:));
for j=2: ColSize
    B = squeeze(DispPatch(j,:,:));
    A = cat(2,A,B);
end
C = A;
clear A;
image(C);
% for i=2: ColSize-1
for i=2:RowSize;
    A = squeeze(DispPatch(((i-1)*ColSize)+1,:,:));
    for j=2: ColSize
        B = squeeze(DispPatch(((i-1)*ColSize)+j,:,:));
        A = cat(2,A,B);
    end 
    C = cat(1,C,A);
    clear A;
end
imagesc(C);
colormap gray;
axis off;
axis image;
clear DispPatch;
