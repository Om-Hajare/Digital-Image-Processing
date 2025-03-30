% Created by Om Hajare
% Edge Detection using sobel,prewit,robert,canny,LoG and Zero-Crossing
% Without inbuilt function


clear all; 
close all;  
clc;       

% Read the image from the given URL
I = imread('https://imgs.search.brave.com/eUt9huxzUVB-nq3XQzMSqGXdVSY5-wENGENFU1VE8-0/rs:fit:500:0:0:0/g:ce/aHR0cDovL2xlbm5h/Lm9yZy9sZW5fc3Rk/LmpwZw');

% Convert the image to grayscale
I_gray = rgb2gray(I);

% Define Sobel filter kernels
sobel_x = [-1 0 1; -2 0 2; -1 0 1];
sobel_y = [-1 -2 -1; 0 0 0; 1 2 1];

% Apply Sobel filters in both x and y directions
gx = imfilter(double(I_gray), sobel_x, 'same');
gy = imfilter(double(I_gray), sobel_y, 'same');

% Compute gradient magnitude and apply thresholding
BW1 = sqrt(gx.^2 + gy.^2) > 50; % Sobel edge detection

% Define Prewitt filter kernels
prewitt_x = [-1 0 1; -1 0 1; -1 0 1];
prewitt_y = [-1 -1 -1; 0 0 0; 1 1 1];

% Apply Prewitt filters in both x and y directions
gx = imfilter(double(I_gray), prewitt_x, 'same');
gy = imfilter(double(I_gray), prewitt_y, 'same');

% Compute gradient magnitude and apply thresholding
BW3 = sqrt(gx.^2 + gy.^2) > 50; % Prewitt edge detection

% Define Roberts filter kernels
roberts_x = [1 0; 0 -1];
roberts_y = [0 1; -1 0];

% Apply Roberts filters in both x and y directions
gx = imfilter(double(I_gray), roberts_x, 'same');
gy = imfilter(double(I_gray), roberts_y, 'same');

% Compute gradient magnitude and apply thresholding
BW4 = sqrt(gx.^2 + gy.^2) > 50; % Roberts edge detection

% Define parameters for Laplacian of Gaussian (LoG)
sigma = 2;          % Standard deviation
size = 6 * sigma;   % Kernel size
x = -size/2:size/2; % Define x range
y = x;              % Define y range
[X, Y] = meshgrid(x, y); % Create mesh grid

% Compute the Laplacian of Gaussian (LoG) kernel
LoG = (X.^2 + Y.^2 - 2*sigma^2) .* exp(-(X.^2 + Y.^2) / (2*sigma^2));

% Apply LoG filter and threshold
BW5 = imfilter(double(I_gray), LoG, 'same') > 0; % LoG edge detection

% Perform zero-crossing edge detection
BW6 = edge(I_gray, 'zerocross'); % Zero-crossing method

% Compute gradient magnitude using Sobel filters
gx = imfilter(double(I_gray), sobel_x, 'same');
gy = imfilter(double(I_gray), sobel_y, 'same');
gmag = sqrt(gx.^2 + gy.^2);

% Apply Canny-like edge detection
BW2 = gmag > 0.1 * max(gmag(:)); % Thresholding
BW2 = bwmorph(BW2, 'thin', Inf); % Thinning operation
BW2 = bwareaopen(BW2, 30); % Remove small objects

% Display results using tiled layout
tiledlayout(2,4);

% Display original image
nexttile; imshow(I);
title('Original Image');

% Display Sobel edge detection result
nexttile; imshow(BW1);
title('Sobel');

% Display Canny-like edge detection result
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
