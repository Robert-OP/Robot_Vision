% Intrinsic and Extrinsic Camera Parameters
%
% This script file can be directly executed under Matlab to recover the camera intrinsic and extrinsic parameters.
% IMPORTANT: This file contains neither the structure of the calibration objects nor the image coordinates of the calibration points.
%            All those complementary variables are saved in the complete matlab data file Calib_Results.mat.
% For more information regarding the calibration model visit http://www.vision.caltech.edu/bouguetj/calib_doc/


%-- Focal length:
fc = [ 1383.375894088812629 ; 1384.091553350122012 ];

%-- Principal point:
cc = [ 968.184424845937770 ; 521.234401071252933 ];

%-- Skew coefficient:
alpha_c = 0.000000000000000;

%-- Distortion coefficients:
kc = [ 0.088377873921877 ; -0.163679188807684 ; -0.001188924201610 ; -0.002894573720064 ; 0.000000000000000 ];

%-- Focal length uncertainty:
fc_error = [ 4.269476931052033 ; 4.183592473233127 ];

%-- Principal point uncertainty:
cc_error = [ 3.221648285013555 ; 2.879693466670494 ];

%-- Skew coefficient uncertainty:
alpha_c_error = 0.000000000000000;

%-- Distortion coefficients uncertainty:
kc_error = [ 0.005142481835412 ; 0.014129968699596 ; 0.000802509918212 ; 0.000947840960551 ; 0.000000000000000 ];

%-- Image size:
nx = 1920;
ny = 1080;


%-- Various other variables (may be ignored if you do not use the Matlab Calibration Toolbox):
%-- Those variables are used to control which intrinsic parameters should be optimized

n_ima = 30;						% Number of calibration images
est_fc = [ 1 ; 1 ];					% Estimation indicator of the two focal variables
est_aspect_ratio = 1;				% Estimation indicator of the aspect ratio fc(2)/fc(1)
center_optim = 1;					% Estimation indicator of the principal point
est_alpha = 0;						% Estimation indicator of the skew coefficient
est_dist = [ 1 ; 1 ; 1 ; 1 ; 0 ];	% Estimation indicator of the distortion coefficients


%-- Extrinsic parameters:
%-- The rotation (omc_kk) and the translation (Tc_kk) vectors for every calibration image and their uncertainties

%-- Image #1:
omc_1 = [ 2.176618e+00 ; -2.119568e+00 ; -5.623813e-03 ];
Tc_1  = [ 1.081491e+03 ; 9.883964e+02 ; 4.822830e+03 ];
omc_error_1 = [ 2.957144e-03 ; 2.877790e-03 ; 6.116580e-03 ];
Tc_error_1  = [ 1.144441e+01 ; 1.023192e+01 ; 1.674330e+01 ];

%-- Image #2:
omc_2 = [ -2.022849e+00 ; 1.778820e+00 ; -1.512866e-01 ];
Tc_2  = [ 2.214510e+03 ; 1.137796e+03 ; 5.724716e+03 ];
omc_error_2 = [ 2.449709e-03 ; 2.018672e-03 ; 4.012761e-03 ];
Tc_error_2  = [ 1.363651e+01 ; 1.237940e+01 ; 1.640042e+01 ];

%-- Image #3:
omc_3 = [ -1.856309e+00 ; 1.906425e+00 ; 1.041754e-02 ];
Tc_3  = [ 2.511305e+03 ; 9.314295e+02 ; 4.875583e+03 ];
omc_error_3 = [ 2.226659e-03 ; 2.074553e-03 ; 3.839036e-03 ];
Tc_error_3  = [ 1.176295e+01 ; 1.089954e+01 ; 1.426412e+01 ];

%-- Image #4:
omc_4 = [ 2.132308e+00 ; -1.996226e+00 ; -9.132443e-01 ];
Tc_4  = [ 3.163007e+02 ; 1.118894e+03 ; 4.409915e+03 ];
omc_error_4 = [ 2.700627e-03 ; 1.668023e-03 ; 3.879506e-03 ];
Tc_error_4  = [ 1.037006e+01 ; 9.101533e+00 ; 1.407662e+01 ];

