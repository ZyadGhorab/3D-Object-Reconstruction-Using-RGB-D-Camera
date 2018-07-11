function [  ] = rotate(ptCloud)

x = pi/180;
R = [ cos(x) sin(x) 0 0
    -sin(x) cos(x) 0 0
    0         0   1 0
    0         0   0 1];

tform = affine3d(R);

lower = min([ptCloud.XLimits ptCloud.YLimits]);
upper = max([ptCloud.XLimits ptCloud.YLimits]);

xlimits = [lower upper];
ylimits = [lower upper];
zlimits = ptCloud.ZLimits;

player = pcplayer(xlimits,ylimits,zlimits);

xlabel(player.Axes,'X (m)');
ylabel(player.Axes,'Y (m)');
zlabel(player.Axes,'Z (m)');

while(true)
    for i = 1:360
        ptCloud = pctransform(ptCloud,tform);
        view(player,ptCloud);
    end
end


end

