STUDY = []; CURRENTSTUDY = 0; ALLEEG = []; EEG=[]; CURRENTSET=[]; % clears the dataset

loadpath = 'H:\Data\AV_TapNoTap\02_2Hz50HzFilter\';
savepath = 'H:\Data\AV_TapNoTap\03_ASR_ReRef_AMICA_Dipfit\';

allFiles = dir([loadpath,'*.set']);
for j = 1:length(allFiles)
    
    loadFile = allFiles(j).name;
    savename = [loadFile(1:end-27) '_AMICA_Dipfit'];
    
    EEG = pop_loadset('filename',loadFile,'filepath',loadpath);
    EEG = eeg_checkset( EEG );

    
    EEG.setname=savename;
    EEG = eeg_checkset( EEG );
    eeglab redraw;
    
    EEG = clean_rawdata(EEG, 5, [-1], 0.8, -1, 20, 0.5);
    EEG = eeg_checkset( EEG );
    
    EEG.nbchan = EEG.nbchan+1;
    EEG.data(end+1,:) = zeros(1, EEG.pnts);
    EEG.chanlocs(1,EEG.nbchan).labels = 'initialReference';
    EEG = pop_reref(EEG, []);
    EEG = pop_select( EEG,'nochannel',{'initialReference'});
    EEG = eeg_checkset( EEG );
    eeglab redraw;
    
     %Run AMICA using calculated data rank with 'pcakeep' option

    if isfield(EEG.etc, 'clean_channel_mask')
        dataRank = min([rank(double(EEG.data')) sum(EEG.etc.clean_channel_mask)]);
    else
        dataRank = rank(double(EEG.data'));
    end
    amicaoutputdir = ['H:\Data\AVOmit\EEGPC\Test\amicaout\' savename];
    runamica15(EEG.data, 'num_chans', EEG.nbchan,...
        'outdir', amicaoutputdir,...
        'pcakeep', dataRank, 'num_models', 4, 'max_threads', 32, 'max_iter', 1500, ...
        'do_reject', 1, 'numrej', 15, 'rejsig', 3, 'rejint', 1);
    EEG.etc.amica  = loadmodout15(amicaoutputdir);
    %EEG.etc.amica.S = EEG.etc.amica.S(1:EEG.etc.amica.num_pcs, :); % Weirdly, I saw size(S,1) be larger than rank. This process does not hurt anyway.
    EEG.icaweights = EEG.etc.amica.W;
    EEG.icasphere  = EEG.etc.amica.S;
    EEG = pop_loadmodout(EEG, amicaoutputdir)
    EEG = eeg_checkset(EEG, 'ica');
    
    % Run dipfit to determine dipole locations
    EEG = pop_dipfit_settings( EEG, 'hdmfile','C:\\EEGLAB\\eeglab14_1_1b\\plugins\\dipfit2.3\\standard_BEM\\standard_vol.mat','coordformat','MNI','mrifile','C:\\EEGLAB\\eeglab14_1_1b\\plugins\\dipfit2.3\\standard_BEM\\standard_mri.mat','chanfile','C:\\EEGLAB\\eeglab14_1_1b\\plugins\\dipfit2.3\\standard_BEM\\elec\\standard_1005.elc','coord_transform',[0.86354 -17.8409 -7.4249 0.19857 -0.00077434 -1.5718 0.91308 0.9605 1.0156] ,'chansel',[1:EEG.nbchan] );
    EEG = pop_multifit(EEG, [1:EEG.nbchan] ,'threshold',100,'plotopt',{'normlen' 'on'});
    EEG = fitTwoDipoles(EEG, 'LRR', 35);
    EEG = eeg_checkset( EEG );
    eeglab redraw;
    
    EEG = pop_saveset( EEG, 'filename',savename,'filepath',savepath);
    STUDY = []; CURRENTSTUDY = 0; ALLEEG = []; EEG=[]; CURRENTSET=[]; % clears the dataset
end
    eeglab redraw