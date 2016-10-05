%
% 
%   Image Processing
%   Lab 4
%   Sam Boles
%   18/02/2016
% 
%


clc;
clear all;
close all;

% lena = imread('sqk.jpg');
lena = imread('CleanFingerprint.jpg');
I = im2double(lena);
I = rgb2gray(I);

% E = edge(I,'sobel');
% imshow(E);

SobelV = [1 0 -1;
          2 0 -2;
          1 0 -1;]/4;
      
SobelH = [1 2 1;
          0 0 0;
        -1 -2 -1;]/4;
    
    
EH = conv2(I,SobelH);
EV = conv2(I,SobelV);
Ix = EH;
Iy = EV;
OutH = (EH - min(EH(:)))./(max(EH(:)) - min(EH(:)));
OutV = (EV - min(EV(:)))./(max(EV(:)) - min(EV(:)));
OutPy = ((EH.^2) + (EV.^2)).^(0.5);
EH = abs(EH);
EV = abs(EV);


% subplot(2,4,1), imshow(EH);
% subplot(2,4,2), imshow(EV);
% subplot(2,4,3), imshow(EV+EH);
% subplot(2,4,4), imshow((EV+EH)>0.2);
% subplot(2,4,5), imshow(OutH);
% subplot(2,4,6), imshow(OutV);
% subplot(2,4,7), imshow(OutPy);
% subplot(2,4,8), imshow(OutPy>0.2);


% Using Ix and Iy find corners

Ix2 = Ix.^2;
Iy2 = Iy.^2;
Ixy = Ix.*Iy;
Ix2 = conv2(Ix2, fspecial('Gaussian'));
Iy2 = conv2(Iy2, fspecial('Gaussian'));
Ixy = conv2(Ixy, fspecial('Gaussian'));

gam = 0.04;
[H,W] = size(I);
C = (Ix2.*Iy2) - Ixy.^2 - (gam *(Ix2 + Iy2).^2);
C = (C - min(C(:)))./(max(C(:)) - min(C(:)));

TC = 2;
TR = 2;
Out = I;
for r=TR+1:H-(TR+1)
    for c=TC+1:W-(TC+1)
        Cook = I(r-TR:r+TR,c-TC:c+TC);
        Out(r,c) = var(Cook(:));
    end
end
Out = Out(TR+1:H-TR,TC+1:W-TC);
Out = (Out - min(Out(:)))./(max(Out(:)) - min(Out(:)));
imshow(Out);