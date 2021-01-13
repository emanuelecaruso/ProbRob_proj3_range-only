function [e,Ji,Jj] = pose_errorAndJacobian(XR_i,XR_j,Z)

  vi=t2v(XR_i);
  vj=t2v(XR_j);
  vz=t2v(Z);
  % error with ox minus
  e=t2v(inv(Z)*inv(XR_i)*XR_j);

  % jacobian formula is computed separately with MATLAB and its symbolic toolbox
  % if necessary look at MATLAB_separate_scripts folder
  % formula is also reported on slides (block 26, slide 16)
  c=cos(vi(3)+vz(3));
  s=sin(vi(3)+vz(3));
  Ji=[-c, -s,  vj(2)*c-vj(1)*s;
       s, -c, -vj(1)*c-vj(2)*s;
      0,0,-1];

  Jj=[ c, s, vj(1)*s-vj(2)*c;
      -s, c, vj(1)*c+vj(2)*s;
      0,0,1];

end
