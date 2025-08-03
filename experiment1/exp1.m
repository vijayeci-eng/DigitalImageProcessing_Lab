function lab1(imgg)

clc;
close all;

%"D:\downloads\img.png"
 I=imread(imgg);    
[rows,cols,~]=size(I);
gray=zeros(rows,cols);

%for the gray scale image 
for i=1:rows
    for j=1:cols
        R=double(I(i,j,1));
        G=double(I(i,j,2));
        B=double(I(i,j,3));
        
        
        gray(i,j)=0.2989*R+0.5870*G+0.1140*B;
    end
end
gray=uint8(gray);   % This works perfectly

imshow(gray);
title('grayscale image');


redImage=zeros(rows,cols,3 ,'uint8');
%for red only graysacle 
for i=1:rows
    for j=1:cols
        redImage(i,j,1)=gray(i,j);
        redImage(i,j,2)=0;
        redImage(i,j,3)=0;
    end
end

greenImage=zeros(rows,cols,3 ,'uint8');


for i=1:rows
    for j=1:cols
        greenImage(i,j,1)=0;
        greenImage(i,j,2)=gray(i,j);
        greenImage(i,j,3)=0;
    end
end

blueImage=zeros(rows,cols,3 ,'uint8');

for i=1:rows
    for j=1:cols
        blueImage(i,j,1)=0;
        blueImage(i,j,2)=0;
        blueImage(i,j,3)=gray(i,j);
    end
end

redImage=uint8(redImage);
greenImage=uint8(greenImage);
blueImage=uint8(blueImage);
%to display the images in only one imaage 

figure;
subplot(2,2,1),image(uint8(redImage)),title('red  image'),axis off;
subplot(2,2,2),image(uint8(greenImage)),title('green  image'),axis off;
subplot(2,2,3),image(uint8(blueImage)),title('blue image'),axis off;


threshhold=127;
bwimage=zeros(rows,cols,'uint8');
for i=1:rows
    for j=1:cols
        if gray(i,j)>threshhold
            bwimage(i,j)=255;
        else
            bwimage(i,j)=0;
        end  
        
    end
    
end
figure;
imshow(bwimage);
title('blact and white image');



        

