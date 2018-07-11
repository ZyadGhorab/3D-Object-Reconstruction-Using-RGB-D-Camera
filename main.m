function [  ] = main( )

close all;
clear all;
clc;

files = dir('data');
for i = 3 : length(files)
    loadPointClouds(files(i).name);
end



end

