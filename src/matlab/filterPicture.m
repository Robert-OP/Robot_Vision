%**************************************************************************
%
% CA8 - ROBOT VISION 
% MINIPROJECT
% filterPicture.m
%
%**************************************************************************
%
% Group 832
% Aalborg University
% March 2016
%
%**************************************************************************
% DESCRIPTION: CALIBRATION
%
% - FIRST TIME: Take 30 images of the chessboard from different angles and 
%   poses -> Generate Calib_Results.mat
% - LOOP (manual) -> Recomp corners - Calibration -> UNTIL GOOD ENOUGH
% 
%**************************************************************************

clear all; close all; clc;

%% MAIN

load Calib_Results.mat;
img = imread('calibration/c1.jpg');
img = rgb2gray(img);

% Intrinsic Parameters are already calculated
I_param = [KK];
% Extrinsic Parameters
temp = comp_ext_calib
E_param = [Rc_1 Tc_1];
% World coordinates
worldCoord = [900; 900; 0; 1];

% Coordinates transformation
imgCoord= I_param*E_param*worldCoord;
imgCoord = imgCoord/imgCoord(3);

figure();

imshow(img)
hold on;
plot(imgCoord(1),imgCoord(2),'rx');
% scatter(imgCoord(1),imgCoord(2),'x');
