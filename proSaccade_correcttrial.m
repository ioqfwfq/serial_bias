function [Correct_trials, class_indices, x_endpoint, y_endpoint, sac_dur] = proSaccade_correcttrial(filename)
% This function loops Find_Saccade.m to find the endpoint locations (coodinates in degree)
% of saccades from correct trials.
% OUTPUT: sac_dur = saccade duration, x_endpoint = x eye positions of the
% saccade endpoints, y_endpoint = y eye positions of the saccade endpoints
% INPUT: filename = single neuron file name in string
% Joshua Seideman, 10-MAR-2015. CC 10-SEP-2016. SL 6/12/2019.
% Junda Zhu, 11-12-2021.

load(filename);
Correct_trials=find([AllData.trials.Statecode]==6); % find correct trial indices
eyefq = 500;%Hz
[~ , ~, x_endpoint, y_endpoint, sac_dur, class_indices, ~, ~]= deal(nan(1,numel(Correct_trials))); %preallocate vectors

count = 0;
for ntr = Correct_trials
    count = count+1;
    class_indices(count) = AllData.trials(ntr).Class;
    [~, ~, startpoint, endpoint, newy, newx] = Find_Saccade(AllData,ntr);
    if isnan(newx)
        x_endpoint(count) = 0;
        y_endpoint(count) = 0;
        sac_dur(count) = 0;
    else
%         xrawsac=(AllData.trials(ntr).EyeData(raw_startpoint:raw_endpoint,2)*3.5);
%         yrawsac= (AllData.trials(ntr).EyeData(raw_startpoint:raw_endpoint,1)*-3.5);
        x_endpoint(count) = newx(endpoint);
        y_endpoint(count) = newy(endpoint);
        sac_dur(count)=((numel(startpoint:endpoint)-1)*2/eyefq);
        
        %                 figure(2)
        %                 plot(newx(startpoint),newy(startpoint),'+b')
        %                    hold all
        %                   plot(newx(endpoint),newy(endpoint),'+r')
        %                   tnum=ntr
        %                   CLASS=class_indices(count_all)
        %                 xlim([-17 17])
        %                 ylim([-17 17])
        %                 pause
        %         continue
    end
end
end
