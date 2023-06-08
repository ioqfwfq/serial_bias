function [delaydur] = Find_delay_ODR(Excel_neurons,sheetname)
[~, file_txt] = xlsread([Excel_neurons '.xlsx'],sheetname);
files = file_txt(:,1);
delaydur(1:length(files),1:1)=NaN;
for i = 1:length(files)
    load([files{i}([1:6]) '_1.mat']);
    delaydur(i) = AllData.parameters.delayDuration;
end
