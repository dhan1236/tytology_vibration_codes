clear all;
load('data.mat');

%% delete over 100 dB, comment if unnecessary
deleCell = find (cell2mat(dataNotes(1,:)) > 81);
dataNotes(:, deleCell) = [];
data(:, deleCell) = [];
save data.mat;
%% toggle on off whether to flip data.mat
data = gnegate(data);

%%
Fs = 48828.125; 
spikes = ss_default_params(Fs);
spikes = ss_detect(data,spikes);
spikes = ss_align(spikes);
spikes = ss_kmeans(spikes);
spikes = ss_energy(spikes);
spikes = ss_aggregate(spikes);
splitmerge_tool(spikes)