%% Epochs data based on condition. Each epoch consists of one entire stimulus train

% clears any loaded dataset or study
STUDY = []; CURRENTSTUDY = 0; ALLEEG = []; EEG=[]; CURRENTSET=[]; 

% File paths
loadpath = '/Users/danielcomstock/Documents/Data/AV_TapNoTap/Data/05_AMICA_DipFit/';
savepath = '/Users/danielcomstock/Documents/Data/AV_TapNoTap/Data/06b_EpochIndvStims/';

epoch = ["1","2","3","4"]; % array of condition names
conditionName = ["Vis_Con","Vis_Tap","Aud_Con","Aud_Tap"];
numC = length(epoch); %Nc - Number of conditions;'

% saves the names of all of the files in the load path that end with .set
allFiles = dir([loadpath,'*.set']);


for fileIDX = 1:length(allFiles)
    % Stores the name of of the file in allFiles at index j into loadFile
    loadFile = allFiles(fileIDX).name;
    epochname = loadFile(1:end-4); % name used to save epoched dataset
    EEG1 = pop_loadset('filename',loadFile,'filepath',loadpath); % Load PreEpoch dateset
    [ALLEEG EEG1 CURRENTSET] = eeg_store(ALLEEG, EEG1); % copy it to ALLEEG
    EEG1 = eeg_checkset( EEG1 );
    
    % Update the event markers for each stimulus train. Marks the end events of each stimulas train as 'boundary' events.
    % This is done as when epoching, any epochs that contain 'boundary'
    % events are automatically removed.
    n_events = length(EEG1.event);
    for eventIDX = 1:n_events
        if eventIDX == 1
            EEG1.event(eventIDX).type = 'boundary';
        elseif eventIDX == n_events
            EEG1.event(eventIDX).type = 'boundary';           
        elseif EEG1.event(eventIDX-1).latency < EEG1.event(eventIDX).latency - EEG1.srate
            EEG1.event(eventIDX+1).type = 'boundary';
            EEG1.event(eventIDX).type = 'boundary';
        elseif EEG1.event(eventIDX+1).latency > EEG1.event(eventIDX).latency + EEG1.srate
            EEG1.event(eventIDX).type = 'boundary';
        end

    end
    
    % Epoch data sets
    
    for condIDX = 1:numC

        
        EEG2 = pop_epoch( EEG1, {  char(epoch(condIDX))  }, [-1.5 1.5 ], 'newname',[epochname char(conditionName(condIDX))], 'epochinfo', 'yes'); % epoch dataset and name
        EEG2 = eeg_checkset( EEG2 );
        
        EEG2 = pop_eegthresh(EEG2,1,[1:EEG2.nbchan] ,-500,500,-02,1.9961,0,0); % reject any epoch beyond +/-500uv
        EEG2 = eeg_checkset( EEG2 );
        EEG2 = pop_jointprob(EEG2,1,[1:EEG2.nbchan] ,6,2,1,0); % reject any epoch > 6 st.dev and any channel > 2 st.dev
        EEG2 = eeg_checkset( EEG2 );

        
        % gets numbers in dataName to use as subject # for building studies 
        % Example: 'AV_Omit12_Epoch_Flash' returns '12' 
        subNum = char(regexp(loadFile, '\d*','match'));
        if length(subNum) == 1
            subNum = ['0' subNum];
        end
        EEG2.subject = subNum;
        clear subNum
        % Enter EEG.condition. Gets condtion name for studies and replaces _ with spaces
        EEG2.condition = strrep(char(conditionName(condIDX)), '_', ' ');

        pop_saveset(EEG2,'filename',[epochname char(conditionName(condIDX)) '.set'], 'filepath',savepath);
        EEG2=[]; % clears the dataset
        
    end
    STUDY = []; CURRENTSTUDY = 0; ALLEEG = []; EEG=[]; CURRENTSET=[]; % clears the dataset
end
            
        
