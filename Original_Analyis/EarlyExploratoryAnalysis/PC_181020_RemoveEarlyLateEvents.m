%Renames first 2 and last event of each trial to not be included in the
%analysis

STUDY = []; CURRENTSTUDY = 0; ALLEEG = []; EEG=[]; CURRENTSET=[]; % clears the dataset

loadpath = 'H:\Data\AV_TapNoTap\01_Import_Resamp\';
savepath = 'H:\Data\AV_TapNoTap\01_Import_Resamp\';

allFiles = dir([loadpath,'*.set']);
for j = 1:length(allFiles)
    
    loadFile = allFiles(j).name;
    savename = loadFile(1:end-4);
    
    EEG = pop_loadset('filename',loadFile,'filepath',loadpath);
    EEG = eeg_checkset( EEG );

    n_events = length(EEG.event);
    eeglab redraw
    for n = 1:length(EEG.event)
       if strcmpi(EEG.event(n).type,'10') || strcmpi(EEG.event(n).type,'20')

           if strcmpi(EEG.event(n-40).type,'1') && strcmpi(EEG.event(n-1).type,'1')
               EEG.event(n-40).type = '11';
               EEG.event(n-39).type = '11';
               EEG.event(n-1).type = '11';
           
           elseif strcmpi(EEG.event(n-40).type,'2') && strcmpi(EEG.event(n-1).type,'2')
               EEG.event(n-40).type = '22';
               EEG.event(n-39).type = '22';
               EEG.event(n-1).type = '22';
           
           elseif strcmpi(EEG.event(n-40).type,'3') && strcmpi(EEG.event(n-1).type,'3')
               EEG.event(n-40).type = '33';
               EEG.event(n-39).type = '33';
               EEG.event(n-1).type = '33';
    
           elseif strcmpi(EEG.event(n-40).type,'4') && strcmpi(EEG.event(n-1).type,'4')
               EEG.event(n-40).type = '44';
               EEG.event(n-39).type = '44';
               EEG.event(n-1).type = '44';
               
           end
       end
    end
    
    EEG = eeg_checkset(EEG, 'eventconsistency');
    eeglab redraw
    
    EEG = pop_saveset( EEG, 'filename',savename,'filepath',savepath);
    STUDY = []; CURRENTSTUDY = 0; ALLEEG = []; EEG=[]; CURRENTSET=[]; % clears the dataset
end
    eeglab redraw