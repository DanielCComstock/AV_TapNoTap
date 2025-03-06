%% Epochs data based on condition. Each epoch consists of one entire stimulus train

% clears any loaded dataset or study
STUDY = []; CURRENTSTUDY = 0; ALLEEG = []; EEG=[]; CURRENTSET=[]; 

% File paths
fullDataLoadPath = '/Users/dccomsto/Projekts/AV_TapNoTap/Data/Revision1_Analysis/03_AMICA_DipFit/03_EventsUpdated/';
leftMuLoadPath = '/Users/dccomsto/Projekts/AV_TapNoTap/Data/Revision1_Analysis/03_AMICA_DipFit/04a_Left_Motor/';
rightMuLoadPath = '/Users/dccomsto/Projekts/AV_TapNoTap/Data/Revision1_Analysis/03_AMICA_DipFit/04b_Right_Motor/';
stimTrainWithBaseline_savepath = '/Users/dccomsto/Projekts/AV_TapNoTap/Data/Revision1_Analysis/04d_Epoch_StimTrainsWBaseline/';


epoch_stimTrain = ["10","20","30","40"]; % array of event numbers to epoch 
epoch_baseline = ["15","25","35","45"];
epoch_indvidStims = ["1","2","3","4"];
conditionName = ["Vis_Con","Vis_Tap","Aud_Con","Aud_Tap"];
numC = length(epoch_stimTrain); %Nc - Number of conditions;'

% saves the names of all of the files in the load path that end with .set
allFiles = dir([leftMuLoadPath,'*.set']); % use leftMuPath as subject 3 is excluded already.


