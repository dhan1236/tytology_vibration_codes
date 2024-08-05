clear all;
files = dir('*.ABI.mat');
% load the files one by one
data = {};
dataNotes = {};
for file_num = 1:length(files)
   load(files(file_num).name);
   %find frequency of stim
   freqIndex = find ([curvesettings.stimcache.Freq{:}]~=-99999,1);
   freq = [curvesettings.stimcache.Freq{freqIndex}];
   %get length(data) from last time
   dataLengthOrig = length(data);
   %put stim frequency in 2nd row, file of origin in 3rd row
   [dataNotes{2,dataLengthOrig+1:dataLengthOrig+curvesettings.stimcache.nstims}] = deal(freq);
   [dataNotes{3,dataLengthOrig+1:dataLengthOrig+curvesettings.stimcache.nstims}] = deal(files(file_num).name);

   for row = 1:size(curveresp,1)
        for column = 1:size(curveresp,2)
        %populate 1st row with curve data
        data {1, dataLengthOrig+column+(row-1)*size(curveresp,2)} = curveresp{row, column};
        %populate 2nd row with amplitude data
        dataNotes {1, dataLengthOrig+column+(row-1)*size(curveresp,2)} = curvedata.depvars_sort(row,column,1);
        end
   end
   %save filtered data and overwrite original
   clearvars -except files data dataNotes;
end
save data.mat
%save data.mat;
clearvars;