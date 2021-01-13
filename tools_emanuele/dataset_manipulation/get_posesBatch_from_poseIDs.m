%################################################################################
%
% extract a batch of poses from "poses", given their IDs
%
%################################################################################

function poseBatch = get_posesBatch_from_poseIDs(poses,poseIDs)
  poseBatch = [];
  for i=1:length(poses)
    if ismember(poses(i).id,poseIDs)
      poseBatch = [poseBatch poses(i)];
    end
  end
end
