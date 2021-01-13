%################################################################################
%
% compute data structures from state in matrix/vector form
%
%################################################################################

function [poses,landmarks] = state_to_poses_and_landmarks(XR,XL,land_IDs,pose_IDs)
  n_poses=size(XR,3);
  n_landmarks=size(XL,3);
  for i=1:n_landmarks
    landmarks(end+1).id=land_IDs(i);
    landmarks(end).x_pose=XL(:,1,i)(1);
    landmarks(end).y_pose=XL(:,1,i)(2);
  end
  for i=1:n_poses
    v=t2v(XR(:,:,i));
    poses(end+1).id=pose_IDs(i);
    poses(end).x=v(1);
    poses(end).y=v(2);
    poses(end).theta=v(3);
  end
end
