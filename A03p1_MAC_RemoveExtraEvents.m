%% Remove 4th Aud Con stimulus train from subjects 1 - 9.
% This is due to the events from the 4th Aud tap stimulus train not
% being recorded[
%% Even out the number of events for subs 1-9 where the last 40 Aud tap events were not recorded
% This makes the number of events even across all conditions at 120
% clears any loaded dataset or study
STUDY = []; CURRENTSTUDY = 0; ALLEEG = []; EEG=[]; CURRENTSET=[]; 

% File paths
loadpath = '/Users/dccomsto/Projekts/AV_TapNoTap/Data/Revision1_Analysis/03_AMICA_DipFit/02_ComponentInfoAdded/';
savepath = '/Users/dccomsto/Projekts/AV_TapNoTap/Data/Revision1_Analysis/03_AMICA_DipFit/03_EventsUpdated/';

for fileIDX = 1:9

    loadFile = ['AVTapNoTap' num2str(fileIDX) '.set'];
    savename = loadFile(1:end-4);
    
    % load file name
    EEG = pop_loadset('filename',loadFile,'filepath',loadpath);
    % Checks for dataset consistancy
    EEG = eeg_checkset( EEG );
    
    %% select and remove events
    
    %loop to find events and mark excess events
    oneCount = 0;
    twoCount = 0;
    threeCount = 0;
    for eventIDX = 1:length(EEG.event)
        if strcmpi(EEG.event(eventIDX).type,'1') && oneCount >= 120
            EEG.event(eventIDX).type = '11';

        elseif strcmpi(EEG.event(eventIDX).type,'2') && twoCount >= 120
            EEG.event(eventIDX).type = '22';

        elseif strcmpi(EEG.event(eventIDX).type,'3') && threeCount >= 120
            EEG.event(eventIDX).type = '33';
            
        elseif strcmpi(EEG.event(eventIDX).type,'1')
             oneCount = oneCount +1;
         
        elseif strcmpi(EEG.event(eventIDX).type,'2')
             twoCount = twoCount +1;

        elseif strcmpi(EEG.event(eventIDX).type,'3')
             threeCount = threeCount +1;

        end
    end
             
    
    EEG = eeg_checkset( EEG );
    
    pop_saveset(EEG,'filename',savename, 'filepath',savepath);
    
    STUDY = []; CURRENTSTUDY = 0; ALLEEG = []; EEG=[]; CURRENTSET=[]; % clears the dataset
end

eeglab redraw;
    
    
    
    
    
