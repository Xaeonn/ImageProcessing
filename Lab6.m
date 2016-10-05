%
% 
%   Image Processing
%   Lab 6
%   Sam Boles
%   10/03/2016
% 
%   
% 


clc;
clear all;
close all;


fleshy = imread('pacemaker.png');
% I = rgb2gray(Im);
I = im2double(fleshy);
[H,W,D] = size(fleshy);
mn = round(0.07*H);
YC = rgb2ycbcr(fleshy);
Y = YC(:,:,1);
Y = im2double(Y);
for i=1:50
    Y = conv2(Y, fspecial('Gaussian'), 'same');
%     Y(1:15,:) = 1;
%     Y(H-15:H,:) = 1;
%     Y(:,1:15) = 1;
%     Y(:,W-15:W) = 1;
end
imshow(Y);
threshold = median(Y(:)) - std(Y(:));

Out = Y;
X = 2;
Z = 2;
Mask = Y < threshold;
for i=2:X:H-X
    for j=2:Z:W-Z
        cookie = Y(i:i+(X-1),j:j+(Z-1));
        if mean(cookie(:) < threshold)
            Out(i:i+(X-1),j:j+(Z-1)) = ones(X,Z);
        else
            Out(i:i+(X-1),j:j+(Z-1)) = zeros(X,Z);
        end
    end
end

Out(1:mn,:) = 0;
Out(H-mn:H,:) = 0;
Out(:,1:mn) = 0;
Out(:,W-mn:W) = 0;
imshow(Out);
se = strel('disk',1);
se2 = strel('disk',mn);
Out = imdilate(Out, se2);
Out = imerode(Out,se2);
% Out = imdilate(Out, se2);
% Out = imerode(Out,se2);
Eroded = imerode(Out,se);
Boundary = Out - Eroded;

% subplot(121), imshow(Out);
% subplot(122), imshow(Boundary);
imshow(Eroded);

% Cb = YC(:,:,2);
% Cr = YC(:,:,3);
% 
% % 
% % subplot(131), imshow(Y);
% % subplot(132), imshow(Cb);
% % subplot(133), imshow(Cr);
% % imshow(Cr);
% Mask = (Cb>115) &(Cb<145) & (Cr>135) & (Cr<180);
% 
% 
% I(:,:,1) = I(:,:,1) .* (Mask);
% I(:,:,2) = I(:,:,2) .* (Mask);
% I(:,:,3) = I(:,:,3) .* (Mask);
% subplot(121), imshow(Mask);
% subplot(122), contourf(Cb,Cr);

% Y = (Y - min(Y(:)))./(max(Y(:)) - min(Y(:)));