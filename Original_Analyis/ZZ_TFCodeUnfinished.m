%% T/F analysis for AV TapNoTap - analyzes F0 and Mu - Beta in seperate calculations
% analyses are done on full stimulus trains first, and then chopped and
% averaged across events to allow low freq t/f w/out edge artifacts

%% load Data

% have eeglab running prior to starting

loadWideEpochPath = '/Users/danielcomstock/Documents/Data/AV_TapNoTap/Data/06a_EpochStimTrain/';
loadNarrowEpochPath = '/Users/danielcomstock/Documents/Data/AV_TapNoTap/Data/06b_EpochIndvStims/';
saveDataPath = '/Users/danielcomstock/Documents/Data/AV_TapNoTap/Data/07_Comp_TF_Data/';
savePlotPath = '/Users/danielcomstock/Documents/Data/AV_TapNoTap/Data/08_Comp_TF_Plots/';

allFiles = dir([loadWideEpochPath,'*.set']);

allFileNames = {allFiles.name}';
visList = strfind(allFileNames, 'Vis');
visIndex = find(~cellfun('isempty', visList));
visSubs = allFileNames(visIndex);
visTapList = strfind(visSubs, 'Vis_Tap');
visTapIndex = find(~cellfun('isempty', visTapList)); % Obtain the index number of the 'flash_Omit' subjects.
visTapSubs = visSubs(visTapIndex);
visConIndex = find(cellfun('isempty', visTapList));
visConSubs = visSubs(visConIndex);

audList = strfind(allFileNames, 'Aud');
audIndex = find(~cellfun('isempty', audList));
audSubs = allFileNames(audIndex);
audTapList = strfind(audSubs, 'TAud_Tap');
audTapIndex = find(~cellfun('isempty', audTapList)); 
audTapSubs = audSubs(audTapIndex);
audConIndex = find(cellfun('isempty', audTapList));
audConSubs = audSubs(audConIndex);


