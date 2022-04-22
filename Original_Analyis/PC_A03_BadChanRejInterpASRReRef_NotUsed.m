%% Pre-process data up to epoching

%This script filters out everything below 2Hz.



%% Fileset variables
% clears any loaded dataset or study
STUDY = []; CURRENTSTUDY = 0; ALLEEG = []; EEG=[]; CURRENTSET=[]; 

% File paths
loadpath = 'H:\Data\AV_TapNoTap\02_FilterAutoPrune\';
savepath = 'H:\Data\AV_TapNoTap\03_BadChanRejInterpASRReRef\';


% saves the names of all of the files in the load path that end with .cnt
allFiles = dir([loadpath,'*.set']);

%% Loop to load all of the files and preproces them.
for j = 1:length(allFiles)
    
    % Stores the name of of the file in allFiles at index j into loadFile
    loadFile = allFiles(j).name;
    % removes the last 4 characters from loadFile to use as the savename
    savename = loadFile(1:end-4);
    
    % load file name
    EEG = pop_loadset('filename',loadFile,'filepath',loadpath);
    % Checks for dataset consistancy
    EEG = eeg_checkset( EEG );
    
    % Keep original EEG for channel locations needed for interpolation
    EEG.originalchanlocs = EEG.chanlocs;
    
    % remove bad channels using cleanrawdata. Note: no ASR used at this time. 
    EEG = clean_artifacts(EEG, 'FlatlineCriterion',5,'ChannelCriterion',0.85,'LineNoiseCriterion',4,'Highpass','off','BurstCriterion','off','WindowCriterion','off');
    EEG = eeg_checkset( EEG );
    % remove bad channels using trim outlier for channels with activity of
    % 15 sd or higher
    EEG = trimOutlier(EEG, -Inf, 15, Inf, 0);
    
    % Interpolate channels.
    EEG = pop_interp(EEG, EEG.originalchanlocs, 'spherical');
    EEG = eeg_checkset( EEG );
    
    % Apply average reference after adding initial reference. Removes reference
    % channel after completion
    EEG.nbchan = EEG.nbchan+1;
    EEG.data(end+1,:) = zeros(1, EEG.pnts);
    EEG.chanlocs(1,EEG.nbchan).labels = 'initialReference';
    EEG = pop_reref(EEG, []);
    EEG = pop_select( EEG,'nochannel',{'initialReference'});
    EEG = eeg_checkset( EEG );
    
%     % Run Clean Raw data. Note ASR correction is on with SD of 50. No Block
%     % rejection, no channel rejection
%     EEG = clean_artifacts(EEG, 'FlatlineCriterion','off','ChannelCriterion','off','LineNoiseCriterion','off','Highpass','off','BurstCriterion',50,'WindowCriterion','off','BurstRejection','off' );
%     EEG = eeg_checkset( EEG );
%     
%     % Apply average reference after adding initial reference. Removes reference
%     % channel after completion
%     EEG.nbchan = EEG.nbchan+1;
%     EEG.data(end+1,:) = zeros(1, EEG.pnts);
%     EEG.chanlocs(1,EEG.nbchan).labels = 'initialReference';
%     EEG = pop_reref(EEG, []);
%     EEG = pop_select( EEG,'nochannel',{'initialReference'});
%     EEG = eeg_checkset( EEG );
    
    % sets the dataset name to savename
    EEG.setname=savename;
    % Saves the dataset 
    EEG = pop_saveset( EEG, 'filename',savename,'filepath',savepath);
    
    STUDY = []; CURRENTSTUDY = 0; ALLEEG = []; EEG=[]; CURRENTSET=[]; % clears the dataset
end
    eeglab redraw