%-- Image #5:
omc_5 = [ 2.135673e+00 ; -2.089369e+00 ; -3.933067e-02 ];
Tc_5  = [ 1.251684e+03 ; 1.029757e+03 ; 5.132771e+03 ];
omc_error_5 = [ 3.155309e-03 ; 3.219285e-03 ; 6.563131e-03 ];
Tc_error_5  = [ 1.225669e+01 ; 1.094904e+01 ; 1.815681e+01 ];

%-- Image #6:
omc_6 = [ -2.509326e+00 ; 1.711323e+00 ; 6.149859e-01 ];
Tc_6  = [ 1.599635e+03 ; 1.665061e+03 ; 4.625650e+03 ];
omc_error_6 = [ 2.559496e-03 ; 1.982907e-03 ; 5.258463e-03 ];
Tc_error_6  = [ 1.115852e+01 ; 9.839080e+00 ; 1.479783e+01 ];

%-- Image #7:
omc_7 = [ -2.145648e+00 ; 1.766825e+00 ; 7.895352e-01 ];
Tc_7  = [ 1.349121e+03 ; 1.658815e+03 ; 4.984187e+03 ];
omc_error_7 = [ 1.886712e-03 ; 2.312538e-03 ; 3.872925e-03 ];
Tc_error_7  = [ 1.183259e+01 ; 1.049879e+01 ; 1.511280e+01 ];

%-- Image #8:
omc_8 = [ -2.095544e+00 ; 2.161079e+00 ; 4.172835e-02 ];
Tc_8  = [ 1.698343e+03 ; 1.158133e+03 ; 5.058019e+03 ];
omc_error_8 = [ 2.674010e-03 ; 2.913780e-03 ; 5.686303e-03 ];
Tc_error_8  = [ 1.185802e+01 ; 1.065201e+01 ; 1.629911e+01 ];

%-- Image #9:
omc_9 = [ -1.775638e+00 ; 1.788511e+00 ; 1.105660e-01 ];
Tc_9  = [ 2.093459e+03 ; 1.236706e+03 ; 5.485994e+03 ];
omc_error_9 = [ 2.015817e-03 ; 2.223858e-03 ; 3.275183e-03 ];
Tc_error_9  = [ 1.311188e+01 ; 1.191191e+01 ; 1.501336e+01 ];

%-- Image #10:
omc_10 = [ 2.233776e+00 ; -2.123784e+00 ; 5.550758e-01 ];
Tc_10  = [ 1.638643e+03 ; 6.839473e+02 ; 5.765698e+03 ];
omc_error_10 = [ 2.455895e-03 ; 2.934847e-03 ; 5.395767e-03 ];
Tc_error_10  = [ 1.342636e+01 ; 1.217653e+01 ; 1.858774e+01 ];

%-- Image #11:
omc_11 = [ 1.932907e+00 ; -1.793996e+00 ; -3.522402e-01 ];
Tc_11  = [ 2.649473e+02 ; 9.006331e+02 ; 4.886868e+03 ];
omc_error_11 = [ 2.356292e-03 ; 2.154011e-03 ; 3.912342e-03 ];
Tc_error_11  = [ 1.155273e+01 ; 1.023890e+01 ; 1.790200e+01 ];

%-- Image #12:
omc_12 = [ -2.164548e+00 ; 2.191708e+00 ; 5.668762e-01 ];
Tc_12  = [ 6.975649e+02 ; 1.126547e+03 ; 4.650498e+03 ];
omc_error_12 = [ 1.830814e-03 ; 2.628582e-03 ; 4.667151e-03 ];
Tc_error_12  = [ 1.095808e+01 ; 9.609797e+00 ; 1.504682e+01 ];

%-- Image #13:
omc_13 = [ 2.018748e+00 ; -1.966688e+00 ; 3.579321e-01 ];
Tc_13  = [ 9.682186e+02 ; 6.880945e+02 ; 5.568514e+03 ];
omc_error_13 = [ 2.548035e-03 ; 2.873642e-03 ; 5.079632e-03 ];
Tc_error_13  = [ 1.311126e+01 ; 1.177234e+01 ; 1.947948e+01 ];

