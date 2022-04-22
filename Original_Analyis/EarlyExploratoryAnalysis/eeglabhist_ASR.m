% EEGLAB history file generated on the 19-Oct-2018
% ------------------------------------------------

EEG.etc.eeglabvers = '14.1.1'; % this tracks which version of EEGLAB is being used, you may ignore it
EEG = eeg_checkset( EEG );
EEG = eeg_checkset( EEG );
EEG = eeg_checkset( EEG );
% multiple datasets command: EEG = pop_loadset('filename',{'AVTapNoTap1_ReSamp256Hz_Filt2Hz50Hz.set' 'AVTapNoTap2_ReSamp256Hz_Filt2Hz50Hz.set' 'AVTapNoTap3_ReSamp256Hz_Filt2Hz50Hz.set' 'AVTapNoTap4_ReSamp256Hz_Filt2Hz50Hz.set' 'AVTapNoTap5_ReSamp256Hz_Filt2Hz50Hz.set'},'filepath','H:\\Data\\AV_TapNoTap\\02_2Hz50HzFilter\\');
EEG = eeg_checkset( EEG );
EEG = eeg_checkset( EEG );
pop_eegplot( EEG, 1, 1, 1);
EEG = clean_rawdata(EEG, 5, [-1], 0.8, -1, 20, 0.5);
EEG = eeg_checkset( EEG );
pop_eegplot( EEG, 1, 1, 1);
