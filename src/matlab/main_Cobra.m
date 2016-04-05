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

DEF_COLOR = 'b';
STR_HOMER = 'bwy';      % Bottom to top: Blue, white and yellow
STR_MARGE = 'gyb';      % Bottom to top: Green, yellow and blue
STR_BART = 'boy';       % Bottom to top: Blue, orange, yellow
plotr = 0;

%% USER INTERFACE
% Program starting
fprintf('##############################################################################\n');
fprintf('#                           COBRA SIMPSONS BUILDER                           #\n');
fprintf('#                                                                            #\n');
fprintf('#        GROUP 832 - CONTROL AND AUTOMATION MSC. - AALBORG UNIVERSITY        #\n');
fprintf('##############################################################################\n\n');
fprintf('Choose one character from The Simpsons series.\n');
fprintf('Input either the name of the character or its respective letter of the list:\n');
prompt = 'A) Homer\nB) Marge\nC) Bart\n\nYour answer: ';

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
else
    fprintf('\nWARNING: Empty or unrecognized request.\nAssuming default color...\n');
    build = DEF_COLOR;
end

% Loop to make the figure

for i = 1:length(build)
    colors = build(i);
    %% Load intrinsics and CHESS and BACKGROUND images
    fprintf('##############################################################################\n');
    fprintf('Loading intrinsic and extrinsic parameters...\n');
    load Calib_Results.mat;
    load extrinsic.mat
    img_chess = rgb2gray(imread('fig_calib/calib1.tif'));
    img_bkg = imread('fig_calib/background.tif');
    
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
    
    %% Getting picture of Workspace and detecting colors
    
    fprintf('Taking picture of the current workspace...\n');
    img_curr = snapshot(cam(1));
    imwrite(img_curr,'fig_calib/current.TIF');
    [img_coord, rot_angle] = blockExtraction(colors,...
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
    
    %% Plotting Image and Coordinates
    if plotr == 1
        figure();
        iptsetpref('ImshowAxesVisible','on');
        imshow(img_curr,'XData',[0 size(img_curr,2)], 'YData', [0 size(img_curr,1)]);
        hold on;
        grid on;
        grid minor;
        scatter(img_og(1),img_og(2),'rx');
        scatter(img_cur(1),img_cur(2),'bx');
        scatter(img_cul(1),img_cul(2),'yx');
        scatter(img_cdl(1),img_cdl(2),'cx');
    end
    
    % Print Coordinates
    fprintf('Image Coordinates: X: %.4f Y: %.4f R: %.4f degrees\n',img_coord(1),img_coord(2),rot_angle);
    fprintf('World Coordinates: X: %.4f Y: %.4f\n', w_coord(1),w_coord(2));
    fprintf('Robot Coordinates: X: %.4f Y: %.4f\n', r_coord(1),r_coord(2));
    
    %% MOVEMENT
    % GRIPPING
    % Z = 204
    % r = -45
    
    fprintf('Starting motion of the robot...\n');
    
    r.closeGrapper
    pause(2);
    r.moveLinear(r_coord(1),r_coord(2),250,0,180,rot_angle,20)
    pause(2);
    r.moveLinear(r_coord(1),r_coord(2),215,0,180,rot_angle,10)
    pause(2);
    r.openGrapper
    pause(2);
    r.moveLinear(r_coord(1),r_coord(2),250,0,180,rot_angle,10)
    pause(2);
    
    %Move robot to center (NOT ORIGEN)
    r.moveLinear(425,0,300,0,180,0,20)
    pause(2);
    
    fprintf('Program finished!\n');
    fprintf('##############################################################################\n');
end
