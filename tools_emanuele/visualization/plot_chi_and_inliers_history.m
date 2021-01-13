function plot_chi_and_inliers_history(chi_history_land,chi_history_pose,num_inliers_history_land,num_inliers_history_pose)

figure(2);
hold on;
grid;
title("chi evolution");

subplot(2,2,1);
plot(chi_history_pose, 'r-', "linewidth", 2);
legend("Chi Poses"); grid; xlabel("iterations");
subplot(2,2,2);
plot(num_inliers_history_pose, 'b-', "linewidth", 2);
legend("#inliers"); grid; xlabel("iterations");

subplot(2,2,3);
plot(chi_history_land, 'r-', "linewidth", 2);
legend("Chi Landmark"); grid; xlabel("iterations");
subplot(2,2,4);
plot(num_inliers_history_land, 'b-', "linewidth", 2);
legend("#inliers"); grid; xlabel("iterations");



end