for Aud_vs_Vis = 1:2
    if Aud_vs_Vis == 1
        controlLoadNames = visConSubs;
        tapLoadNames = visTapSubs;
    elseif Aud_vs_Vis == 2
        controlLoadNames = audConSubs;
        tapLoadNames = audTapSubs;
    end

    for subIDX = 1:length(controlLoadNames)
        
        % load Narrow epoched data for Mu and Beta t/f calculations
        EEG_Con_N = pop_loadset('filename',char(controlLoadNames(subIDX)),...
            'filepath',loadNarrowEpochPath);

        EEG_Tap_N = pop_loadset('filename',char(tapLoadNames(subIDX)),...
            'filepath',loadNarrowEpochPath);
        
        % load Wide epoched data for F0 t/f calculations
        EEG_Con_W = pop_loadset('filename',char(controlLoadNames(subIDX)),...
            'filepath',loadWideEpochPath);

        EEG_Tap_W = pop_loadset('filename',char(tapLoadNames(subIDX)),...
            'filepath',loadWideEpochPath);
        
        numComps = size(EEG_Con_N.icaweights,1);
        
        dataC.filename = char(controlLoadNames(subIDX));
        dataT.filename = char(tapLoadNames(subIDX));
        
        dataC.WideEvents = EEG_Con_W.event;
        dataT.WideEvents = EEG_Tap_W.event;
        
        dataC.WideEpochs = EEG_Con_W.epoch;
        dataT.WideEpochs = EEG_Tap_W.epoch;
        
        for compIDX = 1:numComps
            
            %% Mu and Beta t/f calculations
            
            % perform t/f with common baseline from 8 to 35 Hz 
            figure;
            [ersp,itc,powbase,times,freqs,erspboot,itcboot,tfdata] = newtimef({EEG_Con_N.icaact(compIDX,:,:)...
            EEG_Tap_N.icaact(compIDX,:,:)},EEG_Con_N.pnts,[EEG_Con_N.xmin EEG_Con_N.xmax]*1000, EEG_Con_N.srate,... 
            'cycles', [4 0], 'padratio',2, 'ntimesout', 625, 'baseline', [-1500 1496],'freqs', [8 35],...
            'freqscale', 'linear','plotphasesign','off', 'plotersp','on', 'plotitc','on','commonbase','on');
        
            % Read out information from above parameters:
                % Computing Event-Related Spectral Perturbation (ERSP) and
                %   Inter-Trial Phase Coherence (ITC) images based on 132 trials
                %   of 768 frames sampled at 256 Hz.
                % Each trial contains samples from -1500 ms before to
                %   1496 ms after the timelocking event.
                %   Image frequency direction: normal
                % Using 4 cycles at lowest frequency to 17.5 at highest.
                % Generating 625 time points (-1220.7 to 1216.8 ms)
                % Distribution of data point for time/freq decomposition is perfectly uniform
                % The window size used is 143 samples (558.594 ms) wide.
                % Estimating 28 linear-spaced frequencies from 8.0 Hz to 35.0 Hz.
                
            % store data into dataC for control and dataT for Tap
            dataC.MuBetaCom(compIDX).ersp = cell2mat(ersp(1));
            dataC.MuBetaCom(compIDX).itc = cell2mat(itc(1));
            dataC.MuBetaCom(compIDX).powbase = cell2mat(powbase(1));
            dataC.MuBetaCom(compIDX).tfdata = cell2mat(tfdata(1));
            dataC.MuBetaCom(compIDX).times = times;
            dataC.MuBetaCom(compIDX).freqs = freqs;

            dataT.MuBetaCom(compIDX).ersp = cell2mat(ersp(2));
            dataT.MuBetaCom(compIDX).itc = cell2mat(itc(2));
            dataT.MuBetaCom(compIDX).powbase = cell2mat(powbase(2));
            dataT.MuBetaCom(compIDX).tfdata = cell2mat(tfdata(1));
            dataT.MuBetaCom(compIDX).times = times;
            dataT.MuBetaCom(compIDX).freqs = freqs;
            
            % perform t/f on control condition with individual baseline from 8 to 35 Hz 
            [ersp,itc,powbase,times,freqs,erspboot,itcboot,tfdata] = newtimef(EEG_Con_N.icaact(compIDX,:,:),...
            EEG_Con_N.pnts,[EEG_Con_N.xmin EEG_Con_N.xmax]*1000, EEG_Con_N.srate,... 
            'cycles', [4 0], 'padratio',2, 'ntimesout', 625, 'baseline', [-1500 1496],'freqs', [8 35],...
            'freqscale', 'linear','plotphasesign','off', 'plotersp','off', 'plotitc','off');
   
            % store data
            dataC.MuBetaInd(compIDX).ersp = ersp;
            dataC.MuBetaInd(compIDX).itc = itc;
            dataC.MuBetaInd(compIDX).powbase = powbase;
            dataC.MuBetaInd(compIDX).tfdata = tfdata;
            dataC.MuBetaInd(compIDX).times = times;
            dataC.MuBetaInd(compIDX).freqs = freqs;
            
            % Compute and store ERSP without baseline data
            dataC.MuBetaNoBase(compIDX).ersp = 10*log10(mean(abs(tfdata).^2,3));
            dataC.MuBetaNoBase(compIDX).times = times;
            dataC.MuBetaNoBase(compIDX).freqs = freqs;
            
            % perform t/f on tap condition with individual baseline from 8 to 35 Hz 
            [ersp,itc,powbase,times,freqs,erspboot,itcboot,tfdata] = newtimef(EEG_Tap_N.icaact(compIDX,:,:),...
            EEG_Tap_N.pnts,[EEG_Tap_N.xmin EEG_Tap_N.xmax]*1000, EEG_Tap_N.srate,... 
            'cycles', [4 0], 'padratio',2, 'ntimesout', 625, 'baseline', [-1500 1496],'freqs', [8 35],...
            'freqscale', 'linear','plotphasesign','off', 'plotersp','off', 'plotitc','off');

            % store data
            dataT.MuBetaInd(compIDX).ersp = ersp;
            dataT.MuBetaInd(compIDX).itc = itc;
            dataT.MuBetaInd(compIDX).powbase = powbase;
            dataT.MuBetaInd(compIDX).tfdata = tfdata;
            dataT.MuBetaInd(compIDX).times = times;
            dataT.MuBetaInd(compIDX).freqs = freqs;
            
            % Compute and store ERSP without baseline data
            dataT.MuBetaNoBase(compIDX).ersp = 10*log10(mean(abs(tfdata).^2,3));
            dataT.MuBetaNoBase(compIDX).times = times;
            dataT.MuBetaNoBase(compIDX).freqs = freqs;
            
            
            %% Calculate F0 T/F Data
            
            f0Freqs = 1.0666:0.1:9.0666; % Frequencies used

            % perform t/f on control condition for F0 
            [ersp,itc,powbase,times,freqs,erspboot,itcboot,tfdata] = newtimef(EEG_Con_W.icaact(compIDX,:,:),...
            EEG_Con_W.pnts,[EEG_Con_W.xmin EEG_Con_W.xmax]*1000, EEG_Con_W.srate,... 
            'cycles', [7 0], 'ntimesout', 3966, 'baseline', [NaN],'freqs', f0Freqs,...
            'freqscale', 'linear','plotphasesign','off', 'plotersp','off', 'plotitc','off');
        
            % Read out information from above parameters:
                % Computing Event-Related Spectral Perturbation (ERSP) and
                %   Inter-Trial Phase Coherence (ITC) images based on 4 trials
                %   of 5837 frames sampled at 256 Hz.
                % Each trial contains samples from 0 ms before to
                %   22797 ms after the timelocking event.
                %   Image frequency direction: normal
                % Using 7 cycles at lowest frequency to 59.5033 at highest.
                % Generating 3966 time points (3654.3 to 19142.6 ms)
                % Distribution of data point for time/freq decomposition is perfectly uniform
                % The window size used is 1871 samples (7308.59 ms) wide.
                % Estimating 81 linear-spaced frequencies from 1.1 Hz to 9.1 Hz.            
               
            % store data
            dataC.f0(compIDX).ersp = ersp;
            dataC.f0(compIDX).itc = itc;
            dataC.f0(compIDX).powbase = powbase;
            dataC.f0(compIDX).tfdata = tfdata;
            dataC.f0(compIDX).times = times;
            dataC.f0(compIDX).freqs = freqs;

            
            % perform t/f on tap condition for F0 
            [ersp,itc,powbase,times,freqs,erspboot,itcboot,tfdata] = newtimef(EEG_Tap_W.icaact(compIDX,:,:),...
            EEG_Tap_W.pnts,[EEG_Tap_W.xmin EEG_Tap_W.xmax]*1000, EEG_Tap_W.srate,... 
            'cycles', [7 0], 'ntimesout', 3966, 'baseline', [NaN],'freqs', f0Freqs,...
            'freqscale', 'linear','plotphasesign','off', 'plotersp','off', 'plotitc','off');

            % store data
            dataT.f0(compIDX).ersp = ersp;
            dataT.f0(compIDX).itc = itc;
            dataT.f0(compIDX).powbase = powbase;
            dataT.f0(compIDX).tfdata = tfdata;
            dataT.f0(compIDX).times = times;
            dataT.f0(compIDX).freqs = freqs;
            
        end

        clear EEG_Con_N EEG_Tap_N EEG_Con_W EEG_Tap_W
        
        % Save output files for later plotting
        
        % Save control data
        savename = dataC.filename(1:end-4);
        fullsavedata = [saveDataPath savename];
        TF_data = dataC;
        save(fullsavedata, 'TF_data');
        clear TF_data dataC
        
        % Save tap data
        
        savename = dataT.filename(1:end-4);
        fullsavedata = [saveDataPath savename];
        TF_data = dataT;
        save(fullsavedata, 'TF_data');
        clear TF_data dataT


    end
    
end
            
            
            
            
            
            
            