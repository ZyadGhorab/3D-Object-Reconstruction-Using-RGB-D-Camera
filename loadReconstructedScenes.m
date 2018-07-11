function [  ] = loadReconstructedScenes(  )

clc;
close all;
clear all;
scenes = dir('reconstruction/*.ply');

for i = 1 : length(scenes)
    ptCloudScene = pcread(strcat('reconstruction/' , scenes(i).name));
    pcshow(ptCloudScene);
end



end

