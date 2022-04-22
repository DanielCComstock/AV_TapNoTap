% EEGLAB history file generated on the 19-Oct-2018
% ------------------------------------------------

EEG.etc.eeglabvers = '14.1.1'; % this tracks which version of EEGLAB is being used, you may ignore it
EEG = eeg_checkset( EEG );
EEG = pop_loadset('filename','AVTapNoTap10_ReSamp256Hz.set','filepath','H:\\Data\\AV_TapNoTap\\01_Import_Resamp\\');
EEG = eeg_checkset( EEG );
EEG=pop_chanedit(EEG, 'load',{'H:\\Data\\3DOnlyWaveguard32.elc' 'filetype' 'autodetect'},'eval','chans = pop_chancenter( chans, [],[]);');
EEG = eeg_checkset( EEG );
figure; pop_spectopo(EEG, 1, [0       1052453.125], 'EEG' , 'percent', 15, 'freqrange',[2 70],'electrodes','off');
EEG = pop_eegfiltnew(EEG, [],2,424,1,[],0);
EEG = eeg_checkset( EEG );
figure; pop_spectopo(EEG, 1, [0       1052453.125], 'EEG' , 'percent', 15, 'freqrange',[2 70],'electrodes','off');
EEG = pop_eegfiltnew(EEG, [],50,68,0,[],0);
EEG = eeg_checkset( EEG );
figure; pop_spectopo(EEG, 1, [0       1052453.125], 'EEG' , 'percent', 15, 'freqrange',[2 70],'electrodes','off');
EEG = pop_cleanline(EEG, 'bandwidth',2,'chanlist',[1:32] ,'computepower',0,'linefreqs',[60 120] ,'normSpectrum',0,'p',0.01,'pad',2,'plotfigures',0,'scanforlines',1,'sigtype','Channels','tau',100,'verb',1,'winsize',2,'winstep',2);
EEG = eeg_checkset( EEG );
figure; pop_spectopo(EEG, 1, [0       1052453.125], 'EEG' , 'percent', 15, 'freqrange',[2 70],'electrodes','off');
