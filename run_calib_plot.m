clearvars
[file,path] = uigetfile('*.mat',...
   'Select One or More Files', ...
   'MultiSelect', 'on');
x = [];
y = [];
for nf = 1:length(file)
    [f(nf), x(nf,:), y(nf,:)] = calib_plot_endpointmean(file{nf});
end
