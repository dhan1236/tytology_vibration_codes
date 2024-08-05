% prepare data for mspike.m 
% load spikes.mat and data.mat, and save into csv
% first index each unit for processing
% in data.mat, from prep_UMS2K, dataNotes contains frequency(1st row),
% amplitude (2nd row),and trial number (column)
%in spikes.mat, spikes.trials correspond to trial number, spike.assigns
%corresponds to single unit number in the extracellular recording

% for unitN = 1: max(spikes.assigns)
%     mkdir (num2str(unitN));
% end
clear all;
load spikes.mat;
load data.mat;

prepCSV = cell(max(spikes.assigns),1);
% clear unitN;
%create folders for different units
freqArray = unique(cell2mat(dataNotes(2,:)));
%% Initialize a cell array to store the summary data
summaryData = cell(max(spikes.assigns), 1);
%%
    for freqN = freqArray
        indexFreq = find(cell2mat(dataNotes(2,:)) == freqN);
        %index the trial#s for each frequency
        intenArray = unique(cell2mat(dataNotes(1,indexFreq)));

        for intenN = intenArray
            index_indexInten = find(cell2mat(dataNotes(1,indexFreq)) ==intenN);
            indexIntenFreq = indexFreq(index_indexInten);
            %index the trial#s for each intensity within a frequency

            for trialN = indexIntenFreq
                indexSpike = find(spikes.trials == trialN);
            %indexSpike contains all the indexes of spikes for a given trial
            %this trial is trialN in data.mat
              if isempty (indexSpike) == 0
                for unitN = 1: max(spikes.assigns)
                    index_indexUnit = find (spikes.assigns(indexSpike) == unitN);
                    indexUnit = indexSpike(index_indexUnit);
                    %indexUnit is the index of all spikes belonging to
                    %unitN in spikes.mat in a given trial
                    spikeAnnote = size(prepCSV{unitN},1);
                    for spikeN = spikeAnnote+1:length(indexUnit)+spikeAnnote
                        prepCSV{unitN}(spikeN,1) = freqN;%1st column freq
                        prepCSV{unitN}(spikeN,2) = intenN;%2nd column intensity
                        prepCSV{unitN}(spikeN,3) = trialN;%3rd column trial#
                        prepCSV{unitN}(spikeN,4) = spikes.params.Fs;%4th column Fs
                        prepCSV{unitN}(spikeN,5) = spikes.spiketimes...
                            (indexUnit(spikeN-spikeAnnote));%5th column time of spike
                        prepCSV{unitN}(spikeN,6) = size(spikes.waveforms,2);%6th column spike length
                        prepCSV{unitN}(spikeN,7:size(spikes.waveforms,2)+6)...
                            = spikes.waveforms(indexUnit(spikeN-spikeAnnote),:);
                        %7th column-79th column spike waveforms
                    end
                end
              end
            end
        end
    end
    clearvars -except prepCSV; % free up workspace

    %% move data from prepCSV cell to csv
    for unitnum = 1:length(prepCSV)
        if isempty (prepCSV{unitnum,1}) == 0
            freqs = unique (prepCSV{unitnum,1}(:,1));
            unitSummary = [];%
            for freqnum = freqs'
                indexfreqs = find(prepCSV{unitnum,1}(:,1) == freqnum);%index frequencies
                intens = unique (prepCSV{unitnum,1}(indexfreqs,2));
                for intennum = intens'
                    index_indexintens = find (prepCSV{unitnum,1}(indexfreqs,2) == intennum);%index intensities
                    indexintens = indexfreqs(index_indexintens);

                    % Add the unitnum, freqnum, and intennum to the unit summary
                    unitSummary = [unitSummary; unitnum, freqnum, intennum];

                    tempmatrix = prepCSV{unitnum,1}(indexintens,:);
                    temptable = array2table(tempmatrix);
                    nametable = sprintf('unit%02d.%dHz.%ddB.csv', unitnum,freqnum,intennum);
                    writetable(temptable,nametable);
                    movefile ('*.csv', num2str(unitnum));
                end
            end
            fclose(fopen('InputFileList.txt', 'w'));
            fclose(fopen('FrequencyList.txt', 'w'));
            movefile ('*.txt', num2str(unitnum)); %make sure every folder has needed files
            % Save the unit summary to a .mat file
            unitSummaryFile = sprintf('summary.mat');
            save(fullfile(num2str(unitnum), unitSummaryFile), 'unitSummary');
            summaryData{unitnum} = unitSummary;
            mkdir MSPIKEoutputs;
            movefile ('MSPIKEoutputs', num2str(unitnum));                     
        end
    end


%% make sure spike counts correctly populate csv files
clear all;
load spikes.mat;
currentFolder = pwd;
for unitN = spikes.labels(:,1)'
    subfolder = fullfile(currentFolder,num2str(unitN));
    addpath (subfolder);
    csvFiles = dir(fullfile(subfolder, '*.csv'));
    % Initialize a variable to store the total row count
    totalRowCount = 0;

    % Loop through each CSV file and count its rows
    for i = 1:length(csvFiles)
        % Get the current CSV file's name
        currentFile = fullfile(subfolder, csvFiles(i).name);
        % Read the CSV file into a table or matrix (adjust as needed)
        % Here, we assume you have a header row; adjust the options accordingly
        data = readtable(currentFile); % For tables
        % data = csvread(currentFile); % For matrices
    
        % Count the rows in the current CSV file
        rowCount = size(data, 1);
        % Add the current row count to the total
        totalRowCount = totalRowCount + rowCount;
    end
    spikesCounts = length(find(spikes.assigns == unitN));
    if spikesCounts ~= totalRowCount
        fprintf('CSV not correct in %d\n', unitN);
    end
    rmpath(subfolder);
end
    clear all;
