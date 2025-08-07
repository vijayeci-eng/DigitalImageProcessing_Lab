clc;
close all;
clear all;

% -------------------------------------------------------------------------
% BIT PLANE SLICING 
% This script reads a grayscale image (or converts RGB to grayscale),
% and extracts all 8 bit-planes (from LSB to MSB) using pure logic.
% Each bit plane is then displayed using subplot.
%
% Done By: [A.Vijay Teja]
% Date: [7th Aug]
% -------------------------------------------------------------------------

% -------------------------
% Step 1: Read the image
% -------------------------
I = imread("cap.jpg");  % Input image (RGB or grayscale)

% -------------------------
% Step 2: Convert to grayscale if image is RGB
% -------------------------
[rows, cols, channels] = size(I);

if channels == 3
    % Initialize grayscale image
    gray = zeros(rows, cols, 'uint8');
    
    % Manually compute grayscale using average method
    for i = 1:rows
        for j = 1:cols
            R = I(i, j, 1);
            G = I(i, j, 2);
            B = I(i, j, 3);
            gray(i, j) = uint8((double(R) + double(G) + double(B)) / 3);
        end
    end
else
    % Already grayscale
    gray = I;
end

% Display the grayscale image
figure;
imshow(gray);
title('Grayscale Image');

% -------------------------
% Step 3: Initialize bit plane storage
% -------------------------
bit_planes = zeros(rows, cols, 8, 'uint8');  % 8 bit planes

% -------------------------
% Step 4: Perform bit plane slicing (LSB to MSB)
% -------------------------
for i = 1:rows
    for j = 1:cols
        pixel = double(gray(i, j));  % Convert to double for arithmetic
        
        % Loop from bit 1 (LSB) to bit 8 (MSB)
        for k = 1:8
            % Extract the k-th bit using division and modulo
            bit_value = mod(floor(pixel / 2^(k - 1)), 2);
            bit_planes(i, j, k) = bit_value;
        end
    end
end

% -------------------------
% Step 5: Display bit planes
% -------------------------
figure('Name', 'Bit Planes (LSB to MSB)');
for k = 1:8
    subplot(2, 4, k);
    imshow(logical(bit_planes(:, :, k)));  % Convert to logical for display
    title(['Bit Plane ', num2str(k)]);     % k = 1 is LSB, k = 8 is MSB
end

% -------------------------------------------------------------------------
% END OF SCRIPT
% -------------------------------------------------------------------------