%-- Image #14:
omc_14 = [ 2.180314e+00 ; -2.098646e+00 ; 6.762565e-01 ];
Tc_14  = [ 1.989029e+03 ; 9.474259e+02 ; 5.996619e+03 ];
omc_error_14 = [ 2.324725e-03 ; 2.982964e-03 ; 5.072841e-03 ];
Tc_error_14  = [ 1.404872e+01 ; 1.274121e+01 ; 1.957206e+01 ];

%-- Image #15:
omc_15 = [ 1.901659e+00 ; -1.859125e+00 ; -9.037831e-02 ];
Tc_15  = [ -3.331492e+02 ; 9.227892e+02 ; 5.070059e+03 ];
omc_error_15 = [ 2.397168e-03 ; 2.223899e-03 ; 4.147467e-03 ];
Tc_error_15  = [ 1.200639e+01 ; 1.062741e+01 ; 1.807846e+01 ];

%-- Image #16:
omc_16 = [ -2.187446e+00 ; 2.190752e+00 ; 3.635150e-01 ];
Tc_16  = [ 3.941090e+02 ; 1.015451e+03 ; 4.818955e+03 ];
omc_error_16 = [ 2.104130e-03 ; 2.867001e-03 ; 5.134397e-03 ];
Tc_error_16  = [ 1.132612e+01 ; 9.941095e+00 ; 1.585591e+01 ];

%-- Image #17:
omc_17 = [ 1.975420e+00 ; -1.904585e+00 ; 3.388222e-02 ];
Tc_17  = [ 1.166507e+03 ; 7.634643e+02 ; 4.983387e+03 ];
omc_error_17 = [ 2.413599e-03 ; 2.739632e-03 ; 4.694490e-03 ];
Tc_error_17  = [ 1.190585e+01 ; 1.063741e+01 ; 1.831888e+01 ];

%-- Image #18:
omc_18 = [ -2.082325e+00 ; 2.038877e+00 ; -3.009418e-01 ];
Tc_18  = [ 2.762438e+03 ; 8.728220e+02 ; 5.147825e+03 ];
omc_error_18 = [ 2.827475e-03 ; 2.084623e-03 ; 4.565775e-03 ];
Tc_error_18  = [ 1.250854e+01 ; 1.145471e+01 ; 1.633920e+01 ];

%-- Image #19:
omc_19 = [ 2.018601e+00 ; -2.270116e+00 ; -7.831999e-02 ];
Tc_19  = [ 9.036896e+02 ; 9.905965e+02 ; 5.129297e+03 ];
omc_error_19 = [ 2.984041e-03 ; 3.026364e-03 ; 6.221664e-03 ];
Tc_error_19  = [ 1.214849e+01 ; 1.077388e+01 ; 1.793482e+01 ];

%-- Image #20:
omc_20 = [ -2.119341e+00 ; 2.115204e+00 ; 8.625164e-01 ];
Tc_20  = [ 4.229572e+01 ; 1.112578e+03 ; 5.349266e+03 ];
omc_error_20 = [ 1.664892e-03 ; 2.816496e-03 ; 4.393938e-03 ];
Tc_error_20  = [ 1.261711e+01 ; 1.105160e+01 ; 1.692497e+01 ];

%-- Image #21:
omc_21 = [ -2.206765e+00 ; 2.129431e+00 ; -2.228201e-01 ];
Tc_21  = [ 7.660469e+02 ; 1.215390e+03 ; 4.322749e+03 ];
omc_error_21 = [ 2.391566e-03 ; 2.653481e-03 ; 5.692508e-03 ];
Tc_error_21  = [ 1.019947e+01 ; 9.025989e+00 ; 1.398935e+01 ];

