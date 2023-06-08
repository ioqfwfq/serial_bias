function [Statecode, class_indices, x_endpoint, y_endpoint, sac_dur, reaction_time] = proSaccade_alltrial(filename)
% This function loops Find_Saccade.m to find the endpoint locations (coodinates in degree)
% of saccades from all trials.
% OUTPUT:Statecode (1-7), sac_dur = saccade duration, x_endpoint = x eye positions of the
% saccade endpoints, y_endpoint = y eye positions of the saccade endpoints
% INPUT: filename = single neuron file name in string
% Joshua Seideman, 10-MAR-2015. CC 10-SEP-2016. SL 6/12/2019.
% Junda Zhu, 20220329, update for recordings @VU, new format of the data files
% Junda Zhu, 20221128, add reaction time to output

load(filename);
trials= 1:length(AllData.trials);
eyefq = 500; % Hz
[Statecode, x_endpoint, y_endpoint, sac_dur, class_indices, reaction_time]= deal(nan(1,numel(trials))); %preallocate vectors

for ntr = trials
    class_indices(ntr) = AllData.trials(ntr).Class;
    try
        Statecode(ntr) = AllData.trials(ntr).Statecode;
        [~, ~, startpoint, endpoint, newy, newx] = Find_Saccade(AllData,ntr);
    catch
        newx = nan;
    end        
    if isnan(newx)
        class_indices(ntr) = nan;
        x_endpoint(ntr) = nan;
        y_endpoint(ntr) = nan;
        sac_dur(ntr) = nan;
    else
%         xrawsac=(AllData.trials(ntr).EyeData(raw_startpoint:raw_endpoint,2)*3.5);
%         yrawsac= (AllData.trials(ntr).EyeData(raw_startpoint:raw_endpoint,1)*-3.5);
        x_endpoint(ntr) = newx(endpoint);
        y_endpoint(ntr) = newy(endpoint);
        sac_dur(ntr)=((numel(startpoint:endpoint)-1)*2/eyefq);
        reaction_time(ntr) = (startpoint-1)*2/eyefq;
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
