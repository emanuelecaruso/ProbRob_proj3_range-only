function out = drawLandmarks_ema(land,color,mode)

	if(nargin == 1)
		color = 'r';
		mode = 'fill';
	end
	radius = 0.1;
	N = length(land);

	for i=1:N
		out=drawShape('circle', [land(i).x_pose, land(i).y_pose, radius], mode, color);
		hold on;
	end
end
