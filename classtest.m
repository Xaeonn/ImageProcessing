%
% 
%   Image Processing
%   Measurement - Ruler - Class test
%   Sam Boles
%   28/04/2016
% 
%   Method
%       1. Read in the image ruler.jpg
%       2. Convert it to greyscale
%       3. Create a mask matrix by using the max value minus the standard
%       deviation as a threshold
%       4. Erode and dilate the mask a number of times (5) to get rid of
%       noise
%       5. Create an array containing all the x values that are 1s in the
%       mask and an array containing all the y values that are 1s in the
%       mask using the matlab find function
%       6. Get the mean values of each array
%       7. Get the sum the squares of each x value minus the mean of the x
%       values
%       8. Get the sum the of each x value minus the mean of the x
%       values multiplied by the corrasponding y value minus the mean of 
%       the y values
%       9. Get the slope by dividing sum calculated in step 8 by the sum 
%       calculated in step 7
%       10. Calculate the y intercept value c using the equation of a line
%       y=mx+c where the x and y values are the mean of the x values and
%       mean of the y values and m is the slope
%       11. Calculate the values of y for each x value on the mask using
%       y=mx+c and round them
%       12. Set each x,y point to 1 in a line mask matrix
%       13. Make the line mask equal to the element multiplication of the  
%       line mask matrix by the ruler mask matrix to remove positions that  
%       aren't on the ruler
%       14. Use the line mask to draw a red line on the rgb image
%       15. Get the pixel length of the ruler by taking the sum of the line
%       mask
%       16. Get the pixels per cm by diving the pixel length by 16
%       17. Display the image with the pixel length, pixels per cm and red
%       line between the two central endpoints of the ruler
% 
%   Testing
%       I tested the program on a number of different rulers, it works
%       quite well in terms of finding the best fit line if the ruler is
%       a fair bit darker than the background. A red ruler and a black
%       ruler both worked well with a white background, a metalic ruler
%       however did not work so well. If the ruler was light and the
%       background was dark the algorithm would not work as the
%       thresholding assumes the ruler is the darker object.
%       
%   Performance
%       The algorithm uses global thresholding which makes it faster than
%       than most other methods to extract the object. The payoff for this
%       is the shadow is included in the object creating a slight change
%       in the slope of the best fit line. 
%       The program originally looped through each pixel in the mask to see
%       if it was a one this took 11.861 seconds to run. On switching to
%       the matlab find function the program took 1.399 seconds to run
%       instead. 
%       The performance in terms of accuracy was quite good accross
%       multiple similar images as well as the test image. The program
%       successfully picks out the best fit line and calculates the length
%       of the ruler in pixels. 
% 


clc;
clear all;
close all;

rulerCM = 16;

r = imread('ruler.jpg');

Im = im2double(r);
[H,W,D] = size(r);
I = rgb2gray(Im);

threshold = max(I(:))-std(I(:));
M = I<threshold;

el = strel('disk', 1);

for i = 1:5
    M = imdilate(M, el);
end

for i = 1:5
    M = imerode(M, el);
end

[yValues, xValues, v] = find(M);

xMean = mean(xValues);
yMean = mean(yValues);

x2 = 0;
xy = 0;

for i = 1:length(xValues)
    x2 = x2 + (xValues(i) - xMean)^2;
    xy = xy + (xValues(i) - xMean)*(yValues(i) - yMean);
end

slope = xy/x2;

yIntercept = yMean - (slope * xMean);
Line = zeros(H,W);

for i = min(xValues):max(xValues)
    y = (slope*i) + yIntercept;
    y = round(y);
    Line(y,i) = 1;
end

Line = Line .* M;

pixLen = sum(Line(:));
pixPerCent = round(pixLen/rulerCM);

Im(:,:,1) = Im(:,:,1) + Line;
Im(:,:,2) = Im(:,:,2) - Line;
Im(:,:,3) = Im(:,:,3) - Line;

titleText = strcat('Ruler: Pixel length = ', num2str(pixLen), ', Pixels Per CM = ', num2str(pixPerCent));
imshow(Im), title(titleText);