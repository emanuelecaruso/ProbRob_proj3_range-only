function dx = solve_Hb_system(H,b)
  pose_dim=3;
  system_size=size(b,1);

  % initialize increment with zeros
  dx=zeros(size(b));
  % block the 1-st pose
  dx(pose_dim+1:end)=-H(pose_dim+1:end,pose_dim+1:end)\b(pose_dim+1:end);
end
