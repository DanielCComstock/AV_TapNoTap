% Auto prunes the ends of the data set, and sections of the dataset between
% stimulus trains. Also removes event codes for task response answers.

% clears any loaded dataset or study
STUDY = []; CURRENTSTUDY = 0; ALLEEG = []; EEG=[]; CURRENTSET=[]; 

% File paths
loadpath = 'H:\Data\AV_TapNoTap\01_Import_Resamp_ChanLocs\';
savepath = 'H:\Data\AV_TapNoTap\02_FilterAutoPrune\';

% saves the names of all of the files in the load path that end with .cnt
allFiles = dir([loadpath,'*.set']);

% Loop to load all of the files and preproces them.
for fileIDX = 1:length(allFiles)
    
    % Stores the name of of the file in allFiles at index j into loadFile
    loadFile = allFiles(fileIDX).name;
    % removes the last 4 characters from loadFile to use as the savename
    savename = loadFile(1:end-4);
    
    % load file name
    EEG = pop_loadset('filename',loadFile,'filepath',loadpath);
    % Checks for dataset consistancy
    EEG = eeg_checkset( EEG );
    
   %% Filter
   
    % 1 Hz High Pass Filter
    EEG = pop_eegfiltnew(EEG, 'locutoff',1);
    EEG = eeg_checkset( EEG );
%    High pass Filter Readout
%     pop_eegfiltnew() - performing 847 point highpass filtering.
%     pop_eegfiltnew() - transition band width: 1 Hz
%     pop_eegfiltnew() - passband edge(s): 1 Hz
%     pop_eegfiltnew() - cutoff frequency(ies) (-6 dB): 0.5 Hz
%     pop_eegfiltnew() - filtering the data (zero-phase, non-causal)

    % 40 Hz Low Pass Filter
    EEG = pop_eegfiltnew(EEG, 'hicutoff',40);
    EEG = eeg_checkset( EEG );
%    Low Pass Filter Readout
%     pop_eegfiltnew() - performing 87 point lowpass filtering.
%     pop_eegfiltnew() - transition band width: 10 Hz
%     pop_eegfiltnew() - passband edge(s): 40 Hz
%     pop_eegfiltnew() - cutoff frequency(ies) (-6 dB): 45 Hz
%     pop_eegfiltnew() - filtering the data (zero-phase, non-causal)

    
       
    %% AutoPrune
   
    rejIndex = 0;
    numRejects = 0;
    n_events = length(EEG.event);
    
    % Remove section of data from start to first event.
    firstEventlat = EEG.event(1).latency-EEG.srate*3;
    firstSamplepoint = 1;
    numRejects = numRejects+1;
    rejIndex(numRejects, 1) = round(firstSamplepoint);
    rejIndex(numRejects, 2) = round(firstEventlat);
    
    % Remove sections of Data between Stimulus Trains
    for n = 1:length(EEG.event)-1               
       % Find events that are the edges of stim trains
       if EEG.event(n+1).latency > EEG.event(n).latency+2*EEG.srate
               firstLat = EEG.event(n).latency+EEG.srate*2;% 2 seconds after the first event 
               secondLat = EEG.event(n+1).latency-EEG.srate*2;% 2 seconds before the second event.
               % records the number for the section to be rejected, and
               % puts the sample points into the reject index for a row
               % corresponding to numRejects. 
               % are used for indexing.
               numRejects = numRejects+1;
               rejIndex(numRejects, 1) = round(firstLat);
               rejIndex(numRejects, 2) = round(secondLat);

       end
    end
    
    % Remove section of data from last event to the end of the data set.
    lastEventlat = EEG.event(end).latency+EEG.srate*3;
    lastSamplepoint = length(EEG.times);
    numRejects = numRejects+1;
    rejIndex(numRejects, 1) = round(lastEventlat);
    rejIndex(numRejects, 2) = round(lastSamplepoint);
    
    % rejects the indicated sections
    EEG = eeg_eegrej( EEG, rejIndex );
    EEG = eeg_checkset( EEG );
    
    % Keep original EEG for channel locations needed for interpolation
    EEG.originalchanlocs = EEG.chanlocs;
    
    % Saves the dataset 
    EEG = pop_saveset( EEG, 'filename',savename,'filepath',savepath);
    
    STUDY = []; CURRENTSTUDY = 0; ALLEEG = []; EEG=[]; CURRENTSET=[]; % clears the dataset

end
    
               
               