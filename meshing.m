function [] = meshing(ptCloud, color)

p = double(ptCloud.Location);

%% Run  program
t = triangles(p);


%% plot the output triangulation
figure;
hold on
title('Output Triangulation','fontsize',14)
axis equal
% figure;
if strcmp(color, 'none')
    trisurf(t, p(:,1) , p(:,2) , p(:,3))        % plot della superficie
else
    trisurf(t, p(:,1) , p(:,2) , p(:,3) , 'facecolor', color , 'edgecolor' , color)        % plot della superficie

end
view(3);
rotate3d on;



end




