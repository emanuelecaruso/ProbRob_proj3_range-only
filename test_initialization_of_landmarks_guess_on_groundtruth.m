%################################################################################
%
% this test is for checking the validity of the initialization algorithm (computation of the guess for landmarks).
% here the guess of the landmarks is computed on the poses groundtruth and the observations.
% the result is just a plot of groundtruth landmarks and the guessed ones.
% to execute, just run "octave test_initialization_of_landmarks_guess_on_groundtruth.m" in the command line
%
%################################################################################


addpath './tools_grisetti/g2o_wrapper' %modified to load range-only observation
addpath './tools_grisetti/visualization'
addpath './tools_emanuele/visualization'
addpath './tools_emanuele/geometry'
addpath './tools_emanuele/dataset_manipulation'
source "./tools_grisetti/utilities/geometry_helpers_2d.m"


%load dataset
[landmarks_gt, poses_gt, transitions, observations] = loadG2o('03-RangeOnlySLAM/slam2d_range_only_ground_truth.g2o');
[~,poses_guess,~, ~] = loadG2o('03-RangeOnlySLAM/slam2d_range_only_initial_guess.g2o');


%Compute initial guess for landmarks
land_IDs = get_landIDs(landmarks_gt); %get id of landmarks
landmarks_guess = landmarks_compute_guess(poses_gt,observations,land_IDs); %here the poses are taken from the groundtruth

%plot
drawLandmarks(landmarks_gt, 'red', 'fill')
drawLandmarks(landmarks_guess, 'green', 'fill')
waitfor(gcf)  %prevent to close the plots
