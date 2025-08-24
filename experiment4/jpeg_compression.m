% -------------------------------------------------------------------------
% Done By : A.Vijay Teja
% Date   : 24-08-2025
% -------------------------------------------------------------------------
% JPEG COMPRESSION DEMONSTRATION (Grayscale Simplified Version)
% -------------------------------------------------------------------------
% PROCESS FOLLOWED:
% 1. Read and preprocess input image (convert to grayscale & resize)
% 2. Divide into 8x8 blocks and apply Discrete Cosine Transform (DCT)
% 3. Quantize using JPEG standard quantization matrix
% 4. Zigzag scanning of coefficients
% 5. Run-Length Encoding (RLE) for compression
% 6. Reconstruct image using inverse process (Dequantization + IDCT)
% 7. Display:
%       - Original Image
%       - Reconstructed Image with compressed size
%       - Bar chart showing Original vs Compressed size
% -------------------------------------------------------------------------

clc;
clear all;
close all;

% -------------------------------------------------------------------------
% STEP 1: IMAGE PREPROCESSING
% -------------------------------------------------------------------------
img = imread('cap.jpg');       % <-- Change to your image filename
if size(img,3) == 3            % If RGB, convert to grayscale
    img = rgb2gray(img);
end
img = imresize(img,[256 256]); % Resize to fixed size for simplicity
img = double(img);             % Convert to double for processing

% -------------------------------------------------------------------------
% JPEG STANDARD QUANTIZATION MATRIX (Luminance)
% -------------------------------------------------------------------------
Q = [16 11 10 16 24 40 51 61;
     12 12 14 19 26 58 60 55;
     14 13 16 24 40 57 69 56;
     14 17 22 29 51 87 80 62;
     18 22 37 56 68 109 103 77;
     24 35 55 64 81 104 113 92;
     49 64 78 87 103 121 120 101;
     72 92 95 98 112 100 103 99];

% -------------------------------------------------------------------------
% ZIGZAG SCAN ORDER FOR 8x8 BLOCK
% -------------------------------------------------------------------------
zigzagOrder = [ ...
     1  2  6  7 15 16 28 29;
     3  5  8 14 17 27 30 43;
     4  9 13 18 26 31 42 44;
    10 12 19 25 32 41 45 54;
    11 20 24 33 40 46 53 55;
    21 23 34 39 47 52 56 61;
    22 35 38 48 51 57 60 62;
    36 37 49 50 58 59 63 64];
zigzagOrder = zigzagOrder(:);   % Convert to column vector

% -------------------------------------------------------------------------
% STEP 2–4: DCT, QUANTIZATION, ZIGZAG & RLE ENCODING
% -------------------------------------------------------------------------
[rows,cols] = size(img);
dct_blocks = cell(rows/8,cols/8); % Store compressed blocks
rle_stream = {};                  % Store RLE data for compression size

for i=1:8:rows
    for j=1:8:cols
        % Extract 8x8 block
        block = img(i:i+7, j:j+7);

        % DCT transform (shift by -128 for JPEG standard)
        dct_block = dct2(block-128);

        % Quantization
        quant_block = round(dct_block ./ Q);

        % Zigzag scan
        zz = quant_block(zigzagOrder);

        % Run-Length Encoding (RLE)
        rle = [];
        count = 0;
        for k=1:length(zz)
            if zz(k)==0
                count = count + 1;
            else
                rle = [rle; count zz(k)];
                count = 0;
            end
        end
        rle_stream{end+1} = rle;

        % Store zigzag for reconstruction
        dct_blocks{(i-1)/8+1,(j-1)/8+1} = zz;
    end
end

% -------------------------------------------------------------------------
% STEP 5: IMAGE RECONSTRUCTION (Inverse DCT)
% -------------------------------------------------------------------------
reconImg = zeros(rows,cols);

for i=1:8:rows
    for j=1:8:cols
        idx_row = (i-1)/8+1;
        idx_col = (j-1)/8+1;

        zz = dct_blocks{idx_row,idx_col};
        block = zeros(8,8);
        block(zigzagOrder) = zz;

        % Dequantization
        dequant = block .* Q;

        % Inverse DCT (shift back by +128)
        reconBlock = idct2(dequant) + 128;

        reconImg(i:i+7, j:j+7) = reconBlock;
    end
end

reconImg = uint8(reconImg);

% -------------------------------------------------------------------------
% STEP 6: COMPRESSION SIZE CALCULATION
% -------------------------------------------------------------------------
origBits = numel(img)*8;   % Original size in bits
nonZeros = 0;
for k=1:length(rle_stream)
    nonZeros = nonZeros + size(rle_stream{k},1);
end
compBits = nonZeros*16;    % Approx 16 bits per symbol

origKB = origBits/8/1024;  % Convert to KB
compKB = compBits/8/1024;
ratio = origBits/compBits; % Compression ratio

% -------------------------------------------------------------------------
% STEP 7: DISPLAY RESULTS
% -------------------------------------------------------------------------
figure;

% --- Show original image ---
subplot(1,3,1); 
imshow(uint8(img)); 
title('Original Image');

% --- Show reconstructed image with compressed size on title ---
subplot(1,3,2); 
imshow(reconImg); 
title(sprintf('Reconstructed Image\nCompressed: %.2f KB',compKB));

% --- Plot comparison between Original and Compressed sizes ---
subplot(1,3,3);
b = bar([origKB compKB]);                     % Bar graph of sizes
set(gca,'XTickLabel',{'Original','Compressed'}); % X-axis labels
ylabel('Size (KB)');                          % Y-axis label
title(sprintf('Compression Ratio = %.2f : 1',ratio)); % Graph title

% --- Add value labels on top of bars ---
xtips = b.XEndPoints;
ytips = b.YEndPoints;
labels = string(round(b.YData,2));            % Rounded size values
text(xtips,ytips,labels,'HorizontalAlignment','center','VerticalAlignment','bottom');

% -------------------------------------------------------------------------
% END OF CODE
% -------------------------------------------------------------------------
