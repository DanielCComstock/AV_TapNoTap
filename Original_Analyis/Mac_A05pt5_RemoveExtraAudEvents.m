%% Remove 4th Aud Con stimulus train from subjects 1 - 9.
% This is due to the events from the 4th Aud tap stimulus train not
% being recorded[

% clears any loaded dataset or study
STUDY = []; CURRENTSTUDY = 0; ALLEEG = []; EEG=[]; CURRENTSET=[]; 

% File paths
loadpath = '/Users/danielcomstock/Documents/Data/AV_TapNoTap/Data/05_AMICA_DipFit/';
savepath = '/Users/danielcomstock/Documents/Data/AV_TapNoTap/Data/05_AMICA_DipFit/';

for fileIDX = 1:9

    loadFile = ['AVTapNoTap' num2str(fileIDX) '.set'];
    savename = loadFile(1:end-4);
    
    % load file name
    EEG = pop_loadset('filename',loadFile,'filepath',loadpath);
    % Checks for dataset consistancy
    EEG = eeg_checkset( EEG );
    
    %% select and remove events
    
    %loop to find events and mark excess events
    threeCount =0;
    for eventIDX = 1:length(EEG.event)
        if strcmpi(EEG.event(eventIDX).type,'3') && threeCount >= 120
            EEG.event(eventIDX).type = '33';
            
        elseif strcmpi(EEG.event(eventIDX).type,'3')
             threeCount = threeCount +1;
        end
    end
             
    %remove marked events
    EEG = pop_selectevent( EEG, 'omittype',33,'deleteevents','on');
    
    EEG = eeg_checkset( EEG );
    
    pop_saveset(EEG,'filename',savename, 'filepath',loadpath);
    
    STUDY = []; CURRENTSTUDY = 0; ALLEEG = []; EEG=[]; CURRENTSET=[]; % clears the dataset
end

eeglab redraw;
    
    
    
    
    
