clc;
clear all;
close all;

% -------------------------------------------------------------------------
% SHANNON–FANO IMAGE COMPRESSION
% This script reads an image (RGB or grayscale), converts to grayscale
% if needed.
%compresses it using Shannon–Fano coding, and reconstructs
% the image from the compressed bitstream. Only essential statistics
% (original size, reconstructed size, compression ratio) are displayed.
%
% Author: [A.Vijay Teja]
% Date: [16th Aug]
% -------------------------------------------------------------------------

% -------------------------
% Step 1: Read and resize image
% -------------------------
img = imread('cap.jpg');          % Load input image
img = imresize(img,[256 256]);    % Resize to 256x256 pixels

% -------------------------
% Step 2: Convert to grayscale if RGB
% -------------------------
sz = size(img);                   % Get image dimensions
if length(sz) == 3 && sz(3) == 3
    % RGB to grayscale using average method
    gray = uint8((double(img(:,:,1)) + double(img(:,:,2)) + double(img(:,:,3)))/3);
else
    gray = img;                   % Already grayscale
end

% Display the grayscale image
figure;
imshow(gray);
title('Grayscale Image');

% -------------------------
% Step 3: Flatten image and compute symbol probabilities
% -------------------------
data = gray(:);                   % Flatten image to a column vector
symbols = unique(data);           % Get unique pixel values
counts = zeros(numel(symbols),1); % Initialize counts

for i = 1:numel(symbols)
    counts(i) = sum(data == symbols(i)); % Count occurrences of each symbol
end

prob = counts / sum(counts);      % Compute probabilities of symbols

% -------------------------
% Step 4: Sort symbols by descending probability
% -------------------------
[prob, ord] = sort(prob,'descend'); % Sort probabilities
symbols = symbols(ord);             % Reorder symbols accordingly

% -------------------------
% Step 5: Shannon–Fano coding using a stack
% -------------------------
codes = cell(numel(symbols),1);      % Initialize cell array for codes
stack = {};                           % Initialize empty stack
stack{end+1} = {1:numel(symbols), prob, ''}; % Push initial group

while ~isempty(stack)
    elem = stack{end}; stack(end) = [];   % Pop last element
    idx = elem{1};                        % Symbol indices
    p = elem{2};                          % Probabilities
    prefix = elem{3};                     % Current prefix code
    
    if numel(idx) == 1
        codes{idx} = prefix;              % Assign code if one symbol left
    else
        total = sum(p); 
        cs = cumsum(p); 
        [~, split] = min(abs(cs - total/2)); % Find split index
        split = max(1, min(numel(p)-1, split));
        
        % Push right group first, left group second
        stack{end+1} = {idx(split+1:end), p(split+1:end), [prefix '1']};
        stack{end+1} = {idx(1:split),   p(1:split),     [prefix '0']};
    end
end

% -------------------------
% Step 6: Encode image into bitstream
% -------------------------
bitstream = '';                        % Initialize empty bitstream
for i = 1:numel(data)
    idx = find(symbols == data(i),1);  % Find symbol index
    bitstream = [bitstream codes{idx}]; %#ok<AGROW> Append code
end

% -------------------------
% Step 7: Compute compression statistics
% -------------------------
orig_kb = numel(data)/1024;                 % Original size in KB
comp_kb = length(bitstream)/8/1024;        % Compressed size in KB
ratio   = orig_kb / max(comp_kb, eps);     % Compression ratio

% Display results
fprintf('Original size      : %.2f KB\n', orig_kb);
fprintf('Reconstructed size : %.4f KB\n', comp_kb);
fprintf('Compression ratio  : %.2f\n', ratio);

% -------------------------
% Step 8: Decode bitstream back to image
% -------------------------
decoded = zeros(numel(data),1,'uint8'); % Initialize decoded array
buf = ''; pos = 1;                       % Buffer for reading bits

for i = 1:length(bitstream)
    buf = [buf bitstream(i)];            % Append bit to buffer
    for j = 1:numel(symbols)
        if strcmp(buf, codes{j})        % Check if buffer matches a code
            decoded(pos) = symbols(j);   % Assign symbol
            pos = pos + 1;               % Move to next position
            buf = '';                     % Clear buffer
            break;
        end
    end
end
recon = reshape(decoded, size(gray));     % Reshape to original image dimensions

% -------------------------
% Step 9: Display original and reconstructed images
% -------------------------
figure;
subplot(1,2,1), imshow(gray), title('Original 256×256');
subplot(1,2,2), imshow(recon), title('Reconstructed Image');

% -------------------------------------------------------------------------
% END OF SCRIPT
% -------------------------------------------------------------------------
