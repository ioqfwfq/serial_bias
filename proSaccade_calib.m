function [Statecode, class_indices, x_endpoint, y_endpoint] = proSaccade_calib(filename)
% This function loops Find_Saccade.m to find the endpoint locations (coodinates in degree)
% of saccades from calib trials.
% OUTPUT:Statecode , x_endpoint = x eye positions of the
% saccade endpoints, y_endpoint = y eye positions of the saccade endpoints
% INPUT: filename = single neuron file name in string
% Joshua Seideman, 10-MAR-2015. CC 10-SEP-2016. SL 6/12/2019.
% Junda Zhu, 11-14-2021.
% updated for recordings @VU, new format of the calibration files --JZ 20220301

load(filename);
trials= 1:length(AllData.trials);
[Statecode, x_endpoint, y_endpoint, class_indices]= deal(nan(1,numel(trials))); %preallocate vectors

for ntr = trials
    class_indices(ntr) = AllData.trials(ntr).Class;
    try
        Statecode(ntr) = AllData.trials(ntr).Statecode;
        [~, ~, ~, endpoint, newy, newx] = Find_Saccade_calib(AllData,ntr);
    catch
        newx = nan;
    end        
    if isnan(newx)
        class_indices(ntr) = nan;
        x_endpoint(ntr) = nan;
        y_endpoint(ntr) = nan;
    else
        x_endpoint(ntr) = mean(newx(endpoint:end));
        y_endpoint(ntr) = mean(newy(endpoint:end));
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
