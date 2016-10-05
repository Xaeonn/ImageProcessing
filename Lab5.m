% Lab 5
% Joe Devaney

clc
clear all
close all


original = imread('lena.bmp');
I = im2double(original);
I = rgb2gray(I);

[H,W] = size(I);
% 
element = strel('square', 10);

BW = I > 0.5;

Eroded = imerode(BW, element);
figure
subplot(1,2,1), imshow(I);
subplot(1,2,2), imshow(Eroded);


element = strel('disk', 10);

Eroded = imerode(BW, element);
figure
subplot(1,2,1), imshow(I);
subplot(1,2,2), imshow(Eroded);



element = strel('rectangle', [1,30]);

BW = I > 0.5;

Eroded = imerode(BW, element);
figure
subplot(1,2,1), imshow(I);
subplot(1,2,2), imshow(Eroded);

BW = I > 0.5;
h = 9;
w = 9;
E = zeros(size(BW));

for i = h+1:H-h
    for j = w+1:W-w
        Cookie = I(i-h:i+h, j-w:j+w);
        E(i,j) = min(Cookie(:));
        
    end
end

figure;
subplot(1,2,1), imshow(I);
subplot(1,2,2), imshow(E);

E = zeros(size(BW));

for i = h+1:H-h
    for j = w+1:W-w
        Cookie = I(i-h:i+h, j-w:j+w);
        E(i,j) = max(Cookie(:));
        
    end
end

figure;
subplot(1,2,1), imshow(I);
subplot(1,2,2), imshow(E);

BW = I > 0.5;
el = strel('disk', 5);

E = imerode(BW, el);
D = imdilate(E, el);

D = imdilate(BW, el);
E = imerode(D, el);

el2 = strel('square', 1);
E2 = imerode(BW, el2);
B = BW - E2;

subplot(1,2,1), imshow(I), title('Original');
subplot(1,2,2), imshow(E), title('Closed');

imshow(B);

% Use getpts to get location of user click
% Set pixel in 'Object' at this location to 1
% Use pixel intensity as the inital ROI (Region of Interest) mean
% Dilate this to grow the region
% Use this as a mask to get the equivalent pixels from original image
% Test each of these against the mean
% Kepp only those that match (ish)
% Update the mean
% Repeat
% Can use variance or gradient for more complex images (more textured)
% Can only look at boundary pixels
% Think about termination Criterion
% Pause Function pause(1)