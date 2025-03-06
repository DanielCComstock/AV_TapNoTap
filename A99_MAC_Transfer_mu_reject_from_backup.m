% transfer mu & reject info from backup

STUDY = []; CURRENTSTUDY = 0; ALLEEG = []; EEG=[]; CURRENTSET=[]; 

% File paths
backuppath = '/Users/dccomsto/Projekts/AV_TapNoTap/Data/Revision1_Analysis/03_AMICA_DipFit/PreExtraEventRemoval/';
savepath = '/Users/dccomsto/Projekts/AV_TapNoTap/Data/Revision1_Analysis/03_AMICA_DipFit/';

for fileIDX = 1:21

    if fileIDX == 15 || fileIDX == 16

    else

        loadFile = ['AVTapNoTap' num2str(fileIDX) '.set'];
        savename = loadFile(1:end-4);
        
        % load file name
        EEG = pop_loadset('filename',loadFile,'filepath',backuppath);
        % Checks for dataset consistancy
        EEG = eeg_checkset( EEG );

        muVals = EEG.mu;
        reject = EEG.reject;

        STUDY = []; CURRENTSTUDY = 0; ALLEEG = []; EEG=[]; CURRENTSET=[]; 

         % load file name
        EEG = pop_loadset('filename',loadFile,'filepath',savepath);
        % Checks for dataset consistancy
        EEG = eeg_checkset( EEG );

        EEG.mu = muVals;
        EEG.reject = reject;

        clear muVals reject

        EEG = eeg_checkset( EEG );
    
        pop_saveset(EEG,'filename',savename, 'filepath',savepath);
    
        STUDY = []; CURRENTSTUDY = 0; ALLEEG = []; EEG=[]; CURRENTSET=[]; % clears the dataset
    end
end




    