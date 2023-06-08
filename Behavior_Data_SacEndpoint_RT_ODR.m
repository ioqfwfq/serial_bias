function Behavior_Data_SacEndpoint_RT_ODR
% This function loops proSaccade_correcttrial.m
% OUTPUT: FOR EACH LOOP, csv files with 5 columns: Statecode, target location (in degree),
% x_endpoint, y_endpoint and reaction time.
% Junda Zhu, 12-8-2021.
% 20221128, add reaction time
clearvars;
[~, Neurons_txt] = xlsread('G:\My Drive\BiasedODR\new\beh_data\filelist.xlsx','UNI');

fn = Neurons_txt(:,1);

for i = 1:length(fn)
    filename = [fn{i}];
    [Statecode, class_indices, x_endpoint, y_endpoint, ~, RT] = proSaccade_alltrial(filename);
    result(:,1) = Statecode;
    result(:,2) = (class_indices-1)*45; % class number lead to target info
    result(:,3) = x_endpoint;
    result(:,4) = y_endpoint;
    result(:,5) = RT;

    writematrix(result, [filename '.csv']);
    result = [];
    disp([filename ' done']);
end