%**************************************************************************
%
% CA8 - ROBOT VISION 
% MINIPROJECT
% main.m
%
%**************************************************************************
%
% Alvaro Perez Ortega
% Aalborg University
% March 2016
%
%**************************************************************************

clearvars -except r cam
close all;

%**************************************************************************
%
%	CONECTION STEPS:
% - Run Adept Desktop
% - Create a Adept Desktop script out of the "CobraConnection" file in 
%	Adept Desktop to make the connection between the "SmartConnector" 
%	(Cobra robot) and the computer.
%	NOTE: DO NOT USE THE ONE GIVEN IN THE MAIL. THE MISTAKES HAS BEEN
%	CORRECTED IN THIS ONE.
% - Run the task0 with the created adept file.
% - Run this code in MATLAB
%
%**************************************************************************

%% Conection between robot and computer and setup camera  
% cobra_init;

%% Global variables

% Bottom to top
DEF_COLOR = 'y';
STR_HOMER = 'bwy';      
STR_MARGE = 'byg';      
STR_BART = 'yob';        
STR_LISA = 'yoy';        
STR_MAGGIE = 'by';

%**************************************************************************
% Z VALUES:
%   Not on the fly:
%   1st piece -> 188
%   2st piece -> 205.65
%   3st piece -> 224.5
%
%   On the fly
%   1st piece -> 188
%   2nd piece -> 222.153 up to 260
%   3st piece -> 241 up to 260
%**************************************************************************
% Z POSITIONS
Z_HOVER = 260;
Z_PICK = 205;
Z_NOT_PICK = 215;
Z_BUILD_HOVER = 230;
% Not on the fly
Z1_BUILD_NF = 188;
Z2_BUILD_NF = 205.65;
Z3_BUILD_NF = 224.5;
% On the fly
Z1_BUILD_OF = Z1_BUILD_NF;
Z2_BUILD_OF = 222.153;
Z3_BUILD_OF = 241;
% CENTER (NOT ORIGIN)
X_CENTER = 425;
Y_CENTER = 0;
Z_CENTER = 300;
ANG_CENTER = 45;

% ROBOT VELOCITIES
VEL_MOVE = 500;
VEL_PICK = 20;

% OFFSET
offsety = 9.8;
offsetx = -2.5;
offset_rot = 11.64;


% OTHER
plotr = 1;
onthefly = 0;

%% USER INTERFACE
% Program starting
fprintf('##############################################################################\n');
fprintf('#                           COBRA SIMPSONS BUILDER                           #\n');
fprintf('#                                                                            #\n');
fprintf('#        GROUP 832 - CONTROL AND AUTOMATION MSC. - AALBORG UNIVERSITY        #\n');
fprintf('##############################################################################\n\n');
fprintf('Choose one character from The Simpsons series.\n');
fprintf('Input either the name of the character or its respective letter of the list:\n');
prompt = 'A) Homer\nB) Marge\nC) Bart\nD) Lisa\nE) Maggie\n\nYour answer: ';

% usrIn = input(prompt,'s');
usrIn = '';
if (strcmp(usrIn,'homer') || strcmp(usrIn,'A') || strcmp(usrIn,'a'))
    fprintf('\nYou chose: A) Homer\n');
    build = STR_HOMER;
elseif (strcmp(usrIn,'marge') || strcmp(usrIn,'B') || strcmp(usrIn,'b'))
    fprintf('\nYou chose: B) Marge\n');
    build = STR_MARGE;
elseif (strcmp(usrIn,'bart') || strcmp(usrIn,'C') || strcmp(usrIn,'c'))
    fprintf('\nYou chose: C) Bart\n');
    build = STR_BART;
elseif (strcmp(usrIn,'lisa') || strcmp(usrIn,'D') || strcmp(usrIn,'d'))
    fprintf('\nYou chose: D) Lisa\n');
    build = STR_LISA;
elseif (strcmp(usrIn,'maggie') || strcmp(usrIn,'E') || strcmp(usrIn,'e'))
    fprintf('\nYou chose: E) Maggie\n');
    build = STR_MAGGIE;
else
    fprintf('\nWARNING: Empty or unrecognized request.\nAssuming default color...\n');
    build = DEF_COLOR;
end


