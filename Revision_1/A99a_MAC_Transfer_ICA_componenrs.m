% clears any loaded dataset or study
STUDY = []; CURRENTSTUDY = 0; ALLEEG = []; EEG=[]; CURRENTSET=[]; 

% File paths 
loadpath = '/Users/dccomsto/Projekts/AV_TapNoTap/Data/Revision1_Analysis/02_Pre_ICA_Processing/NewBackup/';
savepath = '/Users/dccomsto/Projekts/AV_TapNoTap/Data/Revision1_Analysis/02_Pre_ICA_Processing/';
ICApath = '/Users/dccomsto/Projekts/AV_TapNoTap/Data/Revision1_Analysis/03_AMICA_DipFit/03_EventsUpdated/';

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
    EEG = pop_loadset('filename',loadFile,'filepath',ICApath);
    % Checks for dataset consistancy
    EEG = eeg_checkset( EEG );

    icawinv = EEG.icawinv;
    icasphere = EEG.icasphere;
    icaweights = EEG.icaweights;
    icachansind = EEG.icachansind;
    reject = EEG.reject;
    dipfit = EEG.dipfit;
    etc = EEG.etc;
    mu = EEG.mu;

    STUDY = []; CURRENTSTUDY = 0; ALLEEG = []; EEG=[]; CURRENTSET=[]; % clears the dataset

    % Stores the name of of the file in allFiles at index j into loadFile
    loadFile = allFiles(fileIDX).name;
    % removes the last 4 characters from loadFile to use as the savename
    savename = loadFile(1:end-4);
    
    %% Get bad Channel information from previous preproc
    
    % load dataset containing channel reject information
    % load file name
    EEG = pop_loadset('filename',loadFile,'filepath',loadpath);
    % Checks for dataset consistancy
    EEG = eeg_checkset( EEG );

    EEG.icawinv = icawinv;
    EEG.icasphere = icasphere;
    EEG.icaweights = icaweights;
    EEG.icachansind = icachansind;
    EEG.reject = reject;
    EEG.dipfit = dipfit;
    EEG.etc = etc;
    EEG.mu = mu;

    EEG = eeg_checkset( EEG );

    % sets the dataset name to savename
    EEG.setname=savename;
    % Saves the dataset 
    EEG = pop_saveset( EEG, 'filename',savename,'filepath',savepath);
    
    STUDY = []; CURRENTSTUDY = 0; ALLEEG = []; EEG=[]; CURRENTSET=[]; % clears the dataset
end



