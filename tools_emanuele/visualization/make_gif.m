function make_gif(poses_gt,landmarks_gt,XR_history,XL_history,land_IDs,pose_IDs)
  length_history=size(XR_history,4);
  landmarks_history=[];
  poses_history=[];
  for i=1:length_history
    [poses,landmarks] = state_to_poses_and_landmarks(XR_history(:,:,:,i),XL_history(:,:,:,i),land_IDs,pose_IDs);

    poses_history=[poses_history; poses];
    landmarks_history=[landmarks_history; landmarks];

  end

  for i=1:length_history
    disp(["creating gif: img ",num2str(i),"/",num2str(length_history)])
    fig = figure(3);
    drawLandmarks_ema(landmarks_gt, 'red', 'fill');
    hold on;
    drawLandmarks_ema(landmarks_history(i,:), 'green', 'fill');
    hold on;
    plotPoses(poses_gt, 'red');
    hold on;
    plotPoses(poses_history(i,:), 'green');
    axis([-15 20 -20 10])
    title(["iteration ",num2str(i-1)]);
    string=strcat("./images/plot",num2str(i,'%03.f'),".png");
    print(string)  % here you save the figure
    hold off;
  end
  FileName = 'plotAnimation.gif';
  files = glob('./images/*.png');
  n=length(files);
  for i=1:n
    img = imread(files{i});
    if i>length_history
      break;
    end
    if i ==1
    %// For 1st image, start the 'LoopCount'.
        imwrite(img,FileName,'gif','LoopCount',Inf,'DelayTime',1);
    else
        if i==length_history
          DelayTime=1.2;
        else
          DelayTime=0.3;
        end
        imwrite(img,FileName,'gif','WriteMode','append','DelayTime',DelayTime);
    end
  end
  currentFolder = pwd;
  disp(["gif saved in ",currentFolder,FileName])


end
