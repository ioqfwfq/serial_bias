function [X_all, Y_all, fn] = Behavior_Data_SacEndpoint_circCalib
% This function loops proSaccade_correcttrial.m
% OUTPUT: FOR EACH LOOP, csv files with 4 columns: Statecode, target location (in degree),
% x_endpoint and y_endpoint.
% Junda Zhu, 12-8-2021.
% updated for recordings @VU, new format of the data files --JZ 20220201
clearvars
[fn,~] = uigetfile('*.mat',...
    'Select One or More Files', ...
    'MultiSelect', 'on');
X_all=[];
Y_all=[];
fn=fn';
for i = 1:length(fn)
    filename = [fn{i}];
    [Statecode, class_indices, x_endpoint, y_endpoint] = proSaccade_calib(filename);
    result(:,1) = Statecode;
    result(:,2) = class_indices; % class number lead to target info
    result(:,3) = x_endpoint;
    result(:,4) = y_endpoint;
    
    writematrix(result, [filename '.csv']);
    
    % scatter(x_endpoint(Statecode==3),y_endpoint(Statecode==3),500,'.')
    % xtar = [10/(2^0.5) 0 -10/(2^0.5) -10 -10/(2^0.5) 0 10/(2^0.5) 10 0];
    % ytar = [10/(2^0.5) 10 10/(2^0.5) 0 -10/(2^0.5) -10 -10/(2^0.5) 0 0];
    % scatter(xtar,ytar,200,'x',linewidth=2)
    % xlim([-15 15])
    % ylim([-15 15])
    % title(filename)
    result = [];
    disp([filename ' done']);
    for cl = 1:9
        X_all(i,cl) = mean(x_endpoint(Statecode==3&class_indices==cl));
        Y_all(i,cl) = mean(y_endpoint(Statecode==3&class_indices==cl));
    end
end