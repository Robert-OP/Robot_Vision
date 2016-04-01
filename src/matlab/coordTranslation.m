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

clear all; close all; clc;

%% MAIN

% Load intrinsics and image
load Calib_Results.mat;
img = rgb2gray(imread('fig/c31.jpg'));
cd ('fig/');
extrinsic_computation;
cd('..');

% Extrinsic and Intrinsic Matrices are used to change the coordinate
% systems
extrinsic = [Rc_1 Tc_1];
intrinsic = KK;

% Projective Matrix
Proj = intrinsic*extrinsic;

% We can ignore the third column because the Z coordinate is always zero.
% So we will have a 3x3 matrix and we will be able to inverse it.
Proj(:,3)=[];

% Calculations using the origin to get the w (last value of the matrix
% Values)
img_og = Proj*[0;0;1];
w = img_og(3);
img_og = img_og/w;

% Values that we will use; they will be some input provided by some
% functions which will calculate the correct position of the block on the 
% image. NOW ONLY TEST VALUES
img_coordx = 400;
img_coordy = 400;
img_coord = [img_coordx; img_coordy; 1];

% The invertion of the P matrix will be made in order to find the 
% coordinates in the world system. However, this coordinates are not
% correct because we need to normalize it using the third value of the same
% matrix. We need to divide by 100 to get the values with correct units
% (cm).
w_coord = Proj\(w*img_coord);

w_coordx = w_coord(1)/(w_coord(3));
w_coordy = w_coord(2)/(w_coord(3));

figure();
imshow(img)
hold on;
scatter(img_og(1),img_og(2),'rx');
