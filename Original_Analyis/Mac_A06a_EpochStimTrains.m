%% Epochs data based on condition. Each epoch consists of one entire stimulus train

% clears any loaded dataset or study
STUDY = []; CURRENTSTUDY = 0; ALLEEG = []; EEG=[]; CURRENTSET=[]; 

% File paths
loadpath = '/Users/danielcomstock/Documents/Data/AV_TapNoTap/Data/05_AMICA_DipFit/';
savepath = '/Users/danielcomstock/Documents/Data/AV_TapNoTap/Data/06a_EpochStimTrain/';

epoch = ["10","20","30","40"]; % array of condition names
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
    
    % Update the event markers for each stimulus train. Marks the second
    % event of each stimulus train as the starting point for epoching.
    n_events = length(EEG1.event);
    for eventIDX = 1:n_events
        if strcmpi(EEG1.event(eventIDX).type,'1') && EEG1.event(eventIDX-1).latency < EEG1.event(eventIDX).latency - EEG1.srate
            EEG1.event(eventIDX+1).type = '10';
        elseif strcmpi(EEG1.event(eventIDX).type,'2') && EEG1.event(eventIDX-1).latency < EEG1.event(eventIDX).latency - EEG1.srate
            EEG1.event(eventIDX+1).type = '20';
        elseif strcmpi(EEG1.event(eventIDX).type,'3') && EEG1.event(eventIDX-1).latency < EEG1.event(eventIDX).latency - EEG1.srate
            EEG1.event(eventIDX+1).type = '30';
        elseif strcmpi(EEG1.event(eventIDX).type,'4') && EEG1.event(eventIDX-1).latency < EEG1.event(eventIDX).latency - EEG1.srate
            EEG1.event(eventIDX+1).type = '40';
        end
    end
    
    % Epoch data sets
    
    for condIDX = 1:numC

        
        EEG2 = pop_epoch( EEG1, {  char(epoch(condIDX))  }, [0 22.8 ], 'newname',[epochname char(conditionName(condIDX))], 'epochinfo', 'yes'); % epoch dataset and name
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
            
        
