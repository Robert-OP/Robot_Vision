function [pxy, rot_angle] = blockExtraction(colors, img_curr, img_bkg, ...
    Proj, w_og, Trans_mat, plotr)
%**************************************************************************
%
% CA8 - ROBOT VISION 
% MINIPROJECT
% blockExtraction.m
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

%% COLOR THRESHOLD
%        r_min  r_max g_min g_max b_min b_max    % block color
if strcmp(colors,'g')
    G  = [130   200   140   220   20    140 ];   % green
    color = G;
    colors = 'green';
elseif strcmp(colors,'b')
    B  = [0     70    40    130   140   255 ];   % blue
    color = B;
    colors = 'blue';
elseif strcmp(colors,'y')
    Y  = [220   255   205   255   0     200 ];   % yellow
    color = Y;
    colors = 'yellow';
elseif strcmp(colors,'o')
    O  = [220   240   60    180   0     150 ];   % orange
    color = O;
    colors = 'orange';
elseif strcmp(colors,'w')
    W  = [205   255   205   255   205   255 ];   % white
    color = W;
    colors = 'white';
else
    fprintf('WARNING: ERROR NOT RECOGNIZED\n');
    color = 0;
end

% Taking into gray and filtered versions of BACKGROUND AND WORKSPACE
imgG = rgb2gray(img_curr); imgG = imcrop(imgG,[900 400 800 600]);
bkgG = rgb2gray(img_bkg);  bkgG = imcrop(bkgG,[900 400 800 600]);
imgF = medfilt2(imgG,[5 5]);
bkgF = medfilt2(bkgG,[5 5]);

% Substracting Background
TH = 20;     % threshold to substract background
I = img_curr;     
for i=1:size(imgG,1)
    for j=1:size(imgG,2)
        if (abs(double(imgF(i,j))-double(bkgF(i,j))) < TH)
            I(i,j,:) = 0;      % substract background
        end
    end
end

%% Color Detection - Thresholding

Ib = zeros(size(I,1),size(I,2));   % initialize a black image

fprintf('Calculating image coordinates of the %s block ...\n',colors);

% Ib is the image only with the desired block
for i=1:size(I,1)
    for j=1:size(I,2)
        if I(i,j,1) >= color(1) && I(i,j,1) <= color(2)
            if I(i,j,2) >= color(3) && I(i,j,2) <= color(4)
                if I(i,j,3) >= color(5) && I(i,j,3) <= color(6)
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

if plotr == 1    
    figure
    subplot(1,2,1);imshow(I);title('RGB image with background substracted');
    subplot(1,2,2);imshow(Ib);title('Image with desired block');
end

%% Edge detection using Canny method
Ie = edge(Ib,'Canny',[],4);             % image with edges

if plotr == 1
    figure
    subplot(1,2,1);imshow(Ib);title('Detected color block');
    subplot(1,2,2);imshow(Ie);title('Blocks with edges');
end

%% Find block center and area in the image (pixels)

Im = imfill(Ie,'holes');    % fill the image with edges
BW = bwlabel(Im,8);         % region labeling
infoB = regionprops(BW,'centroid','area');  % structure with block info
block = [cat(1, infoB.Area) cat(1, infoB.Centroid)]; 
[A, k] = max(block(:,1));              % find max area in the image   
pxy = [block(k,2)+900 block(k,3)+400]; % pixel values 
Areas = [infoB.Area];
I_block = bwareaopen(Im,max(Areas));
Icrop1 = imcrop(Im,[900 400 800 600]);
Icrop2 = imcrop(I_block,[900 400 800 600]);
imshowpair(Icrop1,Icrop2)

%% NEW STUFF
[coordix, coordiy]=find(Im==1);

[~,indexy]=min(coordiy);
pointleft = [coordix(indexy) coordiy(indexy)];

[~,indexx] = min(coordix);
pointdown = [coordix(indexx) coordiy(indexx)];

% figure
% hold on
% scatter(pointleft(1),pointleft(2), 'x','r');
% hold on
% scatter(pointdown(1),pointdown(2), 'x','r');

% if pointleft(2)-pointdown(2)~=0
ang = atand(abs(pointleft(1)-pointdown(1))/abs(pointleft(2)-pointdown(2)));
% else
% ang = 0;
% end

vec1 = Proj\(w_og*[pointleft'; 1]); 
r_1 = Trans_mat*vec1; 

vec2 = Proj\(w_og*[pointdown'; 1]); 
r_2 = Trans_mat*vec2; 

% figure(2)
% scatter(r_2(1),r_2(2), 'x','r');
% hold on
% scatter(r_1(1),r_1(2), 'x','r');
coisa = polyfit([r_1(1) r_2(1)],[r_1(2) r_2(2)],1);
angtheta = atand(coisa(1));
 

%%
rot_angle = 45 + ang;
end

