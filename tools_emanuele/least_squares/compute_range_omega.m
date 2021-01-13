%###########################################################
% function thatcompute certainty of range measurement
% by looking at the groundtruth and the measurements
%###########################################################

function omega = compute_range_omega(landmark_associations,landmarks_gt, poses_gt)
  n_associations=length(landmark_associations);
  variance=0;
  % compute sampling variance
  for curr_obs=1:n_associations
    i=landmark_associations(curr_obs).pose_index;
    j=landmark_associations(curr_obs).landmark_index;
    z=landmark_associations(curr_obs).measurement;
    l=[landmarks_gt(j).x_pose;landmarks_gt(j).y_pose];
    p=[poses_gt(i).x;poses_gt(i).y];
    z_hat=norm(p-l);
    variance+=norm(z-z_hat)^2;
  end
  % turn sigma into omega
  variance=variance/(n_associations-1);
  omega=1/variance;
end
