function [XR_out,XL_out]= box_plus(XR,XL,dx)
  n_poses=size(XR,3);
  n_landmarks=size(XL,3);
  pose_dim=3;
  landmark_dim=2;
  XR_out=zeros(size(XR));
  XL_out=zeros(size(XL));

  for i=1:n_poses
    pose_index_i=1+(i-1)*pose_dim;
    DX=v2t(dx(pose_index_i:pose_index_i+pose_dim-1));
    XR_out(:,:,i)=DX*XR(:,:,i); % box plus definition
  end
  for i=1:n_landmarks
    pose_index_j=n_poses*pose_dim+1+(i-1)*landmark_dim;
    XL_out(:,1,i)=XL(:,1,i)+dx(pose_index_j:pose_index_j+landmark_dim-1); % euclidean plus for landmarks (R^2 space)
  end
end
