addpath './tools_grisetti/g2o_wrapper' %modified to load range-only observation
addpath './tools_grisetti/visualization'
addpath './tools_emanuele/visualization'
addpath './tools_emanuele/geometry'
addpath './tools_emanuele/dataset_manipulation'
addpath './tools_emanuele/least_squares'
source "./tools_grisetti/utilities/geometry_helpers_2d.m"


%load dataset
[landmarks_gt, poses_gt, transitions, observations] = loadG2o('03-RangeOnlySLAM/slam2d_range_only_ground_truth.g2o');
[~,poses_guess,~, ~] = loadG2o('03-RangeOnlySLAM/slam2d_range_only_initial_guess.g2o');

%static variables
damping=1;
kernel_threshold=1;
num_iterations=20;

%indexes to IDs
pose_IDs= get_poseIDs(poses_gt);
land_IDs = get_landIDs(landmarks_gt);

% apply a rigid transformation in order to fix 1st pose of the guess on the groundtruth 1st pose, (for visual reasons)
T=v2t([0 0 poses_gt(1).theta-poses_guess(1).theta])*v2t([poses_gt(1).x-poses_guess(1).x, poses_gt(1).y-poses_guess(1).y, 0]);
poses_guess = transform_poses(poses_guess,T);

% initialize guess for landmarks by intersecting circles of radius=range
landmarks_guess = landmarks_compute_guess(poses_guess,observations,land_IDs);

% extract matrices/vectors for state representation from data structures
[XR,XL] = state_extraction(poses_guess,landmarks_guess);

% compute measurments associations (IDs and measurements)
landmark_associations = landmark_associations(pose_IDs,observations,land_IDs);
pose_associations = pose_associations(transitions,pose_IDs,land_IDs);

% compute certainty of measurements by looking at the groundtruth and the measurements
omega_range = compute_range_omega(landmark_associations,landmarks_gt, poses_gt)
omega_pose = compute_pose_omega(pose_associations, poses_gt);

% total least squares
[XR_history,XL_history,H,b,chi_history_pose,chi_history_land,num_inliers_history_pose,num_inliers_history_land]=Total_LS(XR,XL,landmark_associations,
                                                                                                                        pose_associations,omega_range,
                                                                                                                        omega_pose,num_iterations,damping,
                                                                                                                        kernel_threshold);




% plot the evolution of chi square and inliers
plot_chi_and_inliers_history(chi_history_land,chi_history_pose,num_inliers_history_land,num_inliers_history_pose)
plotH(H)  % plot H
% plot comparison between inital guess and optimized solution
guess_optimized_comparison(landmarks_gt,poses_gt,XR_history,XL_history,land_IDs,pose_IDs)

% uncomment for making the gif animation of landmarks and poses moving during GN iterations
% make_gif(poses_gt,landmarks_gt,XR_history,XL_history,land_IDs,pose_IDs)

waitfor(gcf)  %prevent to close the plots
