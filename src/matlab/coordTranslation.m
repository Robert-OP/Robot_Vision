%**************************************************************************
%
% CA8 - ROBOT VISION 
% MINIPROJECT
% coordTranslation.m
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

% clear all; close all; clc;

%% MAIN
% global connection
% 
% % tester;
% if connection ~= 1
%     RobotConnector;
%     r = RobotConnector;
%     connection = 1;
% end

% Load intrinsics and image
load Calib_Results.mat;
load extrinsic.mat
img = rgb2gray(imread('fig/Alvaro_pussy.jpg'));
% cd ('fig/');
% extrinsic_computation;
% cd('..');

% Extrinsic and Intrinsic Matrices are used to change the coordinate
% systems
extrinsic = [Rc_ext Tc_ext];
intrinsic = KK;

% Projective Matrix
Proj = intrinsic*extrinsic;

% We can ignore the third column because the Z coordinate is always zero.
% So we will have a 3x3 matrix and we will be able to inverse it.
Proj(:,3)=[];

% Calculations using the origin to get the w (last value of the matrix
% Values)
% Origin
img_og = Proj*[0;0;1];
w_og = img_og(3);
img_og = img_og/w_og;
% Corners
img_cur = Proj*[29*7;0;1];
w_cur = img_cur(3);
img_cur = img_cur/img_cur(3);
img_cul = Proj*[29*7;29*10;1];
w_cul = img_cul(3);
img_cul = img_cul/img_cul(3);
img_cdl = Proj*[0;29*10;1];
w_cdl = img_cdl(3);
img_cdl = img_cdl/img_cdl(3);
% Auxiliar
img_aux = Proj*[29*3; 29*5; 1];
w_aux = img_aux(3);
img_aux = img_aux/img_aux(3);

% Values that we will use; they will be some input provided by some
% functions which will calculate the correct position of the block on the 
% image. NOW ONLY TEST VALUES
img_coordx = 1213.9;
img_coordy = 663.3;
img_coord = [img_coordx; img_coordy; 1];

% The invertion of the P matrix will be made in order to find the 
% coordinates in the world system. However, this coordinates are not
% correct because we need to normalize it using the third value of the same
% matrix. We need to divide by 100 to get the values with correct units
% (cm).
w_coord = Proj\(925*img_coord);
w_coordx = w_coord(1)/(w_coord(3));
w_coordy = w_coord(2)/(w_coord(3));
w_coord = [w_coordx; w_coordy; 1];

% ROBOT FRAME
theta = deg2rad(270);
Trans_mat = [cos(theta)    -sin(theta)    0    234.658   
             sin(theta)    cos(theta)    0    400.303
             0              0             1    0        ];
r_coord = [Trans_mat; 0 0 0 1]*[w_coord; 1];

%% IMAGE 
% figure();
% iptsetpref('ImshowAxesVisible','on');
% imshow(img,'XData',[0 size(img,2)], 'YData', [0 size(img,1)]);
% hold on;
% grid on;
% grid minor;
% scatter(100,200,'rx');
% scatter(img_og(1),img_og(2),'rx');
% scatter(img_cur(1),img_cur(2),'bx');
% scatter(img_cul(1),img_cul(2),'yx');
% scatter(img_cdl(1),img_cdl(2),'cx');


% Print Coordinates
fprintf('Image Coordinates: X: %.4f Y: %.4f\n',img_coord(1),img_coord(2));
fprintf('World Coordinates: X: %.4f Y: %.4f\n', w_coord(1),w_coord(2));
fprintf('Robot Coordinates: X: %.4f Y: %.4f\n', r_coord(1),r_coord(2));

%% MOVEMENT
% GRIPPING
% Z = 204
% r = -45
% 58.875

r.closeGrapper
pause(2);
r.moveLinear(r_coord(1),r_coord(2),250,0,180,-6.66,20)
pause(2);
r.moveLinear(r_coord(1),r_coord(2),215,0,180,-6.66,10)
pause(2);
r.openGrapper
pause(2);
r.moveLinear(r_coord(1),r_coord(2),250,0,180,-6.66,10)
pause(2);

%Move robot to center (NOT ORIGEN)
r.moveLinear(425,0,300,0,180,-45,20)
pause(2);

