%% New calibration

load('Calib_Results.mat')

img = rgb2gray(imread('fig/chessboard.jpg'));
% img = rgb2gray(imread('fig/c31.jpg'));

image(I);
cd('fig/');
extrinsic_computation;
cd('..');