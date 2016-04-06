close all; clear all; clc;

% Camera from matlab
% Camera connection

webcamlist;             % shows available cameras on pc
cam = webcam(2);        % store camera in a variable and shows parameters
cam.Resolution = '1920x1080';
%preview(cam);         % camera preview (stream video)
I = snapshot(cam);   % take a picture
%%
image(I);             % show image
%I = imread('testBlocks.png');
%imtool(I)           % read RGB colors from an image to do thresholding


imwrite(I,'fig/chessboard4.jpg')
%% New calibration

load('Calib_Results.mat')

img = rgb2gray(imread('fig/chessboard.jpg'));
% img = rgb2gray(imread('fig/chessboard1.jpg'));

imshow(img);
cd('fig/');
extrinsic_computation;
cd('..');