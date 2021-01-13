%################################################################################
%
% initialize the initial guess of landmarks given poses and observation,
% by intersecting circles of radius=range
% as many circles as possible are exploited
%
%################################################################################


function landmarks_guess = landmarks_compute_guess(poses_guess,observations,land_IDs)

  n_landmarks=length(land_IDs);
  disp("initializing guess for landmarks...")
  for i=1:n_landmarks
    land_ID=land_IDs(i);  % current landmark ID
    % collect pose IDs which observe the current landmark and the range values
    [pose_IDs,measurements]=collect_poseIDs_and_measurements_from_landID(observations,land_ID);
    n_poses=length(pose_IDs);

    % if landmark is not observed at all
    if n_poses==0
      % put the landmark at the center of the map (just a convention)
      landmarks_guess(end+1)=landmark(land_ID,[0,0]);
      disp(["landmark ",num2str(land_ID)," is not observed, it is put in the world frame"]);

    % if landmark is observed by just 1 pose
    elseif n_poses==1
      %initialize the landmark at the pose location
      posesBatch=get_posesBatch_from_poseIDs(poses_guess,pose_IDs);
      landmarks_guess(end+1)=landmark(land_ID,[posesBatch(1).x,posesBatch(1).y]);

    % if landmark is observed by 2 poses
    elseif n_poses==2
      % get poses
      posesBatch=get_posesBatch_from_poseIDs(poses_guess,pose_IDs);
      % distance between the 2 poses
      center_difference_norm=norm(posesBatch(1).x-posesBatch(2).x,posesBatch(1).y-posesBatch(2).y);
      %if the 2 circles are too close, initialize at the center
      if center_difference_norm<0.1
        landmarks_guess(end+1)=landmark(land_ID,[posesBatch(1).x,posesBatch(1).y]);
      %else put landmark at the midpoint between the 2 circles intersection
      else
        intersection=midpoint_between_2_circles_intersections([posesBatch(1).x,posesBatch(1).y],
                                [posesBatch(2).x,posesBatch(2).y], measurements(1), measurements(2));
        landmarks_guess(end+1)=landmark(land_ID,[intersection(1),intersection(2)]);
      end

    else
      %estimate landmark position by intersecting circles of radius=range
      posesBatch=get_posesBatch_from_poseIDs(poses_guess,pose_IDs);
      intersection=intersect_N_circles(posesBatch,measurements);
      landmarks_guess(end+1)=landmark(land_ID,[intersection(1),intersection(2)]);

    end
  end
end
