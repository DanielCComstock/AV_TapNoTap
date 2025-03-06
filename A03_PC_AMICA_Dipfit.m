
%% Fileset variables
% clears any loaded dataset or study
STUDY = []; CURRENTSTUDY = 0; ALLEEG = []; EEG=[]; CURRENTSET=[]; 

% File paths
loadpath = 'H:\Data\AV_TapNoTap\04_InterpASRReRef\';
savepath = 'H:\Data\AV_TapNoTap\05_AMICA_DipFit\';
amicapath = 'H:\Data\AV_TapNoTap\05_AMICA_DipFit\amicaout\';


% saves the names of all of the files in the load path that end with .cnt
allFiles = dir([loadpath,'*.set']);

%% Loop to load all of the files and preproces them.
for j = 1:length(allFiles)
    
    % Stores the name of of the file in allFiles at index j into loadFile
    loadFile = allFiles(j).name;
    % removes the last 4 characters from loadFile to use as the savename
    savename = loadFile(1:end-4);
    
    % load file name
    EEG = pop_loadset('filename',loadFile,'filepath',loadpath);
    % Checks for dataset consistancy
    EEG = eeg_checkset( EEG );

%Run AMICA using calculated data rank with 'pcakeep' option
    
    dataRank = EEG.nbchan - length(EEG.chaninfo.removedchans) + 2; % removedchans includes all removed channels including the two zero channels that were added and then removed durring rereferencing
    
    amicaoutputdir = [amicapath savename];
    runamica15(EEG.data, 'num_chans', EEG.nbchan,...
        'outdir', amicaoutputdir,...
        'pcakeep', dataRank, 'num_models', 1, 'max_threads', 14, 'max_iter', 2000, ...
        'do_reject', 1, 'numrej', 15, 'rejsig', 3, 'rejint', 1);
    EEG.etc.amica  = loadmodout15(amicaoutputdir);
    EEG.icaweights = EEG.etc.amica.W;
    EEG.icasphere  = EEG.etc.amica.S;
    EEG = pop_loadmodout(EEG, amicaoutputdir)
    EEG = eeg_checkset(EEG, 'ica');
    
    %Fit dipoles
    EEG = pop_dipfit_settings( EEG, 'hdmfile','C:\\EEGLAB\\eeglab-develop\\plugins\\dipfit3.3\\standard_BEM\\standard_vol.mat',...
        'coordformat','MNI','mrifile','C:\\EEGLAB\\eeglab-develop\\plugins\\dipfit3.3\\standard_BEM\\standard_mri.mat',...
        'chanfile','C:\\EEGLAB\\eeglab-develop\\plugins\\dipfit3.3\\standard_BEM\\elec\\standard_1005.elc',...
        'coord_transform',[0.86401 -17.8409 -7.4249 0.19858 -0.0007768 -1.5718 0.91308 0.9605 1.0156] ,'chansel',[1:EEG.nbchan] );
    EEG = pop_multifit(EEG, [1:EEG.nbchan] ,'threshold',100,'plotopt',{'normlen' 'on'});
    EEG = eeg_checkset( EEG );
    
        % sets the dataset name to savename
    EEG.setname=savename;
    % Saves the dataset 
    EEG = pop_saveset( EEG, 'filename',savename,'filepath',savepath);
    
    STUDY = []; CURRENTSTUDY = 0; ALLEEG = []; EEG=[]; CURRENTSET=[]; % clears the dataset
end
    eeglab redraw