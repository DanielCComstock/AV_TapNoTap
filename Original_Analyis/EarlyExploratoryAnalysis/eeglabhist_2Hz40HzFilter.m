% EEGLAB history file generated on the 14-Oct-2018
% ------------------------------------------------

EEG.etc.eeglabvers = '14.1.1'; % this tracks which version of EEGLAB is being used, you may ignore it
EEG = eeg_checkset( EEG );
EEG = pop_loadset('filename','AVTapNoTap1_ReSamp256Hz.set','filepath','H:\\Data\\AV_TapNoTap\\01_Import_Resamp\\');
EEG = eeg_checkset( EEG );
EEG = pop_eegfiltnew(EEG, [],2,424,1,[],0);
EEG = eeg_checkset( EEG );
EEG = pop_eegfiltnew(EEG, [],40,86,0,[],0);
EEG = eeg_checkset( EEG );
