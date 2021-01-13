addpath './tools_grisetti/g2o_wrapper' %modified to load range-only observation
addpath './tools_grisetti/visualization'
% addpath './tools_grisetti/utilities'
addpath './tools_emanuele/visualization'
addpath './tools_emanuele/geometry'
addpath './tools_emanuele/dataset_manipulation'
addpath './tools_emanuele/least_squares'
source "./tools_grisetti/utilities/geometry_helpers_2d.m"


%load dataset
[landmarks_gt, poses_gt, transitions, observations] = loadG2o('03-RangeOnlySLAM/slam2d_range_only_ground_truth.g2o');
[~,poses_guess,~, ~] = loadG2o('03-RangeOnlySLAM/slam2d_range_only_initial_guess.g2o');


transitions(1).v
