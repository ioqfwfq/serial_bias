function [x, y] = output_xy_calib(fn)

[~, class_indices, x_endpoints, y_endpoints, ~ ] = proSaccade_correcttrial(fn);


for j = 0:8 %% 9 locations in auto-cali files
    count = 1;
    for i = 1:length(class_indices)
        if class_indices(i) == j
            x_all(count,(j+1)) = x_endpoints(i);
            y_all(count,(j+1)) = y_endpoints(i);
            count = count + 1;
        end
    end
end

for i = 1:9
    x_pool = [];
    y_pool = [];
    for j = 1:length(x_all(:,i))
        if isnan(x_all(j,i)) | x_all(j,i) == 0
            x_pool = [x_pool NaN];
            y_pool = [y_pool NaN];
        else
            x_pool = [x_pool x_all(j,i)];
            y_pool = [y_pool y_all(j,i)];
        end
    end
    x(i) = nanmean(x_pool);
    y(i) = nanmean(y_pool);
end
result = [x',y'];
end