function out = drawRobot(pose, covariance,color)

	hold on;
	dim = 0.25;
	arr_len = 0.5;

	out = drawShape('rect', [pose(1), pose(2), dim, dim, pose(3)], 'fill',color);

end
