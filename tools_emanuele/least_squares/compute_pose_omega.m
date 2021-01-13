%###########################################################
% function thatcompute certainty of transition measurement
% by looking at the groundtruth and the measurements
%###########################################################

function omega = compute_pose_omega(pose_associations, poses_gt)
  n_associations=length(pose_associations);
  variance_x=0;
  variance_y=0;
  variance_theta=0;
  % compute sampling variance
  for curr_obs=1:n_associations
    i=pose_associations(curr_obs).index_from;
    j=pose_associations(curr_obs).index_to;
    Z=pose_associations(curr_obs).measurement;
    Xi=v2t([poses_gt(i).x,poses_gt(i).y,poses_gt(i).theta]);
    Xj=v2t([poses_gt(j).x,poses_gt(j).y,poses_gt(j).theta]);
    e=t2v(inv(Z)*inv(Xi)*Xj);

    variance_x+=e(1)*e(1);
    variance_y+=e(2)*e(2);
    variance_theta+=e(3)*e(2);
  end
  % turn sigma into omega
  variance_x=variance_x/(n_associations-1);
  omega_x=1/variance_x;
  variance_y=variance_y/(n_associations-1);
  omega_y=1/variance_y;
  variance_theta=variance_theta/(n_associations-1);
  omega_theta=1/variance_theta;
  omega=[omega_x 0 0; 0 omega_y 0; 0 0 omega_theta];
end
