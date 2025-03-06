%% T/F analysis for AV TapNoTap Rev1 - analyzes F0 w/out baseline
% analyses are done on full stimulus trains first, and then chopped and
% averaged across events to allow low freq t/f w/out edge artifacts

%% load Data

clear
clc


loadF0StimTrainPath = '/Users/dcc/Data/AV_TapNoTap/Data/Revision1_Analysis/04a_Epoch_StimTrains/AllComps/';
saveF0DataPath = '/Users/dcc/Data/AV_TapNoTap/Data/Revision1_Analysis/05f_TF_f0StimTrains/';

allFiles = dir([loadF0StimTrainPath,'*.set']);

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


for condition = 1:4
    if condition == 1
        loadName = visConSubs;

    elseif condition == 2
        loadName = visTapSubs;       

    elseif condition == 3
        loadName = audConSubs;
        
    elseif condition == 4
        loadName = audTapSubs;

    end

    for subIDX = 1:length(visTapIndex)
        
        
        % load Wide epoched data for F0 t/f calculations
        EEG = pop_loadset('filename',char(loadName(subIDX)),...
            'filepath',loadF0StimTrainPath);
        
        numComps = size(EEG.icaweights,1);

        data.Epochs = EEG.epoch;

        data.filename = char(loadName(subIDX));     
        
        data.Events = EEG.event;
        
        data.EEG_Times = EEG.times;

        data.MuComps = EEG.mu;
        
        for compIDX = 1:numComps
            
            %% Calculate F0 T/F Data
            
            f0Freqs = 1.0666:0.1:8.0666; % Frequencies used

            % perform t/f on control condition for F0 
            [ersp,itc,powbase,times,freqs,erspboot,itcboot,tfdata] = newtimef(EEG.icaact(compIDX,:,:),...
            EEG.pnts,[EEG.xmin EEG.xmax]*1000, EEG.srate,... 
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
            data.f0(compIDX).tfdata = tfdata;
            data.f0Times = times;
            data.f0Freqs = freqs;

            clear ersp itc powbase times freqs erspboot itcboot tfdata
            
            
        end


        
        %% Save output files for later plotting
               
        % Save control data
        savename = data.filename(1:end-4);
        fullsavedata = [saveF0DataPath savename];
        TF_data = data;
        save(fullsavedata, 'TF_data');
        clear data
         


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

       