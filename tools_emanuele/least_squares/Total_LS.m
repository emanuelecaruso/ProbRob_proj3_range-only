function [XR_history,XL_history,H,b,chi_history_pose,chi_history_land,num_inliers_history_pose,num_inliers_history_land] = Total_LS(XR,XL,landmark_associations,pose_associations,omega_landmark,omega_pose,num_iterations,damping, kernel_threshold)

  n_landmark_associations=length(landmark_associations);
  n_pose_associations=length(pose_associations);
  %initialize state history
  XR_history=zeros(size(XR,1),size(XR,2),size(XR,3),num_iterations+1);
  XL_history=zeros(size(XL,1),size(XL,2),size(XL,3),num_iterations+1);
  % push initial guess in state history
  XR_history(:,:,:,1)=XR;
  XL_history(:,:,:,1)=XL;
  % initialize chi and inliers histories
  chi_history_land=[];
  chi_history_pose=[];
  num_inliers_history_land=[];
  num_inliers_history_pose=[];

  pose_dim=3;
  landmark_dim=2;
  n_poses=size(XR,3);
  n_landmarks=size(XL,3);
  % compute system size (system -> H dx = b)
  system_size=n_poses*pose_dim+n_landmarks*landmark_dim;

  disp("Executing Total Least Squares ...\n")

  for iteration=1:num_iterations

    % clear H b chi and inliers
    H_land=zeros(system_size,system_size);
    b_land=zeros(system_size,1);
    H_pose=zeros(system_size,system_size);
    b_pose=zeros(system_size,1);
    chi_tot_land=0;
    chi_tot_pose=0;
    num_inliers_land=0;
    num_inliers_pose=0;

    %#############################################################
    %     least squares LANDMARKS
    %
    for curr_obs=1:n_landmark_associations
      i=landmark_associations(curr_obs).pose_index; %landmark index
      j=landmark_associations(curr_obs).landmark_index; %pose index
      z=landmark_associations(curr_obs).measurement;  %measurement
      XR_i=XR(:,:,i); % take i-th pose
      XL_j=XL(:,1,j); % take j-th landmark
      [e,JR,JL] = landmark_errorAndJacobian(XR_i,XL_j,z); % compute error and jacobian
      chi=transpose(e)*e; % compute chi square

      % robustifier
      if (chi>kernel_threshold)
        e*=sqrt(kernel_threshold/chi);
        chi=kernel_threshold;
      else
        num_inliers_land++; % count inliers
      end
      chi_tot_land+=chi; % add chi square contribution

      % indices for H and b computation
      pose_index_i=1+(i-1)*pose_dim;
      pose_index_j=n_poses*pose_dim+1+(j-1)*landmark_dim;

      % compute H and b
      H_land(pose_index_i:pose_index_i+pose_dim-1,
      pose_index_i:pose_index_i+pose_dim-1)+=transpose(JR)*omega_landmark*JR;

      H_land(pose_index_i:pose_index_i+pose_dim-1,
      pose_index_j:pose_index_j+landmark_dim-1)+=transpose(JR)*omega_landmark*JL;

      H_land(pose_index_j:pose_index_j+landmark_dim-1,
      pose_index_i:pose_index_i+pose_dim-1)+=transpose(JL)*omega_landmark*JR;

      H_land(pose_index_j:pose_index_j+landmark_dim-1,
      pose_index_j:pose_index_j+landmark_dim-1)+=transpose(JL)*omega_landmark*JL;

      b_land(pose_index_i:pose_index_i+pose_dim-1)+=transpose(JR)*omega_landmark*e;
      b_land(pose_index_j:pose_index_j+landmark_dim-1)+=transpose(JL)*omega_landmark*e;
    end

    %#############################################################
    %    least squares POSE2POSE
    %
    for curr_trans=1:n_pose_associations
      i=pose_associations(curr_trans).index_from; %pose i index
      j=pose_associations(curr_trans).index_to; %pose j index
      Z=pose_associations(curr_trans).measurement; %measurement

      XR_i=XR(:,:,i); % take i-th pose
      XR_j=XR(:,:,j); % take j-th pose
      [e,Ji,Jj] = pose_errorAndJacobian(XR_i,XR_j,Z); % compute error and jacobian
      chi=transpose(e)*e; % compute chi square

      % robustifier
      if (chi>kernel_threshold)
        e*=sqrt(kernel_threshold/chi);
        chi=kernel_threshold;
      else
        num_inliers_pose++;  % count inliers
      end
      chi_tot_pose+=chi;

      % indices for H and b computation
      pose_index_i=1+(i-1)*pose_dim;
      pose_index_j=1+(j-1)*pose_dim;

      % compute H and b
      H_pose(pose_index_i:pose_index_i+pose_dim-1,
      pose_index_i:pose_index_i+pose_dim-1)+=transpose(Ji)*omega_pose*Ji;

      H_pose(pose_index_i:pose_index_i+pose_dim-1,
      pose_index_j:pose_index_j+pose_dim-1)+=transpose(Ji)*omega_pose*Jj;

      H_pose(pose_index_j:pose_index_j+pose_dim-1,
      pose_index_i:pose_index_i+pose_dim-1)+=transpose(Jj)*omega_pose*Ji;

      H_pose(pose_index_j:pose_index_j+pose_dim-1,
      pose_index_j:pose_index_j+pose_dim-1)+=transpose(Jj)*omega_pose*Jj;

      b_pose(pose_index_i:pose_index_i+pose_dim-1)+=transpose(Ji)*omega_pose*e;
      b_pose(pose_index_j:pose_index_j+pose_dim-1)+=transpose(Jj)*omega_pose*e;

    end

    disp(["ITERATION ", num2str(iteration), ": "])
    disp(["Chi square landmark : ", num2str(chi_tot_land)])
    disp(["Chi square pose: ", num2str(chi_tot_pose),"\n"])

    % total H and b
    H=H_land+H_pose;
    b=b_land+b_pose;
    H+=eye(system_size)*damping;  %damping


    dx = solve_Hb_system(H,b);  % solve H dx = b system
    [XR,XL]=box_plus(XR,XL,dx); % add increment to the state with box plus
    % update histories
    XR_history(:,:,:,iteration+1)=XR;
    XL_history(:,:,:,iteration+1)=XL;
    chi_history_land=[chi_history_land chi_tot_land];
    chi_history_pose=[chi_history_pose chi_tot_pose];
    num_inliers_history_pose=[num_inliers_history_pose num_inliers_pose];
    num_inliers_history_land=[num_inliers_history_land num_inliers_land];

  end


end