for fileIDX = 1:length(allFiles)
    % Stores the name of of the file in allFiles at index j into loadFile
    loadFile = allFiles(fileIDX).name;
    epochname = loadFile(1:end-4); % name used to save epoched dataset

    %% Load & Epoch for All Components
    EEG1 = pop_loadset('filename',loadFile,'filepath',fullDataLoadPath); % Load PreEpoch dateset
    [ALLEEG EEG1 CURRENTSET] = eeg_store(ALLEEG, EEG1); % copy it to ALLEEG
    EEG1 = eeg_checkset( EEG1 );
    
    % Update the event markers for each stimulus train. Marks the second
    % event of each stimulus train as the starting point for epoching.
    n_events = length(EEG1.event);
    for eventIDX = 1:n_events
        if strcmpi(EEG1.event(eventIDX).type,'1') && EEG1.event(eventIDX-1).latency < EEG1.event(eventIDX).latency - EEG1.srate
            EEG1.event(eventIDX+1).type = '10'; % second event of each stim train
            EEG1.event(eventIDX).type = '15'; % first event of each stim train (for baseline)
        elseif strcmpi(EEG1.event(eventIDX).type,'2') && EEG1.event(eventIDX-1).latency < EEG1.event(eventIDX).latency - EEG1.srate
            EEG1.event(eventIDX+1).type = '20';
            EEG1.event(eventIDX).type = '25';
        elseif strcmpi(EEG1.event(eventIDX).type,'3') && EEG1.event(eventIDX-1).latency < EEG1.event(eventIDX).latency - EEG1.srate
            EEG1.event(eventIDX+1).type = '30';
            EEG1.event(eventIDX).type = '35';
        elseif strcmpi(EEG1.event(eventIDX).type,'4') && EEG1.event(eventIDX-1).latency < EEG1.event(eventIDX).latency - EEG1.srate
            EEG1.event(eventIDX+1).type = '40';
            EEG1.event(eventIDX).type = '45';
        end
    end
    
    % Epoch Stim Trains with baseline (baseline = -5.6 to -.6 seconds)
    
    for condIDX = 1:numC

        
        EEG2 = pop_epoch( EEG1, {  char(epoch_stimTrain(condIDX))  }, [-5.6 22.8], 'newname',[epochname char(conditionName(condIDX))], 'epochinfo', 'yes'); % epoch dataset and name
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

        pop_saveset(EEG2,'filename',[epochname char(conditionName(condIDX)) '.set'], 'filepath',[stimTrainWithBaseline_savepath 'AllComps/']);
        EEG2=[]; % clears the dataset
        
    end

    STUDY = []; CURRENTSTUDY = 0; ALLEEG = []; EEG=[]; CURRENTSET=[]; % clears the dataset

    %% Load and Epoch for Left Mu only
    EEG1 = pop_loadset('filename',loadFile,'filepath',leftMuLoadPath); % Load PreEpoch dateset
    [ALLEEG EEG1 CURRENTSET] = eeg_store(ALLEEG, EEG1); % copy it to ALLEEG
    EEG1 = eeg_checkset( EEG1 );
    
    % Update the event markers for each stimulus train. Marks the second
    % event of each stimulus train as the starting point for epoching.
    n_events = length(EEG1.event);
    for eventIDX = 1:n_events
        if strcmpi(EEG1.event(eventIDX).type,'1') && EEG1.event(eventIDX-1).latency < EEG1.event(eventIDX).latency - EEG1.srate
            EEG1.event(eventIDX+1).type = '10'; % second event of each stim train
            EEG1.event(eventIDX).type = '15'; % first event of each stim train (for baseline)
        elseif strcmpi(EEG1.event(eventIDX).type,'2') && EEG1.event(eventIDX-1).latency < EEG1.event(eventIDX).latency - EEG1.srate
            EEG1.event(eventIDX+1).type = '20';
            EEG1.event(eventIDX).type = '25';
        elseif strcmpi(EEG1.event(eventIDX).type,'3') && EEG1.event(eventIDX-1).latency < EEG1.event(eventIDX).latency - EEG1.srate
            EEG1.event(eventIDX+1).type = '30';
            EEG1.event(eventIDX).type = '35';
        elseif strcmpi(EEG1.event(eventIDX).type,'4') && EEG1.event(eventIDX-1).latency < EEG1.event(eventIDX).latency - EEG1.srate
            EEG1.event(eventIDX+1).type = '40';
            EEG1.event(eventIDX).type = '45';
        end
    end
    
    % Epoch Stim Trains
    
    for condIDX = 1:numC

        
        EEG2 = pop_epoch( EEG1, {  char(epoch_stimTrain(condIDX))  }, [-5.6 22.8], 'newname',[epochname char(conditionName(condIDX))], 'epochinfo', 'yes'); % epoch dataset and name
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

        pop_saveset(EEG2,'filename',[epochname char(conditionName(condIDX)) '.set'], 'filepath',[stimTrainWithBaseline_savepath 'LeftMu/']);
        EEG2=[]; % clears the dataset
        
    end

    STUDY = []; CURRENTSTUDY = 0; ALLEEG = []; EEG=[]; CURRENTSET=[]; % clears the dataset

    %% Load and Epoch for Right Mu only
    EEG1 = pop_loadset('filename',loadFile,'filepath',rightMuLoadPath); % Load PreEpoch dateset
    [ALLEEG EEG1 CURRENTSET] = eeg_store(ALLEEG, EEG1); % copy it to ALLEEG
    EEG1 = eeg_checkset( EEG1 );
    
    % Update the event markers for each stimulus train. Marks the second
    % event of each stimulus train as the starting point for epoching.
    n_events = length(EEG1.event);
    for eventIDX = 1:n_events
        if strcmpi(EEG1.event(eventIDX).type,'1') && EEG1.event(eventIDX-1).latency < EEG1.event(eventIDX).latency - EEG1.srate
            EEG1.event(eventIDX+1).type = '10'; % second event of each stim train
            EEG1.event(eventIDX).type = '15'; % first event of each stim train (for baseline)
        elseif strcmpi(EEG1.event(eventIDX).type,'2') && EEG1.event(eventIDX-1).latency < EEG1.event(eventIDX).latency - EEG1.srate
            EEG1.event(eventIDX+1).type = '20';
            EEG1.event(eventIDX).type = '25';
        elseif strcmpi(EEG1.event(eventIDX).type,'3') && EEG1.event(eventIDX-1).latency < EEG1.event(eventIDX).latency - EEG1.srate
            EEG1.event(eventIDX+1).type = '30';
            EEG1.event(eventIDX).type = '35';
        elseif strcmpi(EEG1.event(eventIDX).type,'4') && EEG1.event(eventIDX-1).latency < EEG1.event(eventIDX).latency - EEG1.srate
            EEG1.event(eventIDX+1).type = '40';
            EEG1.event(eventIDX).type = '45';
        end
    end
    
    % Epoch Stim Trains
    
    for condIDX = 1:numC

        
        EEG2 = pop_epoch( EEG1, {  char(epoch_stimTrain(condIDX))  }, [-5.6 22.8], 'newname',[epochname char(conditionName(condIDX))], 'epochinfo', 'yes'); % epoch dataset and name
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

        pop_saveset(EEG2,'filename',[epochname char(conditionName(condIDX)) '.set'], 'filepath',[stimTrainWithBaseline_savepath 'RightMu/']);
        EEG2=[]; % clears the dataset
        
    end


    
end
            
        
