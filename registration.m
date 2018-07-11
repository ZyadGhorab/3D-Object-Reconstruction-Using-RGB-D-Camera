function [ ptCloudScene ] = registration(ptClouds)

  
 

% Extract two consecutive point clouds and use the first point cloud as
% reference.
ptCloudRef = ptClouds{1};
ptCloudCurrent = ptClouds{2};


fixed = ptCloudRef;
moving = ptCloudCurrent;
tform = pcregrigid(moving, fixed, 'Metric','pointToPlane','Extrapolate', true);
ptCloudAligned = pctransform(ptCloudCurrent,tform);

mergeSize = 0.003;
ptCloudScene = pcmerge(ptCloudRef, ptCloudAligned, mergeSize);




% Store the transformation object that accumulates the transformation.
accumTform = tform;



for i = 3:length(ptClouds)
     display(i);
    ptCloudCurrent = ptClouds{i};

    % Use previous moving point cloud as reference.
    fixed = moving;
    moving = ptCloudCurrent;
%     moving = pcdownsample(ptCloudCurrent,'gridaverage', gridSize);

    % Apply ICP registration.
    tform = pcregrigid(moving, fixed, 'Metric','pointToPlane','Extrapolate', true);

    % Transform the current point cloud to the reference coordinate system
    % defined by the first point cloud.
    accumTform = affine3d(tform.T * accumTform.T);
    ptCloudAligned = pctransform(ptCloudCurrent, accumTform);

    % Update the world scene.
    ptCloudScene = pcmerge(ptCloudScene, ptCloudAligned, mergeSize);

end

% During the recording, the Kinect was pointing downward. To visualize the
% result more easily, let's transform the data so that the ground plane is
% parallel to the X-Z plane.
angle = -pi/10;
A = [1,0,0,0;...
     0, cos(angle), sin(angle), 0; ...
     0, -sin(angle), cos(angle), 0; ...
     0 0 0 1];
ptCloudScene = pctransform(ptCloudScene, affine3d(A));






end

