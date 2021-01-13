function out = plotPoses(poses,color)
  n_poses=length(poses);
  for i=1:n_poses
    robot_pose=[poses(i).x,poses(i).y,poses(i).theta];
    out = drawRobot(robot_pose, zeros(3),color);
  end

end
