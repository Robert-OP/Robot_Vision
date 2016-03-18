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

clc; clear all; close all;

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

% Creates the conector object
RobotConnector;
r = RobotConnector;

%r.moveLinear
%r.moveJoint
r.closeGrapper
r.openGrapper