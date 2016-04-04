%**************************************************************************
%
% CA8 - ROBOT VISION 
% MINIPROJECT
% calib.m
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
% 
%**************************************************************************
%% New calibration

load('Calib_Results.mat')

% img = rgb2gray(imread('fig/chessboard4.jpg'));
img = rgb2gray(imread('fig/Alvaro_pussy.jpg'));

imshow(img);
cd('fig/');
extrinsic_computation;
cd('..');