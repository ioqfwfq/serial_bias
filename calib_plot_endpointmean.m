function [f, xmean, ymean] = calib_plot_endpointmean(filename)
load(filename)
volt = 3.5;
cl = linspace(1,10,9);
Y=cell(9,1);
X=cell(9,1);
f = figure;
for i = 1:length(AllData.block)
    for j = 1:length(AllData.block(i).trial)
        for k = 1:length(AllData.block(i).trial(j).repeat)
            try
                if AllData.block(i).trial(j).repeat(k).Reward(1) == 'Y'
                    y = -volt*mean(AllData.block(i).trial(j).repeat(k).EyeData(end-800:end,1));
                    x = volt*mean(AllData.block(i).trial(j).repeat(k).EyeData(end-800:end,2));
                    scatter(x,y,10,cl(AllData.block(i).trial(j).repeat(1).degree/45))
                    Y(AllData.block(i).trial(j).repeat(1).degree/45) = {[Y{AllData.block(i).trial(j).repeat(1).degree/45} y]};
                    X(AllData.block(i).trial(j).repeat(1).degree/45) = {[X{AllData.block(i).trial(j).repeat(1).degree/45} x]};
                    hold on
                end
            catch
            end
        end
    end
end
for n = 1:length(X)
    xmean(n) = mean(X{n});
    ymean(n) = mean(Y{n});
end
scatter(xmean,ymean,500,cl,'.')
xtar = [10/(2^0.5) 0 -10/(2^0.5) -10 -10/(2^0.5) 0 10/(2^0.5) 10 0];
ytar = [10/(2^0.5) 10 10/(2^0.5) 0 -10/(2^0.5) -10 -10/(2^0.5) 0 0];
scatter(xtar,ytar,200,cl,'x',linewidth=2)
hold off
xlim([-15 15])
ylim([-15 15])
title(filename)

