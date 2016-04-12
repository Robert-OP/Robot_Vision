function [pxy, rot_angle,Ib,Ie] = blockExtraction(colors, img_curr, img_bkg, ...
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
    G  = [60    100   110   180   80    140 ];   % green
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
    O  = [220   240   110   170   5     125 ];   % orange
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
TH = 8;     % threshold to substract background
img_curr = imcrop(img_curr,[900 400 800 600]);
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

I_thresh = Ib;

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

%% POSITION DETECTION: Find block center and area in the image (pixels)

Ie = edge(Ib,'Canny',[],3);             % image with edges Canny method
Im = imfill(Ie,'holes');    % fill the image with edges
BW = bwlabel(Im,8);         % region labeling
infoB = regionprops(BW,'centroid','area');  % structure with block info
block = [cat(1, infoB.Area) cat(1, infoB.Centroid)]; 
[A, k] = max(block(:,1));              % find max area in the image   
pxy = [block(k,2) block(k,3)]; % pixel values on the crop 
Areas = [infoB.Area];
I_block = bwareaopen(Im,max(Areas));
% Reconstruct from Ie
Ie = edge(I_block,'Canny',[],3);             % image with edges

%% NEW STUFF
[erow, ecolumn] = find(Ie==1);
norms = zeros(length(erow),1);

for i=1:length(erow)
    norms(i)=norm([pxy(2) pxy(1)]-[erow(i) ecolumn(i)]);
end

u=1;
coordtest=zeros(4,2);
[~,index] = max(norms);
coordtest(u,:) = [erow(index) ecolumn(index)];
flag=0;
norms1=sort(norms,'descend');

for i=2:length(norms) 
    index = find(norms==norms1(i));
    aux = [erow(index), ecolumn(index)];
    for j=1:u
        if norm(aux-coordtest(j,:))>15 %%%%% ATTENTION
            flag = flag+1;
            if flag == u
                u=u+1;
                coordtest(u,:) = aux;
            end
        end
    end
    flag=0;
    
    if u==4
        break
    end
end

columns=sort(coordtest(:,2));
index1=find(coordtest(:,2)==columns(1));
index2=find(coordtest(:,2)==columns(2));

if length(index2)>1 
    if coordtest(index2(1),1) > coordtest(index2(2),1) 
        index2(2) = [];
    else
        index2(1) = []; 
    end
end

slopecenter1 = (pxy(1)-coordtest(index1,2))/(pxy(2)-coordtest(index1,1));
b1 = pxy(1)-slopecenter1*pxy(2);
slopecenter2 = (pxy(1)-coordtest(index2,2))/(pxy(2)-coordtest(index2,1));
b2 = pxy(1)-slopecenter2*pxy(2);


k=1;
clear points;
for i=1:length(erow) 
    y1 = slopecenter1*erow(i) + b1;
    y2 = slopecenter2*erow(i) + b2;
    
    if y1>ecolumn(i) & y2>ecolumn(i)
       points(k,:) = [erow(i),ecolumn(i)];
       k=k+1;
    end
    
end

for i=1:length(coordtest) 
    vecnew(:,i) = Proj\(w_og*[[coordtest(i,1) coordtest(i,2)]'; 1]); 
    r_new1(:,i) = Trans_mat*vecnew(:,i);
end

for i=1:length(points)
    vecnew(:,i) = Proj\(w_og*[[points(i,1) points(i,2)]'; 1]); 
    r_points(:,i) = Trans_mat*vecnew(:,i);
end

vec5 = Proj\(w_og*[[pxy(2) pxy(1)]'; 1]); 
r_5 = Trans_mat*vec5; 

%% PLOTS
if plotr == 1
    fig1 = figure(1);
    clf(fig1);
    
    subplot(3,2,1);
    imshow(img_curr);
    title('Original picture cropped');
    
    subplot(3,2,2);
    imshow(I);
    title('Original picture w/o background');
    
    subplot(3,2,3);
    imshow(I_thresh);
    title('Thresholded image');
    
    subplot(3,2,4);
    imshow(Ib);
    title('Extracted blocks');
    
    subplot(3,2,5);
    imshow(Ie);
    title('Only one block');
%     
%     subplot(3,2,6);
%     hold on;
%     scatter(pxy(2),pxy(1), 'x','k');
%     scatter(coordtest(:,1),coordtest(:,2), 'x','k');
%     scatter(points(:,1),points(:,2), 'x','b');
%     scatter(pxy(2),pxy(1), 'x','k');
%     scatter(coordtest(:,1),coordtest(:,2), 'x','k');
%     slope=polyfit(points(:,1),points(:,2),1);
%     title('Slope')
%     
    subplot(3,2,6);
    hold on;
    scatter(r_points(1,:),r_points(2,:), 'x','g');
    scatter(r_new1(1,:),r_new1(2,:), 'x','k');
    scatter(r_5(1),r_5(2), 'x','r');
    title('Slope')

    fig2 = figure(2);
    imshow(img_curr);
    title('Original picture cropped');
    imwrite(img_curr,'fig/crop_img.png');
    
    fig3 = figure(3);
    imshow(I);
    title('Original picture w/o background');
    imwrite(I,'fig/nobkg_img.png');
    
    fig4 = figure(4);
    imshow(I_thresh);
    title('Thresholded image');
    imwrite(I_thresh,'fig/thresh_img.png');
    
    fig5 = figure(5);
    imshow(Ib);
    title('Extracted blocks');
    imwrite(Ib,'fig/fill_img.png');
    
    fig6 = figure(6);
    imshow(Ie);
    title('Only one block');
    imwrite(Ie,'fig/chosen_img.png');
end
%% 

finalissimo = polyfit(r_points(1,:),r_points(2,:),1);
angle = atand(finalissimo(1));

if angle<0
    finalslope=90-abs(angle);
else
    finalslope = angle;
end
 

%%
pxy = [pxy(1)+900 pxy(2)+400]; % pixel values 
rot_angle = finalslope -45;
end

