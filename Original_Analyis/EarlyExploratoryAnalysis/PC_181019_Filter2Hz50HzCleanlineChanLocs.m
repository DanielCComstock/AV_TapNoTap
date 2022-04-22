STUDY = []; CURRENTSTUDY = 0; ALLEEG = []; EEG=[]; CURRENTSET=[]; % clears the dataset

loadpath = 'H:\Data\AV_TapNoTap\01_Import_Resamp\';
savepath = 'H:\Data\AV_TapNoTap\02_2Hz50HzFilter\';

allFiles = dir([loadpath,'*.set']);
for j = 1:length(allFiles)
    
    loadFile = allFiles(j).name;
    savename = [loadFile(1:end-4) '_Filt2Hz50Hz'];
    
    EEG = pop_loadset('filename',loadFile,'filepath',loadpath);
    EEG = eeg_checkset( EEG );

    
    EEG.setname=savename;
    EEG = eeg_checkset( EEG ); 
    eeglab redraw;
    
    %add channel locations
    EEG = pop_chanedit(EEG, 'load',{'H:\\Data\\3DOnlyWaveguard32.elc' 'filetype' 'autodetect'},'eval','chans = pop_chancenter( chans, [],[]);');
    EEG = eeg_checkset( EEG );
    
    %2 Hz high pass filter
    EEG = pop_eegfiltnew(EEG, [],2,424,1,[],0);
    EEG = eeg_checkset( EEG );
    
    %50 Hz low pass filter
    EEG = pop_eegfiltnew(EEG, [],50,68,0,[],0);
    EEG = eeg_checkset( EEG );
    
    %Cleanline to remove any residual line noise
    EEG = pop_cleanline(EEG, 'bandwidth',2,'chanlist',[1:32] ,'computepower',0,'linefreqs',[60 120] ,'normSpectrum',0,'p',0.01,'pad',2,'plotfigures',0,'scanforlines',1,'sigtype','Channels','tau',100,'verb',1,'winsize',2,'winstep',2);
    EEG = eeg_checkset( EEG );
    eeglab redraw;
    
    EEG = pop_saveset( EEG, 'filename',savename,'filepath',savepath);
    STUDY = []; CURRENTSTUDY = 0; ALLEEG = []; EEG=[]; CURRENTSET=[]; % clears the dataset
end
    eeglab redraw