function info_table = run_info_table
% add lum of cue for low contrast task condition
% 20230608 J Zhu
clearvars
[file,~] = uigetfile('*.mat',...
    'Select One or More Files', ...
    'MultiSelect', 'on');
for nf = 1:length(file)
    filename = [file{nf}];
    [delay, n_class, n_trial, n_cor_trial, PeakLoc1, PeakLoc2, sess_date, lum] = get_sess_info(filename);
    info_table(nf,:) = [filename, string([delay, n_class, n_trial, n_cor_trial, PeakLoc1, PeakLoc2]), sess_date, lum];
end
end
%%%%%%%%%%%%%%%%%%%%%%%%%
% get session information
function [delay, n_class, n_trial, n_cor_trial, peak_loc1, peak_loc2, sess_date, lum] = get_sess_info(filename)
load(filename)
delay = AllData.parameters.delayDuration;
n_class = length(AllData.ClassStructure);
n_trial = length(AllData.trials);
n_cor_trial = length(find([AllData.trials.Statecode]==7));
sess_date = [num2str(AllData.synctime(1)), num2str(AllData.synctime(2)), num2str(AllData.synctime(3))]; % yyyymmdd
lum = AllData.parameters.luminance;
try
    [loc_hist,loc_hist_ind] = ksdensity(AllData.ClassDistribution);
    peak_class = ceil(loc_hist_ind(loc_hist == max(loc_hist)));
    if peak_class >= 60
        peak_class = peak_class - 60;
    end
    peak_loc1 = str2double(AllData.ClassStructure(peak_class).Notes);
    peak_loc2 = peak_loc1+180;
catch
    peak_loc1 = nan;
    peak_loc2 = nan;
end
end
