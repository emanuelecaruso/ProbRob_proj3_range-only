%################################################################################
%
% the state is X=(XR_1,...,XR_N,XL_1,...,XL_M)
% where XR_i belongs to SE(2), so is an homogeneous transformation matrix
% where XL_i belongs to R^2, so is a 2D vector
% here we extract matrices and vectors representing state, from data structures
%
%################################################################################

function [XR,XL] = state_extraction(poses,landmarks)
  n_poses=length(poses);
  n_landmarks=length(landmarks);
  XR=zeros([3,3,n_poses]);
  XL=zeros([2,1,n_landmarks]);
  for i=1:n_poses
    XR(:,:,i)=v2t([poses(i).x,poses(i).y,poses(i).theta]);
  end
  for i=1:n_landmarks
    XL(:,1,i)=[landmarks(i).x_pose;landmarks(i).y_pose];
  end
end
