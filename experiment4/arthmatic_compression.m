% -------------------------------------------------------------------------
% Done By : A.Vijay Teja
% Date    : 24-08-2025
% -------------------------------------------------------------------------
% ARITHMETIC CODING IMAGE COMPRESSION (PURE VERSION)
% -------------------------------------------------------------------------
% PROCESS:
% 1. Read input image (convert to grayscale & resize)
% 2. Flatten image into pixel sequence
% 3. Build frequency counts of pixel values
% 4. Arithmetic Encode the pixel sequence
% 5. Arithmetic Decode to reconstruct
% 6. Display:
%       - Original Image (with original size)
%       - Reconstructed Image (with compressed size)
%       - Bar chart showing Original vs Compressed size
% -------------------------------------------------------------------------

clc;
clear all;
close all;

% -------------------------------------------------------------------------
% STEP 1: IMAGE PREPROCESSING
% -------------------------------------------------------------------------
img = imread('cap.jpg');        % <-- Change filename if needed
if size(img,3) == 3             % If RGB, convert to grayscale
    img = rgb2gray(img);
end
img = imresize(img,[128 128]);  % Resize for faster demo
[rows,cols] = size(img);

% Flatten into 1D sequence
symbols = img(:)';              % Pixel sequence (0–255)

% -------------------------------------------------------------------------
% STEP 2: FREQUENCY MODEL
% -------------------------------------------------------------------------
% Build histogram of pixel values
counts = histcounts(symbols,0:256);   % Counts of each symbol (0–255)

% -------------------------------------------------------------------------
% STEP 3: ARITHMETIC ENCODING
% -------------------------------------------------------------------------
% +1 since symbols go from 0 to 255 (MATLAB index starts at 1)
encoded = arithenco(symbols+1, counts);

% -------------------------------------------------------------------------
% STEP 4: DECODING
% -------------------------------------------------------------------------
decoded = arithdeco(encoded, counts, numel(symbols)) - 1;
reconImg = reshape(uint8(decoded), [rows cols]);

% -------------------------------------------------------------------------
% STEP 5: SIZE CALCULATION
% -------------------------------------------------------------------------
origBits = numel(symbols)*8;     % Original bits
compBits = numel(encoded);       % Compressed bitstream length
origKB = origBits/8/1024;        % In KB
compKB = compBits/8/1024;
ratio = origBits/compBits;       % Compression ratio

% -------------------------------------------------------------------------
% STEP 6: DISPLAY RESULTS
% -------------------------------------------------------------------------
figure;

% -------------------------------------------------------------------------
% Subplot 1 : Show Original Image with its actual size in KB
% -------------------------------------------------------------------------
subplot(1,3,1);
imshow(img);
title(sprintf('Original Image\nSize: %.2f KB',origKB));

% -------------------------------------------------------------------------
% Subplot 2 : Show Reconstructed Image after Arithmetic Decoding
%             Also display compressed size in KB
% -------------------------------------------------------------------------
subplot(1,3,2);
imshow(reconImg);
title(sprintf('Reconstructed Image\nCompressed: %.2f KB',compKB));

% -------------------------------------------------------------------------
% Subplot 3 : Bar Chart comparing Original and Compressed Sizes
%             Also shows Compression Ratio
% -------------------------------------------------------------------------
subplot(1,3,3);
b = bar([origKB compKB]);
set(gca,'XTickLabel',{'Original','Compressed'});
ylabel('Size (KB)');
title(sprintf('Compression Ratio = %.2f : 1',ratio));

% Add labels above bars for clarity
xtips = b.XEndPoints;
ytips = b.YEndPoints;
labels = string(round(b.YData,2));
text(xtips,ytips,labels,'HorizontalAlignment','center','VerticalAlignment','bottom');

% -------------------------------------------------------------------------
% END OF CODE
% -------------------------------------------------------------------------
