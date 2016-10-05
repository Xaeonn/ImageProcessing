%
%
%   Image Processing
%   Assignment 1
%   Sam Boles
%   04/02/2016
%
%   Finds the location with the highest correlation between the image
%   template.bmp and the image lena.bmp. It then shows the image with a box
%   around the best match.
%
%   It uses a pixel by pixel scan with a cookie matrix cut out. It takes the
%   difference of the cookie and the template. It then gets the variance within
%   the result and chooses the minimum variance as the answer.
%   The method used allows for both some change in the intensity of the image
%   and some small alterations to the image.
%
%   It was tested with the lena image and the eye cutout as well as a couple of
%   other images and cutouts of them. It successfully matched against 0.7 times
%   the template (darker) and 1.5 times the template (brighter). It also
%   successfully managed to identify the cutouts location with black squiggles
%   drawn in paint on the template.
%


clc;
clear all;
close all;

lena = imread('lena.bmp');
template = imread('template.bmp');

I = im2double(lena);
T = im2double(template);

[R,C,D] = size(I);
[TR, TC, TD] = size(T);

% Set the min difference to be the max value of a real number
minDif = realmax();
% Loop through image pixels
% In each case
% set cookie to be a region equal to the size of the template
% top corner at the current r,c,d
% get current layer(RGB)of template
% get difference between cookie pixels and template pixels
% get the variance of differences
% add the variance of differences for the current color layer to dif
% Once the three layers are done then check if it is smaller than the
% previous minimum variance/minDif and set it and minLoc to the value and
% location
for r=1:R-TR
    for c=1:C-TC
        dif = 0;
        for d=1:3
            cookie = I(r:r+TR-1, c:c+TC-1, d);
            TDep = T(:,:,d);
            val = cookie - TDep;
            val = var(val(:));
            dif = dif + val;
        end
        if dif < minDif
            minDif = dif;
            minLoc = [r,c];
        end
    end
end

% Create Output image
Output = I;
% define values for the edges of the box
tRow = minLoc(1);
bRow = minLoc(1)+TR;

tCol = minLoc(2);
bCol = minLoc(2)+TC;

% Draw black lines around best match
% % Top
Output(tRow,tCol:bCol,:) = 0.0;
%
% % Left
Output(tRow:bRow,tCol,:) = 0.0;

% % Bottom
Output(bRow,tCol:bCol,:) = 0.0;
%
% % Right
Output(tRow:bRow,bCol,:) = 0.0;


imshow(Output);
