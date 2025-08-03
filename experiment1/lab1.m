function lab1(cap)

clc;
close all;

  I = imread(cap);
 
 
% Get the size of the image (rows, columns, and color channels)
[rows, cols, channels] = size(I);

% Check if the image is RGB (i.e., has 3 color channels)
if channels ~= 3
    error('Input image is not RGB');  % Display error if not RGB
end

% Convert image to double precision for accurate calculations
I = double(I);

% extarct the Red, Green, and Blue channels
R = I(:,:,1);   % Red channel
G = I(:,:,2);   % Green channel
B = I(:,:,3);   % Blue channel

% Convert the RGB image to grayscale using average method
gray = (R + G + B) / 3;

% Convert the grayscale image back to uint8 format for display
gray = uint8(gray);

% ---------------- ALTERNATE GRAYSCALE METHOD (commented out) ----------------
% This method uses weighted sum based on human perception 

% [rows,cols,~]=size(I);
% gray=zeros(rows,cols);
% 
% %for the gray scale image 
% for i=1:rows
%     for j=1:cols
%         R=double(I(i,j,1));
%         G=double(I(i,j,2));
%         B=double(I(i,j,3));
%         
%         
%         gray(i,j)=0.2989*R+0.5870*G+0.1140*B;
%     end
% end
% gray=uint8(gray);   % This works perfectly
% 
% imshow(gray);
% title('grayscale image');

% ---------------- Create Red-Only Grayscale Image ----------------
redImage=zeros(rows,cols,3 ,'uint8');
for i=1:rows
    for j=1:cols
        redImage(i,j,1)=gray(i,j);   %Assign red  to gray scale
        redImage(i,j,2)=0;
        redImage(i,j,3)=0;
    end
end
% ---------------- Create Green-Only Grayscale Image ----------------
greenImage=zeros(rows,cols,3 ,'uint8');

for i=1:rows
    for j=1:cols
        greenImage(i,j,1)=0;
        greenImage(i,j,2)=gray(i,j);  %Assign green to gray scale
        greenImage(i,j,3)=0;
    end
end
% ---------------- Create Blue-Only Grayscale Image ----------------
blueImage=zeros(rows,cols,3 ,'uint8');

for i=1:rows
    for j=1:cols
        blueImage(i,j,1)=0;
        blueImage(i,j,2)=0;
        blueImage(i,j,3)=gray(i,j);  %Assign blue to gray scale
    end
end

redImage=uint8(redImage);
greenImage=uint8(greenImage);
blueImage=uint8(blueImage);

% Display all grayscale channel images using subplots 
figure;
%subplot for the red image 
subplot(2,2,1),image(uint8(redImage)),title('red  image'),axis off;
%subplot for the green image 
subplot(2,2,2),image(uint8(greenImage)),title('green  image'),axis off;
%subplot for the blue image 
subplot(2,2,3),image(uint8(blueImage)),title('blue image'),axis off;

% ---------------- Convert Grayscale to Black and White ----------------

threshhold=127;   % Threshold for binarization (black & white)

%running the loop over across all values of gray scale image 
bwimage=zeros(rows,cols,'uint8');% Initialize the binary image
for i=1:rows
    for j=1:cols
        if gray(i,j)>threshhold
            bwimage(i,j)=255; %white pixel
        else
            bwimage(i,j)=0;   %black pixel
        end  
        
    end
    
end
figure;
%Display black and white image
imshow(bwimage);
title('blact and white image');



        