%-- Image #22:
omc_22 = [ -2.122571e+00 ; 2.054975e+00 ; -3.377330e-01 ];
Tc_22  = [ 1.218728e+03 ; 1.249464e+03 ; 4.753392e+03 ];
omc_error_22 = [ 2.426103e-03 ; 2.440658e-03 ; 4.864090e-03 ];
Tc_error_22  = [ 1.114977e+01 ; 9.899513e+00 ; 1.450569e+01 ];

%-- Image #23:
omc_23 = [ 2.108620e+00 ; -1.972172e+00 ; -3.897900e-01 ];
Tc_23  = [ 7.233992e+02 ; 1.301186e+03 ; 3.794070e+03 ];
omc_error_23 = [ 2.334676e-03 ; 1.790212e-03 ; 4.156684e-03 ];
Tc_error_23  = [ 9.102865e+00 ; 7.948729e+00 ; 1.283965e+01 ];

%-- Image #24:
omc_24 = [ 2.236584e+00 ; -2.104505e+00 ; -6.082620e-01 ];
Tc_24  = [ 9.784392e+02 ; 1.294297e+03 ; 4.602412e+03 ];
omc_error_24 = [ 2.637537e-03 ; 1.775913e-03 ; 4.639331e-03 ];
Tc_error_24  = [ 1.090507e+01 ; 9.569320e+00 ; 1.493545e+01 ];

%-- Image #25:
omc_25 = [ 2.053437e+00 ; -2.160022e+00 ; -3.424601e-01 ];
Tc_25  = [ 6.485399e+02 ; 1.071679e+03 ; 4.417384e+03 ];
omc_error_25 = [ 2.506842e-03 ; 2.146200e-03 ; 4.659724e-03 ];
Tc_error_25  = [ 1.046331e+01 ; 9.175047e+00 ; 1.497574e+01 ];

%-- Image #26:
omc_26 = [ -2.098177e+00 ; 2.047422e+00 ; 2.964657e-01 ];
Tc_26  = [ 9.158939e+02 ; 9.456672e+02 ; 5.977144e+03 ];
omc_error_26 = [ 2.847992e-03 ; 3.289937e-03 ; 6.052411e-03 ];
Tc_error_26  = [ 1.393878e+01 ; 1.240881e+01 ; 1.905505e+01 ];

%-- Image #27:
omc_27 = [ 2.048710e+00 ; -1.993037e+00 ; 3.501218e-01 ];
Tc_27  = [ 1.261638e+03 ; 6.208115e+02 ; 5.953018e+03 ];
omc_error_27 = [ 2.715813e-03 ; 3.161111e-03 ; 5.549307e-03 ];
Tc_error_27  = [ 1.398838e+01 ; 1.261054e+01 ; 2.103506e+01 ];

%-- Image #28:
omc_28 = [ 2.026854e+00 ; -1.841836e+00 ; 1.463178e-01 ];
Tc_28  = [ 9.105602e+02 ; 7.137576e+02 ; 5.823468e+03 ];
omc_error_28 = [ 2.651875e-03 ; 2.892377e-03 ; 5.071179e-03 ];
Tc_error_28  = [ 1.377403e+01 ; 1.234213e+01 ; 2.156153e+01 ];

%-- Image #29:
omc_29 = [ 2.045529e+00 ; -2.099584e+00 ; 5.690048e-01 ];
Tc_29  = [ 1.913098e+03 ; 6.808792e+02 ; 6.101167e+03 ];
omc_error_29 = [ 2.432777e-03 ; 3.167806e-03 ; 5.257445e-03 ];
Tc_error_29  = [ 1.424909e+01 ; 1.297555e+01 ; 2.060035e+01 ];

%-- Image #30:
omc_30 = [ -1.507905e+00 ; 2.133701e+00 ; 4.987239e-01 ];
Tc_30  = [ 1.242822e+03 ; 1.939580e+02 ; 5.499599e+03 ];
omc_error_30 = [ 1.618253e-03 ; 2.683921e-03 ; 3.830945e-03 ];
Tc_error_30  = [ 1.280930e+01 ; 1.146636e+01 ; 1.506478e+01 ];

