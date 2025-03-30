% Created by Om Hajare
% Edge Detection using sobel,prewit,robert,canny,LoG and Zero-Crossing
% Using inbuilt function


clear all;  
close all; 
clc;        

% Read the image from the given URL
I = imread('https://imgs.search.brave.com/eUt9huxzUVB-nq3XQzMSqGXdVSY5-wENGENFU1VE8-0/rs:fit:500:0:0:0/g:ce/aHR0cDovL2xlbm5h/Lm9yZy9sZW5fc3Rk/LmpwZw');

% Convert the image to grayscale
I_gray = rgb2gray(I);

% Apply different edge detection techniques
BW1 = edge(I_gray, 'sobel');      % Sobel edge detection
BW2 = edge(I_gray, 'canny');      % Canny edge detection
BW3 = edge(I_gray, 'prewitt');    % Prewitt edge detection
BW4 = edge(I_gray, 'roberts');    % Roberts edge detection
BW5 = edge(I_gray, 'log');        % Laplacian of Gaussian (LoG) edge detection
BW6 = edge(I_gray, 'zerocross');  % Zero-crossing edge detection

% Display results using a tiled layout
tiledlayout(2,4);

% Display original image
nexttile; imshow(I);
title('Original Image');

% Display Sobel edge detection result
nexttile; imshow(BW1);
title('Sobel');

% Display Canny edge detection result
nexttile; imshow(BW2);
title('Canny');

% Display Prewitt edge detection result
nexttile; imshow(BW3);
title('Prewitt');

% Display Roberts edge detection result
nexttile; imshow(BW4);
title('Roberts');

% Display Laplacian of Gaussian edge detection result
nexttile; imshow(BW5);
title('LoG');

% Display Zero-Crossing edge detection result
nexttile; imshow(BW6);
title('Zero-Crossing');
