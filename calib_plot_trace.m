load('UNIeyeCirc10_lab2_20210803.mat')
n = 0;
cl = {[0.83 0.14 0.14],
      [1.00 0.54 0.00],
      [0.47 0.25 0.80],
      [0.25 0.80 0.54],
      [0.7 0.7 0.7],
      [0.3010 0.7450 0.9330],
      [0.4660 0.6740 0.1880],
      [0.9290 0.6940 0.1250],
      [0 0.4470 0.7410]};
for i = 2:length(AllData.block)
    for j = 1:length(AllData.block(i).trial)
        try
            if AllData.block(i).trial(j).repeat(1).Reward(1) == 'Y'
            x = AllData.block(i).trial(j).repeat(1).EyeData(end-400:end,1);
            y = AllData.block(i).trial(j).repeat(1).EyeData(end-400:end,2);
            scatter(x,y,'MarkerFaceColor', cl{AllData.block(i).trial(j).repeat(1).degree/45},...
                'MarkerEdgeColor',cl{AllData.block(i).trial(j).repeat(1).degree/45})
            hold on
            end
        catch
        end
    end
end
hold off