%################################################################################
%
% array containing landmark IDs
%
%################################################################################

function land_IDs = get_landIDs(landmarks)
  n_landmarks=length(landmarks);
  land_IDs = [];
  for i=1:n_landmarks
    land_IDs = [land_IDs landmarks(i).id];
  end
end
