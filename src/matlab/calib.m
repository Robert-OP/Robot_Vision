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
% - FIRST TIME: Take 30 images of the chessboard from different angles and 
%   poses -> Generate Calib_Results.mat
% - LOOP (manual) -> Recomp corners - Calibration -> UNTIL GOOD ENOUGH
% 
%**************************************************************************
clear all; close all; clc;

%% MAIN

load Calib_Results.mat

% Check if its enough
cd('calibration/');
% reproject_calib;
analyse_error;

% If not: Calibrate again and save
recomp_corner_calib;
cd('..');
go_calib_optim;
saving_calib;
analyse_error;
