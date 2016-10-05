%
%   Sam Boles  Image processing Lab 2 4/1/2016
%
%

% 
% W = imread('writing.bmp');
% R = imread('rainbow.bmp');
% 
% Wr = im2double(W);
% Ra = im2double(R);
% 
% Output = Wr .* Ra;
% 
% imshow(Output);
% 
clc;
clear all;
close all;

Im = imread('images.jpg');
I = im2double(Im);
[R,C,D] = size(I);

% imshow(I);

G = [1 4 1; 4 7 4; 1 4 1]/27;
% 
% GS = fspecial('gaussian');
% 
% I = rgb2gray(I);
% Output = I;
% 
% for i = 1:4
%     Output = conv2(Output, G, 'same');
% end
% 
% subplot(1, 2, 1), imshow(Output);
% subplot(1, 2, 2), imshow(I);

% 
playI = I;
for r=2:R-1
    for c=2:C-1
        for d=1:3
            if mod(r,2) == 0 && mod(c,d) == 0
                playI(r,c,d) = 0;
            end
        end
    end
end
% 
% imshow(I);

[GR, GC] = size(G);
radr = floor(GR/2);
radc = floor(GC/2);

Output = I;
cookie = G;
CookiedOutput = I;
for r=2:R-radr
    for c=2:C-radc
        for d=1:3
            % Pixel by pixel
            Output(r,c,d) = I(r-1,c,d)*G(1,2) + I(r-1,c-1,d)*G(1,1)+ I(r-1,c+1,d)*G(1,3);
            Output(r,c,d) = Output(r,c,d) + I(r,c,d)*G(2,2) + I(r,c-1,d)*G(2,1)+ I(r,c+1,d)*G(2,3);
            Output(r,c,d) = Output(r,c,d) + I(r+1,c,d)*G(3,2) + I(r+1,c-1,d)*G(3,1)+ I(r+1,c+1,d)*G(3,3);
            
            % Cookies 
            cookie = I(r-radr:r+radr,c-radc:c+radc,d);
            cookie = cookie .* G;
            CookiedOutput(r,c,d) = sum(cookie(:));
        end
    end
end


subplot(2, 2, 1), imshow(Output);
subplot(2, 2, 2), imshow(CookiedOutput);
subplot(2, 2, 3), imshow(I);
subplot(2, 2, 4), imshow(playI);