% Imports raw ANT data files into EEGLAB format, downsamples, and adds
% channel location data.

STUDY = []; CURRENTSTUDY = 0; ALLEEG = []; EEG=[]; CURRENTSET=[]; % clears the dataset


loadpath = 'H:\Data\AV_TapNoTap\00_Raws\';
savepath = 'H:\Data\AV_TapNoTap\01_Import_Resamp_ChanLocs\';

allFiles = dir([loadpath,'*.cnt']);
for j = 1:length(allFiles)
    %% Load files
    loadFile = allFiles(j).name;
    loadName = [loadpath loadFile];
    savename = loadFile(1:end-4);
    
    [EEG] = pop_loadeep_v4(loadName);
    EEG = eeg_checkset( EEG );

    
    %% Resample & Add channel Locations
    %Resample to 256 Hz
    EEG = pop_resample( EEG, 256);
    EEG = eeg_checkset( EEG );
    
    %Import channel locations
    EEG = pop_chanedit(EEG, 'load',{'H:\Data\3DOnlyWaveguard32.elc' 'filetype' 'autodetect'},'eval','chans = pop_chancenter( chans, [],[]);');
    
    %% Remove extra event codes
    
    events2RemoveIDX = [];
    length(EEG.event);
    for eventIDX = 1:length(EEG.event)
        if ~strcmpi(EEG.event(eventIDX).type,'1')...
                && ~strcmpi(EEG.event(eventIDX).type,'2')...
                && ~strcmpi(EEG.event(eventIDX).type,'3')...
                && ~strcmpi(EEG.event(eventIDX).type,'4')...
           events2RemoveIDX = [events2RemoveIDX eventIDX];
        end
    end
    
    EEG=pop_editeventvals(EEG,'delete',events2RemoveIDX);
    EEG = eeg_checkset( EEG );
    %%
    EEG.setname=savename;
    EEG = pop_saveset( EEG, 'filename',savename,'filepath',savepath);
    STUDY = []; CURRENTSTUDY = 0; ALLEEG = []; EEG=[]; CURRENTSET=[]; % clears the dataset
end
    eeglab redraw