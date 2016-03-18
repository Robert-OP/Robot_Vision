%% Project Cobra
clear all; close all; clc;

%% Camera connection
webcamlist           % shows available cameras on pc
cam = webcam(2)      % store camera in a variable and shows parameters
% preview(cam)       % camera preview (stream video)
I = snapshot(cam);   % take a picture
image(I)             % show image
% imtool(I)            % read RGB colors from an image to do thresholding
%%   r_min r_max g_min g_max b_min b_max
R = [170   255   0     30    0     30  ];   % red block
G = [20    60    120   200   100   140 ];   % green block
B = [0     30    50    100   150   210 ];   % blue block
Y = [210   255   190   220   80    120 ];   % yellow block

%%
Im = zeros(size(I,1),size(I,2));            % initialize a black image
C = Y;

for i=1:size(I,1)
    for j=1:size(I,2)
        if I(i,j,1) >= C(1) && I(i,j,1) <= C(2)
            if I(i,j,2) >= C(3) && I(i,j,2) <= C(4)
                if I(i,j,3) >= C(5) && I(i,j,3) <= C(6)
                    Im(i,j,:) = 255;
                end
            end    
        end
    end
end

figure();imshow(Im);
