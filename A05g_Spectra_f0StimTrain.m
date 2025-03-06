% Calculate spectral power and baseline against background spectra through
% correcting against neighboring frequency bins.

%% load Data
close
clear
clc


loadF0StimTrainPath = '/Users/dcc/Data/AV_TapNoTap/Data/Revision1_Analysis/04a_Epoch_StimTrains/AllComps/';
saveF0DataPath = '/Users/dcc/Data/AV_TapNoTap/Data/Revision1_Analysis/05g_Spectra_f0StimTrains/';

allFiles = dir([loadF0StimTrainPath,'*.set']);

visTapSubs = {allFiles(find(contains({allFiles.name}, 'Vis_Tap'))).name}'; % get all filenames from allFiles.name with 'Vis_Tap'
visConSubs = {allFiles(find(contains({allFiles.name}, 'Vis_Con'))).name}';
audTapSubs = {allFiles(find(contains({allFiles.name}, 'Aud_Tap'))).name}'; 
audConSubs = {allFiles(find(contains({allFiles.name}, 'Aud_Con'))).name}';

for condition = 1:4
    if condition == 1
        loadNames = visConSubs;
        saveName = 'StimTrainCorrectedSpectra_Vis_Con';

    elseif condition == 2
        loadNames = visTapSubs;  
        saveName = 'StimTrainCorrectedSpectra_Vis_Tap';

    elseif condition == 3
        loadNames = audConSubs;
        saveName = 'StimTrainCorrectedSpectra_Aud_Con';
        
    elseif condition == 4
        loadNames = audTapSubs;
        saveName = 'StimTrainCorrectedSpectra_Aud_Tap';

    end

    for subIDX = 1:length(visTapSubs)
        
        
        % load stimTrain epoches
        EEG = pop_loadset('filename',char(loadNames(subIDX)),...
            'filepath',loadF0StimTrainPath);
        
        numComps = size(EEG.icaweights,1);

        % save meta data
    
        data.subj(subIDX).Epochs = EEG.epoch;

        data.subj(subIDX).filename = char(loadNames(subIDX));     
        
        data.subj(subIDX).Events = EEG.event;
        
        data.EEG_Times = EEG.times; % always the same so overwrites for only one copy
    
        data.subj(subIDX).MuComps = EEG.mu;
    
        data.subj(subIDX).chanlist = {EEG.chanlocs.labels}';


        %% Compute spectral power
        
        % compute spectra for all components with FFT width equal to the length of
        % the epoch (EEG.pnts = 5837, or 22.8 seconds) resulting in a frequency
        % resolution of 0.0439 Hz (freq res = 1/FFT length in seconds)
        [compSpectra,freqs] = spectopo(EEG.icaact, EEG.pnts, EEG.srate,'winsize', EEG.pnts,'plot','off'); 

        [chanSpectra,freqs] = spectopo(EEG.data, EEG.pnts, EEG.srate,'winsize', EEG.pnts,'plot','off');
        
        
        %% Get freqs of interest and Freq range
        
        % find index of freq closest to 1 (start)
        tempFs = freqs-1;
        [minVal startIDX] = min(abs(tempFs));
        % find index of freq closest to 8 (end)
        tempFs = freqs-8;
        [minVal endIDX] = min(abs(tempFs));

        % find index of freq closest to f0 (1/0.6) = 1.6666
        tempFs = freqs-(1/0.6);
        [minVal f0IDX] = min(abs(tempFs));
        % find index of freq closest to f1 (1/0.6)*2 = first harmonic
        tempFs = freqs-(1/0.6)*2;
        [minVal f1IDX] = min(abs(tempFs));
        % find index of freq closest to f2 (1/0.6)*3 = 2nd harmonic
        tempFs = freqs-(1/0.6)*3;
        [minVal f2IDX] = min(abs(tempFs));
        % find index of freq closest to f3 (1/0.6)*4 = 3nd harmonic
        tempFs = freqs-(1/0.6)*4;
        [minVal f3IDX] = min(abs(tempFs));
        
        
        freqROInterest = freqs(startIDX:endIDX);

        data.freqs = freqROInterest; % freq range of neighbor corrected spectra.
        
        %% Neighbor correct data (baselineing)
        
         % baseline based on a target bin width of 0.0439 (1 bin)
         % multiple widths of neighbor bins to average tested

        offset = startIDX-1;

        for compIDX = 1:numComps % wasteful to correct all comps since only the mu comps are used, but less lines of code and it is fast anyway (shrug)
            for freqIDX = startIDX:endIDX

                % 1 center bin 2 neighbor bins
                neighbor2BinIDX = [freqIDX-2 freqIDX-1 freqIDX+1 freqIDX+2];
                neighbor2BinAvg = mean(compSpectra(compIDX,neighbor2BinIDX));
                nCorFreqs2Bin(compIDX,freqIDX-offset) = compSpectra(compIDX,freqIDX) - neighbor2BinAvg;
            
                % 1 center bin 2 neighbor bins offset by 1
                neighbor2BinOff1IDX = [freqIDX-3 freqIDX-2 freqIDX+2 freqIDX+3];
                neighbor2BinOff1Avg = mean(compSpectra(compIDX,neighbor2BinOff1IDX));
                nCorFreqs2BinOff1(compIDX,freqIDX-offset) = compSpectra(compIDX,freqIDX) - neighbor2BinOff1Avg;
            
                % 1 center bin 3 neighbor bins
                neighbor3BinIDX = [freqIDX-3 freqIDX-2 freqIDX-1 freqIDX+1 freqIDX+2 freqIDX+3];
                neighbor3BinAvg = mean(compSpectra(compIDX,neighbor3BinIDX));
                nCorFreqs3Bin(compIDX,freqIDX-offset) = compSpectra(compIDX,freqIDX) - neighbor3BinAvg;
            
                % 1 center bin 3 neighbor bins offset by 1
                neighbor3BinOff1IDX = [freqIDX-4 freqIDX-3 freqIDX-2 freqIDX+2 freqIDX+3 freqIDX+4];
                neighbor3BinOff1Avg = mean(compSpectra(compIDX,neighbor3BinOff1IDX));
                nCorFreqs3BinOff1(compIDX,freqIDX-offset) = compSpectra(compIDX,freqIDX) - neighbor3BinOff1Avg;
        
                % 1 center bin 2 neighbor bins offset by 2
                neighbor2BinOff2IDX = [freqIDX-4 freqIDX-3 freqIDX+3 freqIDX+4];
                neighbor2BinOff2Avg = mean(compSpectra(compIDX,neighbor2BinOff2IDX));
                nCorFreqs2BinOff2(compIDX,freqIDX-offset) = compSpectra(compIDX,freqIDX) - neighbor2BinOff2Avg;
            end
        end


        % get Left Mu corrected spectra

        data.LMuCompCorSpectra2Bin(subIDX,:) = nCorFreqs2Bin(data.subj(subIDX).MuComps.left,:);
        data.LMuCompCorSpectra2BinOff1(subIDX,:) = nCorFreqs2BinOff1(data.subj(subIDX).MuComps.left,:);
        data.LMuCompCorSpectra3Bin(subIDX,:) = nCorFreqs3Bin(data.subj(subIDX).MuComps.left,:);
        data.LMuCompCorSpectra3BinOff1(subIDX,:) = nCorFreqs3BinOff1(data.subj(subIDX).MuComps.left,:);
        data.LMuCompCorSpectra2BinOff2(subIDX,:) = nCorFreqs2BinOff2(data.subj(subIDX).MuComps.left,:);

        % get Right Mu corrected spectra

        data.RMuCompCorSpectra2Bin(subIDX,:) = nCorFreqs2Bin(data.subj(subIDX).MuComps.right,:);
        data.RMuCompCorSpectra2BinOff1(subIDX,:) = nCorFreqs2BinOff1(data.subj(subIDX).MuComps.right,:);
        data.RMuCompCorSpectra3Bin(subIDX,:) = nCorFreqs3Bin(data.subj(subIDX).MuComps.right,:);
        data.RMuCompCorSpectra3BinOff1(subIDX,:) = nCorFreqs3BinOff1(data.subj(subIDX).MuComps.right,:);
        data.RMuCompCorSpectra2BinOff2(subIDX,:) = nCorFreqs2BinOff2(data.subj(subIDX).MuComps.right,:);
        
        clear nCorFreqs2BinOff2 nCorFreqs3BinOff1 nCorFreqs3Bin nCorFreqs2BinOff1 nCorFreqs2Bin

        % Get Chan corrected spectra
        for chanIDX = 1:EEG.nbchan
            for freqIDX = startIDX:endIDX
            
                % 1 center bin 2 neighbor bins
                neighbor2BinIDX = [freqIDX-2 freqIDX-1 freqIDX+1 freqIDX+2];
                neighbor2BinAvg = mean(chanSpectra(chanIDX,neighbor2BinIDX));
                data.ChanCorSpectra2Bin(subIDX,chanIDX,freqIDX-offset) = chanSpectra(chanIDX,freqIDX) - neighbor2BinAvg;
            
                % 1 center bin 2 neighbor bins offset by 1
                neighbor2BinOff1IDX = [freqIDX-3 freqIDX-2 freqIDX+2 freqIDX+3];
                neighbor2BinOff1Avg = mean(chanSpectra(chanIDX,neighbor2BinOff1IDX));
                data.ChanCorSpectra2BinOff1(subIDX,chanIDX,freqIDX-offset) = chanSpectra(chanIDX,freqIDX) - neighbor2BinOff1Avg;
            
                % 1 center bin 3 neighbor bins
                neighbor3BinIDX = [freqIDX-3 freqIDX-2 freqIDX-1 freqIDX+1 freqIDX+2 freqIDX+3];
                neighbor3BinAvg = mean(chanSpectra(chanIDX,neighbor3BinIDX));
                data.ChanCorSpectra3Bin(subIDX,chanIDX,freqIDX-offset) = chanSpectra(chanIDX,freqIDX) - neighbor3BinAvg;
            
                % 1 center bin 3 neighbor bins offset by 1
                neighbor3BinOff1IDX = [freqIDX-4 freqIDX-3 freqIDX-2 freqIDX+2 freqIDX+3 freqIDX+4];
                neighbor3BinOff1Avg = mean(chanSpectra(chanIDX,neighbor3BinOff1IDX));
                data.ChanCorSpectra3BinOff1(subIDX,chanIDX,freqIDX-offset) = chanSpectra(chanIDX,freqIDX) - neighbor3BinOff1Avg;
            
                % 1 center bin 2 neighbor bins offset by 2
                neighbor2BinOff2IDX = [freqIDX-4 freqIDX-3 freqIDX+3 freqIDX+4];
                neighbor2BinOff2Avg = mean(chanSpectra(chanIDX,neighbor2BinOff2IDX));
                data.ChanCorSpectra2BinOff2(subIDX,chanIDX,freqIDX-offset) = chanSpectra(chanIDX,freqIDX) - neighbor2BinOff2Avg;
            end
        end

    end

    %% Save data           
        
    fullsavedata = [saveF0DataPath saveName];
    spectraData = data;
    save(fullsavedata, 'spectraData');
    clear data

end








