%###########################################################
% collect each single range observations providing
% landmark index j, pose index i and measurement (range)
%###########################################################

function landmark_associations = landmark_associations(pose_IDs,observations,land_IDs)
  n_poses=length(pose_IDs);
  n_landmarks=length(land_IDs);
  for i=1:n_landmarks
    land_id=land_IDs(i);
    [poseIDs_subsection, measurements] = collect_poseIDs_and_measurements_from_landID(observations,land_id);
    for j=1:length(poseIDs_subsection)
      pose_id=poseIDs_subsection(j);
      pose_index=find(pose_IDs==pose_id);

      landmark_associations(end+1).landmark_index=i;
      landmark_associations(end).pose_index=pose_index;
      landmark_associations(end).measurement=measurements(j);
    end

end
