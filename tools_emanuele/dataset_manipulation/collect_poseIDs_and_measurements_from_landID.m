%################################################################################
%
% collect pose IDs which see the landmark having id = land_id
% and also the measurements
%
%################################################################################

function [poseIDs, measurements] = collect_poseIDs_and_measurements_from_landID(observations,land_id)
  N = length(observations);
  poseIDs = [];
  measurements = [];
  for i=1:N
    M = length(observations(i).observation);
    for j=1:M
      if(observations(i).observation(j).id==land_id)
        poseIDs = [poseIDs observations(i).pose_id];
        measurements = [measurements observations(i).observation(j).range];
        break;
      end
    end
    poseIDs=vertcat(poseIDs);
    measurements=vertcat(measurements);
  end
end
