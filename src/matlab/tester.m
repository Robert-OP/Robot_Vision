%**************************************************************************
%
% CA8 - ROBOT VISION 
% MINIPROJECT
% tester.m
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
% Creates the conector object
RobotConnector;
r = RobotConnector;

r.openGrapper
r.closeGrapper