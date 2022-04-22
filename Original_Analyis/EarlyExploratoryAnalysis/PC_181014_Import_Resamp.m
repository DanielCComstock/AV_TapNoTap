

STUDY = []; CURRENTSTUDY = 0; ALLEEG = []; EEG=[]; CURRENTSET=[]; % clears the dataset

loadpath = 'H:\Data\AV_TapNoTap\00_Raws\';
savepath = 'H:\Data\AV_TapNoTap\01_Import_Resamp\';

allFiles = dir([loadpath,'*.cnt']);
for j = 1:length(allFiles)
    
    loadFile = allFiles(j).name;
    loadName = [loadpath loadFile];
    savename = [loadFile(1:end-4) '_ReSamp256Hz'];
    
    [EEG] = pop_loadeep_v4(loadName);
    EEG = eeg_checkset( EEG );
    eeglab redraw;
    
    EEG.setname=savename;
    EEG = eeg_checkset( EEG );
    eeglab redraw;
    
    %Resample to 256 Hz
    EEG = pop_resample( EEG, 256);
    EEG = eeg_checkset( EEG );
    
    %Import channel locations
    EEG = pop_chanedit(EEG, 'load',{'H:\Data\3DOnlyWaveguard32.elc' 'filetype' 'autodetect'},'eval','chans = pop_chancenter( chans, [],[]);');
    
    EEG = pop_saveset( EEG, 'filename',savename,'filepath',savepath);
    STUDY = []; CURRENTSTUDY = 0; ALLEEG = []; EEG=[]; CURRENTSET=[]; % clears the dataset
end
    eeglab redraw