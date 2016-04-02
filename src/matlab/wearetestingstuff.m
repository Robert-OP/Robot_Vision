close all; clear all; clc;

%% New calibration

load('Calib_Results.mat')

img = rgb2gray(imread('fig/chessboard.jpg'));
% img = rgb2gray(imread('fig/chessboard1.jpg'));

imshow(img);
cd('fig/');
extrinsic_computation;
cd('..');