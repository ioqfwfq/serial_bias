function check_distribution
% plot trial target distributions
% 9-20-2022 JZ
clearvars;
[file,~] = uigetfile('*.mat',...
    'Select One or More Files', ...
    'MultiSelect', 'on');
classes_all = [];
for nf = 1:length(file)
    filename = [file{nf}];
    [classes] = get_sess_classes(filename);
    classes_all = [classes_all, classes];
end
figure
histogram(classes_all,120);
end
%% get classes
function [classes] = get_sess_classes(filename)
load(filename)
classes = [AllData.trials([AllData.trials.Statecode] == 6).Class];
end
