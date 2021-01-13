%################################################################################
%
% array containing pose IDs
%
%################################################################################

function pose_IDs = get_poseIDs(poses)
  n_poses=length(poses);
  pose_IDs = [];
  for i=1:n_poses
    pose_IDs = [pose_IDs poses(i).id];
  end
end
