function [  ] = loadPointClouds( subfolder )


% subfolder = 'bowl';

directory = strcat('data/', subfolder, '/');

color = load(strcat(directory, '/color.txt'));

RGB = uint8(color);

color = color / 255;

files = dir(strcat(directory, '*.ply'));

for i = 1 : length(files)
    
    display(i);
    ptCloud = pcread(strcat(directory, files(i).name));
    
    c(1 :  ptCloud.Count, 1) = RGB(1);
    c(1 :  ptCloud.Count, 2) = RGB(2);
    c(1 :  ptCloud.Count, 3) = RGB(3);
    ptCloud.Color = uint8(c);
    c = [];
    
    ptClouds{i} = ptCloud;
end
result = registration(ptClouds);
c(1 :  result.Count, 1) = RGB(1);
c(1 :  result.Count, 2) = RGB(2);
c(1 :  result.Count, 3) = RGB(3);
result.Color = uint8(c);
pcwrite(result, strcat('reconstruction/', subfolder , '.ply'));
pcshow(result);
meshing(result, color);

end


