function [raw_startpoint, raw_endpoint, startpoint, endpoint, newy, newx] = Find_Saccade_calib(AllData,ntr)
% This function finds indices of the startpoint and endpoint of a saccade for a single calibration trial
% loop this function for multiple trials/files using procSaccade function
% INPUT ntr= single trial number
% OUTPUT newy, newx = downsampled, triangle smoothed y,x eye coordinates
% startpoint, endpoint = saccade startpoint, endpoint indices (time) from smoothed data (newx,newy)
% raw_startpoint, raw_endpoint = saccade startpoint, endpoint indices(time) from raw eye data (x, y in the function)
% indexON and indexOFF are roughly the beginning and end of response epoch of trial (to save time and space when running).
% Joshua Seideman, 10-MAR-2015
% Junda Zhu, 20211112
% updated for recordings @VU, new format of the calibration files --JZ 20220301

indexON = find(AllData.trials(ntr).eye_time(:)>=0);
indexOFF = find(AllData.trials(ntr).eye_time(:)>=(AllData.trials(ntr).EndofTrialtime-AllData.trials(ntr).time));

if isempty(indexON)
    raw_startpoint = nan;
    raw_endpoint = nan;
    startpoint = nan;
    endpoint = nan;
    newy = nan;
    newx = nan;
else    
    x = (AllData.trials(ntr).eye_loc(indexON:indexOFF,1)-AllData.parameters.Display.Xscalecenter).*AllData.parameters.Display.Xscale;   %xeye
    y = (AllData.trials(ntr).eye_loc(indexON:indexOFF,2)-AllData.parameters.Display.Yscalecenter).*AllData.parameters.Display.Yscale;   %yeye
    numpoints = length(x);
    newx(1)=x(1);
    newy(1)=y(1);
    
    %%%%%%%%%%%%%% 5 points smooth %%%%%%%%%%%%%%%%%
    i = 3;
    n=2;
    while i < numpoints-2
        newx(n) = (x(i-2)+2*x(i-1)+3*x(i)+2*x(i+1)+x(i+2))/9;
        newy(n) = (y(i-2)+2*y(i-1)+3*y(i)+2*y(i+1)+y(i+2))/9;
        i=i+2;
        n=n+1;
    end
    numpoints = length(newx);    
    
    %calculate dist away from first index of entire selected epoch
    for z = 2:1:numpoints
        twopoint_dist_from_start(z) = sqrt((newx(z)-newx(1))*(newx(z)-newx(1))+(newy(z)-newy(1))*(newy(z)-newy(1)));
    end
    
    %to find saccade and endpoint: find most consecutive points where dist increasing away from first index of epoch, which also covers the largest dist
    vel=diff(twopoint_dist_from_start); %find distance between two consecutive points
    start_end_dist_vec=vel>0;
    zero_indices=[0 (find((start_end_dist_vec==0))) numel(start_end_dist_vec)+1];
    
    dist_away=[];
    for t=1:length(zero_indices)-1 % t is index in zero indices. start would be t+1
        dist_away=[dist_away sum(vel(zero_indices(t)+1:zero_indices(t+1)-1))]; %cumsum the distance between points increasing away from first index of epoch
    end
    st_temp=find(dist_away==max(dist_away));
    endpoint=zero_indices(st_temp+1); %endpoint=zero_indices(st_temp+1)-1; %
    
    %to find startpoint: calculate distance away from endpoint
    for z = 1:1:endpoint
        twopoint_dist_to_endpoint(z) = sqrt((newx(z)-newx(endpoint))*(newx(z)-newx(endpoint))+(newy(z)-newy(endpoint))*(newy(z)-newy(endpoint)));
    end
    
    % now look for consecutive points when distance is decreasing/toward endpoint
    vel_to_endpoint=diff(twopoint_dist_to_endpoint); %find distance between two consecutive points
    start_endpoint_dist_vec=vel_to_endpoint<0;
    zero_indices=[];
    zero_indices=[0 (find((start_endpoint_dist_vec==0))) numel(start_endpoint_dist_vec)+1];
    startpoint=zero_indices(end-1)+1;
    raw_startpoint = startpoint*2 + indexON(1)-1;
    raw_endpoint = endpoint*2 + indexON(1)-1;
end

%% %%%%%%%%%%%%%%%%% potential plots below, and final 'end' %%%%%%%%%%%%%%%%%%%%%
% figure(10)
% x1=newx(1:startpoint);
% y1=newy(1:startpoint);
% plot(x1,y1,'r')
% xlim([-17 17])
% ylim([-17 17])
% hold on
% % pause
% 
% x_plus = newx(startpoint:endpoint);
% y_plus = newy(startpoint:endpoint);
% plot(x_plus,y_plus,'b')
% hold on
% 
% x_end = newx(endpoint:end);      %yeye
% y_end = newy(endpoint:end);
% plot(x_end,y_end,'k')
% legend('latency smoothed','saccade smoothed','until end trial? smoothed')
% hold off
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% figure(11)
% xraw=x(1:raw_startpoint);
% yraw=y(1:raw_startpoint);
% plot(xraw,yraw,'r')
% xlim([-17 17])
% ylim([-17 17])
% ntr
% hold on
% % pause
% 
% x_plus = x(raw_startpoint:raw_endpoint);
% y_plus = y(raw_startpoint:raw_endpoint);
% plot(x_plus,y_plus,'b')
% hold on
% pause
% 
% x_end = x(raw_endpoint:end);      %yeye
% y_end = y(raw_endpoint:end);
% plot(x_end,y_end,'r')
% legend('latency smoothed','saccade smoothed','until end trial? smoothed')
% pause
% hold off
%
end