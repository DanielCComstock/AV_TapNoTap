% Epoching
Ns = 21; Nc = 4; % Ns - number of subjects; Nc - Number of conditions;'
ep = ['1';'2';'3';'4'] % array of condition names
epoch = cellstr(ep) % converts string to cell for indexing
for S = 19:Ns  % For each of the subjects
        loadname = ['AVTapNoTap' int2str(S) '__AMICA_Dipfit.set']; % name used to load PreEpoch dataset
        epochname = ['AV_TapNoTap_' int2str(S) '_Epoch_']; % name used to save epoched dataset
        loadpath = 'H:\Data\AV_TapNoTap\03d_ASR_ReRef_AMICA6Model_Dipfit_Marked\'; % savepath for epoched dataset
        savepath = 'H:\Data\AV_TapNoTap\04c_Epoch6ModelAmica\'; % savepath for epoch_rej dataset
        for E = 1:Nc
            EEG = pop_loadset('filename',loadname,'filepath',loadpath); % Load PreEpoch dateset
            EEG = eeg_checkset( EEG );
            eeglab redraw;
            EEG = pop_epoch( EEG, {  char(epoch(E))  }, [-2  2], 'newname',[epochname char(epoch(E))], 'epochinfo', 'yes'); % epoch dataset and name
            EEG = eeg_checkset( EEG );
            eeglab redraw;

            EEG = pop_eegthresh(EEG,1,[1:ALLEEG.nbchan] ,-500,500,-01,1.9961,0,0); % reject any epoch beyond +/-500uv
            EEG = eeg_checkset( EEG );
            EEG = pop_jointprob(EEG,1,[1:ALLEEG.nbchan] ,6,2,1,0); % reject any epoch > 6 st.dev and any channel > 2 st.dev
            EEG = eeg_checkset( EEG );
            eeglab redraw;
            [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'savenew',[savepath epochname char(epoch(E)) '.set'] ,'overwrite','on','gui','off'); % save epoched dataset
            STUDY = []; CURRENTSTUDY = 0; ALLEEG = []; EEG=[]; CURRENTSET=[]; % clears the dataset
        end
end 
eeglab redraw;