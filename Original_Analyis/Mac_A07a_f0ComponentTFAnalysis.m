%% T/F analysis for AV TapNoTap - analyzes F0 and Mu - Beta in seperate calculations
% analyses are done on full stimulus trains first, and then chopped and
% averaged across events to allow low freq t/f w/out edge artifacts

%% load Data

clear
clc


loadF0EpochPath = '/Users/danielcomstock/Documents/Data/AV_TapNoTap/Data/06a_EpochStimTrain/';
saveF0DataPath = '/Users/danielcomstock/Documents/Data/AV_TapNoTap/Data/07_Comp_TF_Data/f02/';

allFiles = dir([loadF0EpochPath,'*.set']);

allFileNames = {allFiles.name}';
visList = strfind(allFileNames, 'Vis');
visIndex = find(~cellfun('isempty', visList));
visSubs = allFileNames(visIndex);
visTapList = strfind(visSubs, 'Vis_Tap');
visTapIndex = find(~cellfun('isempty', visTapList)); % Obtain the index numbers of the 'vis tap' subjects.
visTapSubs = visSubs(visTapIndex);
visConIndex = find(cellfun('isempty', visTapList));
visConSubs = visSubs(visConIndex);

audList = strfind(allFileNames, 'Aud');
audIndex = find(~cellfun('isempty', audList));
audSubs = allFileNames(audIndex);
audTapList = strfind(audSubs, 'Aud_Tap');
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
        
        
        % load Wide epoched data for F0 t/f calculations
        EEG_Con_W = pop_loadset('filename',char(controlLoadNames(subIDX)),...
            'filepath',loadF0EpochPath);

        EEG_Tap_W = pop_loadset('filename',char(tapLoadNames(subIDX)),...
            'filepath',loadF0EpochPath);
        
        numComps = size(EEG_Con_W.icaweights,1);
        
        
        dataWC.filename = char(controlLoadNames(subIDX));
        dataWT.filename = char(tapLoadNames(subIDX));
        
        dataWC.WideEvents = EEG_Con_W.event;
        dataWT.WideEvents = EEG_Tap_W.event;
        
        dataWC.WideEpochs = EEG_Con_W.epoch;
        dataWT.WideEpochs = EEG_Tap_W.epoch;
        
        dataWC.WideTimes = EEG_Con_W.times;
        dataWT.WideTimes = EEG_Tap_W.times;
        
        for compIDX = 1:numComps
            
            %% Calculate F0 T/F Data
            
            f0Freqs = 1.0666:0.1:14.0666; % Frequencies used

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
                % Using 7 cycles at lowest frequency to 92.3178 at highest.
                % Generating 3966 time points (3654.3 to 19142.6 ms)
                % Distribution of data point for time/freq decomposition is perfectly uniform
                % The window size used is 1871 samples (7308.59 ms) wide.
                % Estimating 81 linear-spaced frequencies from 1.1 Hz to 9.1 Hz.            
               
            % store data
            dataWC.f0(compIDX).tfdata = tfdata;
            dataWC.f0Times = times;
            dataWC.f0Freqs = freqs;

            clear ersp itc powbase times freqs erspboot itcboot tfdata
            
            % perform t/f on tap condition for F0 
            [ersp,itc,powbase,times,freqs,erspboot,itcboot,tfdata] = newtimef(EEG_Tap_W.icaact(compIDX,:,:),...
            EEG_Tap_W.pnts,[EEG_Tap_W.xmin EEG_Tap_W.xmax]*1000, EEG_Tap_W.srate,... 
            'cycles', [7 0], 'ntimesout', 3966, 'baseline', [NaN],'freqs', f0Freqs,...
            'freqscale', 'linear','plotphasesign','off', 'plotersp','off', 'plotitc','off');

            % store data
            dataWT.f0(compIDX).tfdata = tfdata;
            dataWT.f0Times = times;
            dataWT.f0Freqs = freqs;
            
            clear ersp itc powbase times freqs erspboot itcboot tfdata
            
        end

        clear EEG_Con_N EEG_Tap_N EEG_Con_W EEG_Tap_W
        
        %% Save output files for later plotting
               
        % Save control data
        savename = dataWC.filename(1:end-4);
        fullsavedata = [saveF0DataPath savename];
        TF_dataW = dataWC;
        save(fullsavedata, 'TF_dataW');
        clear dataWC
         
        % Save control data
        savename = dataWT.filename(1:end-4);
        fullsavedata = [saveF0DataPath savename];
        TF_dataW = dataWT;
        save(fullsavedata, 'TF_dataW');
        clear dataWT


    end
    
end

% these two are equivalent
% figure(1);
% imagesc(TF_data.f0(1).ersp);
% colormap jet;
% 
% figure(2);
% imagesc(10*log10(mean(abs(TF_data.f0(1).tfdata).^2,3)));
% colormap jet;

       