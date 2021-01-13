function [e,JR,JL] = landmark_errorAndJacobian(XR_i,XL_j,z)

  % extract t and R from the homogeneous transformation matrix
  t=XR_i(1:2,3);
  R=XR_i(1:2,1:2);

  z_hat=norm(transpose(R)*XL_j-transpose(R)*t); % prediction
  e=z_hat-z;  % error

  %extract components for computing easily the jacobian
  tx=t(1);
  ty=t(2);
  XL_x=XL_j(1);
  XL_y=XL_j(2);


 if z_hat>0.0001  % avoid division by 0
   % jacobian formula is computed separately with MATLAB and its symbolic toolbox
   % if necessary look at MATLAB_separate_scripts folder
   JR=-(1/z_hat)*[XL_x-tx,XL_y-ty,XL_y*tx-XL_x*ty];
   JL=(1/z_hat)*[XL_x-tx,XL_y-ty];
 else
   JR=[0,0,0];
   JL=[0,0];
 end
end
