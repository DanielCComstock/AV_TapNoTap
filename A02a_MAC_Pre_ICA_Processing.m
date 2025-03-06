% Auto prunes the ends of the data set, and sections of the dataset between
% stimulus trains. Also removes event codes for task response answers.

% clears any loaded dataset or study
STUDY = []; CURRENTSTUDY = 0; ALLEEG = []; EEG=[]; CURRENTSET=[]; 

% File paths 
loadpath = '/Users/dccomsto/Projekts/AV_TapNoTap/Data/Revision1_Analysis/01_Import_Resamp_ChanLocs/';
savepath = '/Users/dccomsto/Projekts/AV_TapNoTap/Data/Revision1_Analysis/02_Pre_ICA_Processing/';
chanrejpath = '/Users/dccomsto/Projekts/AV_TapNoTap/Data/Original_Analysis/03_BadChanRej/';

% saves the names of all of the files in the load path that end with .set
allFiles = dir([loadpath,'*.set']);

% Loop to load all of the files and preproces them.
for fileIDX = 1:length(allFiles)
    
    % Stores the name of of the file in allFiles at index j into loadFile
    loadFile = allFiles(fileIDX).name;
    % removes the last 4 characters from loadFile to use as the savename
    savename = loadFile(1:end-4);
    
    %% Get bad Channel information from previous preproc
    
    % load dataset containing channel reject information
    % load file name
    EEG = pop_loadset('filename',loadFile,'filepath',chanrejpath);
    % Checks for dataset consistancy
    EEG = eeg_checkset( EEG );

    if EEG.nbchan < 32
        rej = 1;
        % extract bad channels to later remove
        for removedChanIDX = 1:length(EEG.chaninfo.removedchans)
            rejectChannels(removedChanIDX) = {EEG.chaninfo.removedchans(removedChanIDX).labels};
        end
    else
        rej = 0;
    end

    STUDY = []; CURRENTSTUDY = 0; ALLEEG = []; EEG=[]; CURRENTSET=[]; % clears the dataset

    %% load file to preproc
    % load file name
    EEG = pop_loadset('filename',loadFile,'filepath',loadpath);
    % Checks for dataset consistancy
    EEG = eeg_checkset( EEG );

    %% Reject bad channels

    % Keep original EEG for channel locations needed for interpolation
    EEG.originalchanlocs = EEG.chanlocs;


    if rej == 1
        % Select channels for rejection
        EEG = pop_select( EEG, 'nochannel',rejectChannels);
        EEG = eeg_checkset( EEG );
    end

    clear rejectChannels rej
    
    %% Filter
   
    % 1 Hz High Pass Filter
    EEG = pop_eegfiltnew(EEG, 'locutoff',1);
    EEG = eeg_checkset( EEG );


    % 40 Hz Low Pass Filter
    EEG = pop_eegfiltnew(EEG, 'hicutoff',40);
    EEG = eeg_checkset( EEG );
    
       
    %% AutoPrune
   
    rejIndex = 0;
    numRejects = 0;
    n_events = length(EEG.event);
    
    % Remove section of data from start to first event.
    firstEventlat = EEG.event(1).latency-EEG.srate*10; % remove all data up until 10 seconds before 1st event.
    firstSamplepoint = 1;
    numRejects = numRejects+1;
    rejIndex(numRejects, 1) = round(firstSamplepoint);
    rejIndex(numRejects, 2) = round(firstEventlat);
    
    % Remove sections of Data between Stimulus Trains
    for n = 1:length(EEG.event)-1               
       % Find events that are the edges of stim trains
       if EEG.event(n+1).latency > EEG.event(n).latency+2*EEG.srate
               firstLat = EEG.event(n).latency+EEG.srate*1;% 1 seconds after the first event 
               secondLat = EEG.event(n+1).latency-EEG.srate*10;% 10 seconds before the second event.
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
    
    %% Interpolate ReRef & ASR

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
    
    % Run Clean Raw data. Note ASR correction is on with SD of 20. No Block
    % rejection, no channel rejection
    EEG = clean_artifacts(EEG, 'FlatlineCriterion','off','ChannelCriterion','off','LineNoiseCriterion','off','Highpass','off','BurstCriterion',20,'WindowCriterion','off','BurstRejection','off' );
    EEG = eeg_checkset( EEG );
    
    % Apply average reference after adding initial reference. Removes reference
    % channel after completion
    EEG.nbchan = EEG.nbchan+1;
    EEG.data(end+1,:) = zeros(1, EEG.pnts);
    EEG.chanlocs(1,EEG.nbchan).labels = 'initialReference';
    EEG = pop_reref(EEG, []);
    EEG = pop_select( EEG,'nochannel',{'initialReference'});
    EEG = eeg_checkset( EEG );
    
    
    % sets the dataset name to savename
    EEG.setname=savename;
    % Saves the dataset 
    EEG = pop_saveset( EEG, 'filename',savename,'filepath',savepath);
    
    STUDY = []; CURRENTSTUDY = 0; ALLEEG = []; EEG=[]; CURRENTSET=[]; % clears the dataset
end

    
               
               