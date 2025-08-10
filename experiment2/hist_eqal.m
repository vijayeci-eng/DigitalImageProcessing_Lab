% =========================================================================
% Histogram Equalization (Manual Implementation)
% -------------------------------------------------------------------------
% Reads an image, converts to grayscale (if needed), computes histogram,
% performs histogram equalization using the CDF method (manual mapping),
% and displays the original image, original histogram, equalized image,
% and equalized histogram with explanatory comments for each plot.
%
% Done By : A.Vijay Teja
% Date: 10 Aug 2025
% =========================================================================


close all;   
clc;         

% Read image
I = imread("demo.jpg"); 

% Convert to grayscale if needed
if size(I,3) == 3
    I = uint8(mean(I, 3)); 
end

[M, N] = size(I);              
num_pixels = M * N;            

% Flatten image
I_flat = I(:);

% Histogram
histogram = zeros(1, 256);
for i = 1:num_pixels
    histogram(I_flat(i) + 1) = histogram(I_flat(i) + 1) + 1;
end

% CDF
cdf = cumsum(histogram);
cdf_min = min(cdf(cdf > 0));   

% Equalization mapping
equalized = zeros(1, 256);
for i = 1:256
    equalized(i) = round((cdf(i) - cdf_min) / (num_pixels - cdf_min) * 255);
end

% Apply mapping
I_eq_flat = zeros(1, num_pixels);
for i = 1:num_pixels
    I_eq_flat(i) = equalized(I_flat(i) + 1);  
end

% Reshape to image
I_eq = reshape(I_eq_flat, M, N);

% Display
figure;

subplot(2,2,1); % Original image
imshow(uint8(I));
title('Original Image'); % shows raw image

subplot(2,2,2); % Histogram before equalization
bar(0:255, histogram);
xlim([0 255]);
title('Original Histogram');

subplot(2,2,3); % Equalized image
imshow(uint8(I_eq));
title('Equalized Image');

subplot(2,2,4); % Histogram after equalization
eq_hist = zeros(1, 256);
for i = 1:num_pixels
    eq_hist(I_eq_flat(i) + 1) = eq_hist(I_eq_flat(i) + 1) + 1;
end
bar(0:255, eq_hist);
xlim([0 255]);
title('Equalized Histogram');

