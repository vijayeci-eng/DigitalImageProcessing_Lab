clc;
clear all;
close all;

% -------------------------------------------------------------------------
% HUFFMAN CODING FOR GIVEN PROBABILITIES
% This script takes a probability vector as input, builds a Huffman tree,
% generates Huffman codes for each symbol, and calculates the average 
% code length.
%
% Author: [Vijay Teja]
% Date  : [16th Aug]
% -------------------------------------------------------------------------

% -------------------------
% Step 1: Input probability vector
% -------------------------
prob = input('Enter the probability vector [p1 p2 ... pn]: ');  
prob = prob / sum(prob);                % Normalize probabilities to sum = 1
n = length(prob);                       % Number of symbols
symbols = 1:n;                          % Assign symbols as 1,2,...,n

% -------------------------
% Step 2: Initialize nodes for Huffman tree
% -------------------------
% Each node is a struct containing: symbol(s), probability, left & right children
nodes = struct('symbol',{},'prob',{},'left',{},'right',{});
for i=1:n
    nodes(i).symbol = symbols(i);       % Assign symbol
    nodes(i).prob   = prob(i);          % Assign probability
    nodes(i).left   = [];               % Left child (empty initially)
    nodes(i).right  = [];               % Right child (empty initially)
end

% -------------------------
% Step 3: Build Huffman tree manually
% -------------------------
while length(nodes) > 1
    % Find the two nodes with the smallest probabilities
    min1 = 1; min2 = 2;
    if nodes(min2).prob < nodes(min1).prob
        temp = min1; min1 = min2; min2 = temp;
    end
    for i=3:length(nodes)
        if nodes(i).prob < nodes(min1).prob
            min2 = min1;
            min1 = i;
        elseif nodes(i).prob < nodes(min2).prob
            min2 = i;
        end
    end
    
    % Merge the two smallest nodes into a new parent node
    newNode.symbol = [nodes(min1).symbol nodes(min2).symbol]; % Combine symbols
    newNode.prob   = nodes(min1).prob + nodes(min2).prob;     % Sum probabilities
    newNode.left   = nodes(min1);                             % Left child
    newNode.right  = nodes(min2);                             % Right child
    
    % Remove merged nodes and add new parent node to the list
    temp_nodes = nodes;
    temp_nodes([min1 min2]) = [];
    nodes = [newNode temp_nodes];
end

% The final remaining node is the root of Huffman tree
huffTree = nodes(1);

% -------------------------
% Step 4: Generate Huffman codes recursively
% -------------------------
codes = cell(1,n);                     % Initialize cell array for codes
codes = assignCodes(huffTree,'',symbols,codes); % Assign codes starting with empty prefix

% -------------------------
% Step 5: Display Huffman codes for each symbol
% -------------------------
disp('Huffman Codes:');
for i=1:n
    fprintf('Symbol %d => %s\n', symbols(i), codes{i});
end

% -------------------------
% Step 6: Compute average code length
% -------------------------
avg_len = sum(prob .* cellfun(@length,codes)); % Weighted average of code lengths
fprintf('\nAverage Code Length = %.4f bits/symbol\n', avg_len);

% -------------------------------------------------------------------------
% Recursive function to assign Huffman codes
% Left branch adds '0', right branch adds '1'
% This function must be placed at the end of the script
% -------------------------------------------------------------------------
function codes = assignCodes(node, prefix, symbols, codes)
    if isempty(node.left) && isempty(node.right)
        % Leaf node: assign code to the corresponding symbol
        idx = find(symbols==node.symbol,1);
        codes{idx} = prefix;
    else
        % Recursive call for left and right children
        codes = assignCodes(node.left, [prefix '0'], symbols, codes);
        codes = assignCodes(node.right,[prefix '1'], symbols, codes);
    end
end