%% Getting picture of Workspace and loading images and parameters
fprintf('##############################################################################\n');
fprintf('Loading intrinsic and extrinsic parameters...\n');
load Calib_Results.mat;
load extrinsic.mat
load fig_calib/cameraParams.mat;
img_chess = rgb2gray(imread('fig_calib/calib1.tif'));
img_bkg = imread('fig_calib/background.tif');
img_bkg = undistortImage(img_bkg,cameraParams);

if (onthefly == 0 || onthefly == 1)
    %Move robot to center (NOT ORIGEN)
    fprintf('Moving robot to initial position...\n');
    r.closeGrapper
    pause(0.5);
    r.moveLinear(X_CENTER,Y_CENTER,Z_CENTER,0,180,ANG_CENTER,VEL_MOVE)
    pause(0.5);
end

% NORMAL PROGRAM
fprintf('Taking picture of the current workspace...\n');
img_curr = snapshot(cam(1));
img_curr = undistortImage(img_curr,cameraParams);
imwrite(img_curr,'fig_calib/current.TIF');

% USING FIGURE ALREADY TAKEN
% fprintf('Reading picture of the current workspace...\n');
% img_curr = imread('fig_calib/current.TIF');

% Extrinsic and Intrinsic Matrices are used to change the coordinate
% systems
fprintf('Creating projective matrix...\n');
extrinsic = [Rc_ext Tc_ext];
intrinsic = KK;
Proj = intrinsic*extrinsic;
% We can ignore the third column because the Z coordinate is always zero.
% So we will have a 3x3 matrix and we will be able to inverse it.
Proj(:,3)=[];

% WORLD - ROBOT Transformation Matrix
% FUCK THIS SHIT
% theta_r = 0;
% Trans_mat = [cos(theta_r)    -sin(theta_r)    0    266.672
%              sin(theta_r)     cos(theta_r)    0    226.186
%                  0                0           1       0      ];
% Experimental Transformation matrix
Trans_mat = experimentalTrans();

% Calculations using the origin to get the w (last value of the matrix
% Values)
% Origin
img_og = Proj*[0;0;1];
w_og = img_og(3);
img_og = img_og/w_og;

% Corners
img_cur = Proj*[29*8;0;1];
w_cur = img_cur(3);
img_cur = img_cur/img_cur(3);
img_cul = Proj*[29*8;29*5;1];
w_cul = img_cul(3);
img_cul = img_cul/img_cul(3);
img_cdl = Proj*[0;29*5;1];
w_cdl = img_cdl(3);
img_cdl = img_cdl/img_cdl(3);

% W term
w = [w_og; w_cur; w_cul; w_cdl];
% fprintf('Deviation (w): %f\n',w);

