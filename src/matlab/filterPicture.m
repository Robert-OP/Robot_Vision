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
I = imread('fig/c31.jpg');
Igray = rgb2gray(I);
undistortImage(Igray,fc,cc,alpha_c,kc);
% cd('fig/');
% recomp_corner_calib;