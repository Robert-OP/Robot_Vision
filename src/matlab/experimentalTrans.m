function [Transf] = experimentalTrans()
%**************************************************************************
%
% CA8 - ROBOT VISION 
% MINIPROJECT
% experimentalTrans.m
%
%**************************************************************************
% 
% Group 832
% Aalborg University
% March 2016
%
%**************************************************************************
% DESCRIPTION: 
%
% 
%**************************************************************************
x1_w=28*[-1 -1];
x2_w=28*[-1 6];
x3_w=28*[5 2];


x1_r=[239.484 198.714 1];
x2_r=[233.953 398.995];
x3_r=[408.578 287.651];


syms a b c d e f g h k

eq1 = x1_r(1) == a*x1_w(1) + b*x1_w(2) + c;
eq2 = x1_r(2) == d*x1_w(1) + e*x1_w(2) + f;
eq3 = 1 == g*x1_w(1) + h*x1_w(2) + k;

eq4 = x2_r(1) == a*x2_w(1) + b*x2_w(2) + c;
eq5 = x2_r(2) == d*x2_w(1) + e*x2_w(2) + f;
eq6 = 1 == g*x2_w(1) + h*x2_w(2) + k;

eq7 = x3_r(1) == a*x3_w(1) + b*x3_w(2) + c;
eq8 = x3_r(2) == d*x3_w(1) + e*x3_w(2) + f;
eq9 = 1 == g*x3_w(1) + h*x3_w(2) + k;

[sola,solb,solc,sold,sole,solf,solg,solh,solk] = solve([eq1,eq2,eq3,eq4,eq5,eq6,eq7,eq8,eq9],[a,b,c,d,e,f,g,h,k]);

Transf = [sola solb solc; sold sole solf; solg solh solk];
Transf = double(Transf);
end

