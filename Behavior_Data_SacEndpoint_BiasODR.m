function Behavior_Data_SacEndpoint_BiasODR
% This function loops proSaccade_correcttrial.m
% OUTPUT: FOR EACH LOOP, csv files with 4 columns: Statecode, target location (in degree),
% x_endpoint and y_endpoint.
% Junda Zhu, 12-8-2021.
clear all
[~, Neurons_txt] = xlsread('G:\My Drive\BiasedODR\new\beh_data\filelist.xlsx','VIK');

fn = Neurons_txt(:,1);

for i = 1:length(fn)
    filename = [fn{i}];
    [Statecode, class_indices, x_endpoint, y_endpoint, ~] = proSaccade_alltrial(filename);
    result(:,1) = Statecode;
    result(:,2) = (class_indices-1)*3; % class number lead to target info
    result(:,3) = x_endpoint;
    result(:,4) = y_endpoint;

    writematrix(result, [filename '.csv']);
    result = [];
    disp([filename ' done']);
end
clear all