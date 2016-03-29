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

close all; clear all; clc;

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

%% Conection between robot and computer  
% % Creates the conector object
% RobotConnector;
% r = RobotConnector;
% 
% %r.moveLinear
% %r.moveJoint
% r.closeGrapper
% r.openGrapper

%% Structure of the code

% 1 - User input the figure he wants to get
% 2 - Detect blocks by color
% 3 - Calculate their coordinates based in the edges
% 4 - Actuate with the robot

%% Global variables

STR_HOMER = 'bwy';      % Bottom to top: Blue, white and yellow
STR_MARGE = 'gyb';      % Bottom to top: Green, yellow and blue
STR_BART = 'boy';       % Bottom to top: Blue, orange, yellow

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

usrIn = input(prompt,'s');
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
    fprintf('\nWARNING: Empty or unrecognized request.\nAssuming figure: A) Homer...\n');
    usrIn = 'homer';
end

%% Loading/getting image from camera

test = imread('testBlocks.png');


