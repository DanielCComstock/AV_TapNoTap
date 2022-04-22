STUDY = []; CURRENTSTUDY = 0; ALLEEG = []; EEG=[]; CURRENTSET=[]; % clears the dataset

loadpath = 'H:\Data\AV_TapNoTap\01_Import_Resamp\';
savepath = 'H:\Data\AV_TapNoTap\02_2Hz40HzFilter\';

allFiles = dir([loadpath,'*.set']);
for j = 1:length(allFiles)
    
    loadFile = allFiles(j).name;
    savename = [loadFile(1:end-4) '_Filt2Hz40Hz'];
    
    EEG = pop_loadset('filename',loadFile,'filepath',loadpath);
    EEG = eeg_checkset( EEG );

    
    EEG.setname=savename;
    EEG = eeg_checkset( EEG );
    eeglab redraw;
    
    EEG = pop_eegfiltnew(EEG, [],2,424,1,[],0);
    EEG = eeg_checkset( EEG );
    EEG = pop_eegfiltnew(EEG, [],40,86,0,[],0);
    EEG = eeg_checkset( EEG );
    eeglab redraw;
    
    EEG = pop_saveset( EEG, 'filename',savename,'filepath',savepath);
    STUDY = []; CURRENTSTUDY = 0; ALLEEG = []; EEG=[]; CURRENTSET=[]; % clears the dataset
end
    eeglab redraw