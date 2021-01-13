%###########################################################
% collect each single transition observation providing
% starting pose index i, end pose index j and measurement (pose in SE(2))
%###########################################################

function pose_associations = pose_associations(transitions,pose_IDs,land_IDs)
  n_transitions=length(transitions);
  for i=1:n_transitions
    pose_associations(end+1).index_from=find(pose_IDs==transitions(i).id_from);
    pose_associations(end).index_to=find(pose_IDs==transitions(i).id_to);
    pose_associations(end).measurement=v2t(transitions(i).v);
  end
end