% Loop to make the figure
for i = 1:length(build)
    
    % Taking picture
    if (onthefly == 0 && i>1)
        fprintf('Taking picture of the current workspace...\n');
        img_curr = snapshot(cam(1));
        imwrite(img_curr,'fig_calib/current.TIF');
    end
    
    %% Detecting color
    colors = build(i);
    fprintf('Detecting blocks by color in the workspace...\n');
    [img_coord, rot_angle,Ib,Ie] = blockExtraction(colors,...
        img_curr, img_bkg, Proj, w_og, Trans_mat, plotr);
    img_coordx = img_coord(1);
    img_coordy = img_coord(2);
    % img_coordx = img_og(1);
    % img_coordy = img_og(2);
    img_coord = [img_coordx; img_coordy; 1];
    
    % The invertion of the P matrix will be made in order to find the
    % coordinates in the world system. However, this coordinates are not
    % correct because we need to normalize it using the third value of the same
    % matrix. We need to divide by 100 to get the values with correct units
    % (cm).
    w_coord = Proj\(w_og*img_coord);
    w_coordx = w_coord(1)/(w_coord(3));
    w_coordy = w_coord(2)/(w_coord(3));
    w_coord = [w_coordx; w_coordy; 1];
    
    r_coord = [Trans_mat]*[w_coord];
    
    

    %% Print Coordinates
    fprintf('Image Coordinates: X: %.4f Y: %.4f\n',img_coord(1),img_coord(2));
    fprintf('World Coordinates: X: %.4f Y: %.4f\n', w_coord(1),w_coord(2));
    fprintf('Robot Coordinates: X: %.4f Y: %.4f  R: %.4f degrees\n', r_coord(1),r_coord(2),rot_angle);
    
    %% MOVEMENT
 
    fprintf('Starting motion of the robot...\n');
    
    % NOT ON THE FLY
    if onthefly == 0
        r.closeGrapper
        pause(0.1);
        r.moveLinear(r_coord(1)+offsetx,r_coord(2)+offsety,Z_HOVER,0,180,rot_angle+offset_rot,VEL_MOVE)
        pause(0.1)
        r.moveLinear(r_coord(1)+offsetx,r_coord(2)+offsety,Z_NOT_PICK,0,180,rot_angle+offset_rot,VEL_MOVE)
        fprintf('SECURITY PROTOCOL: Press enter to pick the block up.');
        pause();
        r.moveLinear(r_coord(1)+offsetx,r_coord(2)+offsety,Z_PICK,0,180,rot_angle+offset_rot,VEL_PICK)
        pause(0.1);
        r.openGrapper
        pause(0.1);
        r.moveLinear(r_coord(1)+offsetx,r_coord(2)+offsety,Z_HOVER,0,180,rot_angle+offset_rot,VEL_MOVE)
        pause(0.1);
        
        %Move robot to center (NOT ORIGEN)
        r.moveLinear(X_CENTER,Y_CENTER,Z_CENTER,0,180,ANG_CENTER,VEL_MOVE)
        pause(0.1);
        
        %Construct:
        r.moveLinear(X_CENTER,Y_CENTER,Z_BUILD_HOVER,0,180,ANG_CENTER,VEL_MOVE)
        pause(0.1);
        if i == 1
            r.moveLinear(X_CENTER,Y_CENTER,Z1_BUILD_NF,0,180,ANG_CENTER,VEL_PICK)
            pause(0.1);
        elseif i == 2
            r.moveLinear(X_CENTER,Y_CENTER,Z2_BUILD_NF,0,180,ANG_CENTER,VEL_PICK)
            pause(0.1);
        elseif i == 3
            r.moveLinear(X_CENTER,Y_CENTER,Z3_BUILD_NF,0,180,ANG_CENTER,VEL_PICK)
            pause(0.1);
        end
        
        r.closeGrapper
        pause(0.1);
        
        %Move robot to center (NOT ORIGEN)
        r.moveLinear(X_CENTER,Y_CENTER,Z_CENTER,0,180,ANG_CENTER,VEL_MOVE)
        pause(0.1);
        
    % ON THE FLY
    elseif onthefly == 1      
        r.moveLinear(r_coord(1)+offsetx,r_coord(2)+offsety,Z_HOVER,0,180,rot_angle+offset_rot,VEL_MOVE)
        pause(0.1);
        if i == 1
            r.moveLinear(r_coord(1)+offsetx,r_coord(2)+offsety,Z_PICK,0,180,rot_angle+offset_rot,VEL_PICK)
            pause(0.1);
            r.openGrapper
            pause(0.1);
        elseif i == 2
            r.moveLinear(r_coord(1)+offsetx,r_coord(2)+offsety,Z2_BUILD_OF,0,180,rot_angle+offset_rot,VEL_PICK)
            pause(0.1);
        elseif i == 3
            r.moveLinear(r_coord(1)+offsetx,r_coord(2)+offsety,Z3_BUILD_OF,0,180,rot_angle+offset_rot,VEL_PICK)
            pause(0.1);
        end
        
        r.moveLinear(r_coord(1)+offsetx,r_coord(2)+offsety,Z_HOVER,0,180,rot_angle+offset_rot,VEL_MOVE)
        pause(0.1);
        
        if i == length(build)
            
            %Move robot to center (NOT ORIGEN)
            r.moveLinear(X_CENTER,Y_CENTER,Z_CENTER,0,180,ANG_CENTER,VEL_MOVE)
            pause(0.1);
        
            %Drops the figure
            r.moveLinear(X_CENTER,Y_CENTER,Z3_BUILD_NF,0,180,ANG_CENTER,VEL_PICK)
            pause(0.1);
            r.closeGrapper
            pause(0.1);
        
            %Move robot to center (NOT ORIGEN)
            r.moveLinear(X_CENTER,Y_CENTER,Z_CENTER,0,180,ANG_CENTER,VEL_MOVE)
            pause(0.1);
        end
    else 
        fprintf('WARNING: Movement of the robot cancelled!\n');
    end
         
    fprintf('Block done!\n\n');
    
    if i == length(build)
        fprintf('Figure finished!\n');
        fprintf('##############################################################################\n');
    end
end
