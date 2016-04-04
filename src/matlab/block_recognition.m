%**************************************************************************
%
% CA8 - ROBOT VISION 
% MINIPROJECT
% block_recognition.m
%
%**************************************************************************
% 
% Group 832
% Aalborg University
% March 2016
%
%**************************************************************************
% DESCRIPTION: 
%
% 
%**************************************************************************
clear all; close all; clc;

%% Camera connection (Should be done once in the main.m)
% webcamlist           % shows available cameras on pc
%  cam = webcam(1)      % store camera in a variable and shows parameters
% cam.Resolution = '1920x1080';
% preview(cam)         % camera preview (stream video)
% I = snapshot(cam);   % take a picture
% image(I)             % show image
% imtool(I)            % read RGB colors from an image to do thresholding

%% Background substration with output image in RGB
img = imread('fig/blocks1.png');
bkg = imread('background.png');
imgG = rgb2gray(img);
bkgG = rgb2gray(bkg);
imgF = medfilt2(imgG,[5 5]);
bkgF = medfilt2(bkgG,[5 5]);
TH = 30;     % threshold to substract background
I = img;     
for i=1:size(imgG,1)
    for j=1:size(imgG,2)
        if (abs(double(imgF(i,j))-double(bkgF(i,j))) < TH)
            I(i,j,:) = 0;      % substract background
        end
    end
end

%% Initialise block colors (MUST BE TUNNED!)
%     r_min r_max g_min g_max b_min b_max    % block color
R  = [170   255   0     30    0     30  ];   % red 
G  = [0     75    80    255   90    170 ];   % green
B  = [0     70    45    100   150   210 ];   % blue
Y  = [210   255   190   220   80    150 ];   % yellow
O  = [200   255   90    150   0     30  ];   % orange
W  = [180   255   180   255   180   255 ];   % white
Bl = [0     50    0     50    0     50  ];   % black

%% Color Detection - thresholding
Ib = zeros(size(I,1),size(I,2));   % initialize a black image
C = O;          % this will be function input !!!
% Ib is the image only with the desired block
for i=1:size(I,1)
    for j=1:size(I,2)
        if I(i,j,1) >= C(1) && I(i,j,1) <= C(2)
            if I(i,j,2) >= C(3) && I(i,j,2) <= C(4)
                if I(i,j,3) >= C(5) && I(i,j,3) <= C(6)
                    Ib(i,j,:) = 255;
                end
            end    
        end
    end
end

% Filter and Blur image 
Ib = medfilt2(Ib,[2 2]);     % remove noise
Ib = imgaussfilt(Ib, 2);     % blur - apply gauss filter
% complete blurred image
for i=1:size(Ib,1)
    for j=1:size(Ib,2)
        if Ib(i,j) > 1
            Ib(i,j) = 255;
        else Ib(i,j) = 0;
        end
    end
end
figure
subplot(1,2,1);imshow(I);title('RGB image with background substracted');
subplot(1,2,2);imshow(Ib);title('Image with desired block');

%% Edge detection using Canny method
Ie = edge(Ib,'Canny',[],7); % image with edges
figure
subplot(1,2,1);imshow(Ib);title('Detected color block');
subplot(1,2,2);imshow(Ie);title('Blocks with edges');

%% Find block center and area in the image (pixels)
Im = imfill(Ie,'holes');    % fill the image with edges
BW = bwlabel(Im,8);         % region labeling
infoB = regionprops(BW,'centroid','area');  % structure with block info
block = [cat(1, infoB.Area) cat(1, infoB.Centroid)]; 
[A, k] = max(block(:,1));   % find max area in the image   
pxy = block(k,2:3)          % relate the area to the center pixel values 

row = 1;
Islope = double(Im);
for i=2:size(BW,1)-1
    for j=2:size(BW,2)-1
        if BW(i,j) == k
            if BW(i+1,j) ~= k && BW(i,j+1) ~= k && BW(i-1,j) == k
                pslope(row,:) = [i,j];
                row = row+1;
            else
                Islope(i,j)=0;
            end
        else
            Islope(i,j)=0;
        end
    end
end

figure
imshow(Islope)

p = polyfit(pslope(:,1),pslope(:,2),1);  % slope a and b
theta = acot(-p(1))*180/pi               % [deg] desired orientation angle



