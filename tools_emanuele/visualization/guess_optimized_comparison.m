function guess_optimized_comparison(landmarks_gt,poses_gt,XR_history,XL_history,land_IDs,pose_IDs)

[poses_guess,landmarks_guess] = state_to_poses_and_landmarks(XR_history(:,:,:,1),XL_history(:,:,:,1),land_IDs,pose_IDs);
[poses_optim,landmarks_optim] = state_to_poses_and_landmarks(XR_history(:,:,:,end),XL_history(:,:,:,end),land_IDs,pose_IDs);


fig=figure(1);

subplot(2,2,1);
h1=drawLandmarks_ema(landmarks_gt, 'red', 'fill');
hold on;
h2=drawLandmarks_ema(landmarks_guess, 'green', 'fill');
legend([h1,h2],"Landmark True","Initial Guess",'Location','southoutside');
hold off;

subplot(2,2,2);
h1=drawLandmarks_ema(landmarks_gt, 'red', 'fill');
hold on;
h2=drawLandmarks_ema(landmarks_optim, 'green', 'fill');
legend([h1,h2],"Landmark True","Optimized Guess",'Location','southoutside');
grid;
hold off;

subplot(2,2,3);
h1=plotPoses(poses_gt, 'red', 'fill');
hold on;
h2=plotPoses(poses_guess, 'green', 'fill');
legend([h1,h2],"Poses True", "Initial Guess",'Location','southoutside');
grid;
hold off;

subplot(2,2,4);
h1=plotPoses(poses_gt, 'red', 'fill');
hold on;
h2=plotPoses(poses_optim, 'green', 'fill');
legend([h1,h2],"Poses True", "Optimized Guess",'Location','southoutside');grid;
hold off;
