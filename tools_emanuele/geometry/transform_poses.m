%################################################################################
%
% apply a rigid transformation represented by the homogeneous transformation matrix try
% to a bunch of poses
%
%################################################################################

function poses_transformed = transform_poses(poses,T)
  n_poses=length(poses);
  for i=1:n_poses
    transformed_pose=t2v(T*v2t([poses(i).x, poses(i).y, poses(i).theta]));
    poses_transformed(i).id=poses(i).id;
    poses_transformed(i).x=transformed_pose(1);
    poses_transformed(i).y=transformed_pose(2);
    poses_transformed(i).theta=transformed_pose(3);
  end
end
