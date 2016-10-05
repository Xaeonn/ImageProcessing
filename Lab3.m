%
% 
%   Image Processing
%   Lab 3
%   Sam Boles
%   11/02/2016
% 
%


clc;
clear all;
close all;


lena = imread('son1.jpg');

I = im2double(lena);
I = rgb2gray(I);
% get size of image

[R,C] = size(I);

% Threshold = mean(I(:));
% ThresholdB = geomean(I(:));


% subplot(1,2,1), imshow(Output);
% subplot(1,2,2), imshow(I);


% I2 = (I - min(I(:)))./(max(I(:)) -min(I(:)));
% Output = I2 > Threshold;
% Output2 = I2 > ThresholdB;
% subplot(1,3,1), imshow(Output);
% subplot(1,3,2), imshow(Output2);
% subplot(1,3,3), imshow(I);

% Threshold = mean(I(:));
% BW = I > Threshold;
% New = BW.*I;
% 
% Count = sum(New(:) > 0);
% Total = sum(New(:));
% Threshold = mean(Total/Count);
% BW = I > Threshold;
% New2 = BW.*I;
% 
% Count = sum(New2(:) > 0);
% Total = sum(New2(:));
% Threshold = mean(Total/Count);
% BW = I > Threshold;
% New3 = BW.*I;
% 
% subplot(2,2,1), imshow(New);
% subplot(2,2,2), imshow(New2);
% subplot(2,2,3), imshow(New3);
% subplot(2,2,4), imshow(I);

% Research and implement adaptive thresholding

% imshow(I);
Out = I;
Out2 = I;
boxR = round(0.03 * R);
boxC = round(0.03 * C);
% maskMax = I < max(I(:)) - range(I(:))* 0.1;
% maskMin = I > min(I(:)) + range(I(:))* 0.1;
% Out = (Out - min(Out(:)))./(max(Out(:)) - min(Out(:)));
over = mean(Out(:));

for r = boxR+1:ceil(boxR/4):R-boxR
   for c = boxC+1:ceil(boxC/4):C-boxC
       box = I(r-boxR:r+boxR, c-boxC:c+boxC);
%        box = (box - min(box(:)))./(max(box(:)) - min(box(:)));
       ra = range(box(:));
       ofs = ra * 0.15;
%        if sum(box(:) == mode(box(:))) > 0.5 * size(box(:))
%            Threshold = max(box(:)-ofs);
%        else
%            Threshold = mean(box(:));
%        end
       loc = (mean(box(:)) + over)/2;
       Threshold = max(box(:))-ra/2;
       Threshold2 = median(box(:)-0.15*ra);
       box1 = box < Threshold;
       box2 = box < Threshold2;
       % box = BW.*box;
       Out(r-boxR:r+boxR, c-boxC:c+boxC) = box1;
       Out2(r-boxR:r+boxR, c-boxC:c+boxC) = box2;
   end
end

subplot(1,2,1), imshow(Out);
subplot(1,2,2), imshow(Out2);