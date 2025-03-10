%% Individual Stimulus TFA for Mu to Beta

%% load Data
close
clear
clc


loadMuBetaEpochPath = '/Users/dccomsto/Projekts/AV_TapNoTap/Data/Revision1_Analysis/04c_Epoch_IndStims/AllComps/';
saveMuBetaDataPath = '/Users/dccomsto/Projekts/AV_TapNoTap/Data/Revision1_Analysis/05a_TF_IndStimTrain/';


allFiles = dir([loadMuBetaEpochPath,'*.set']);

% Get file name lists for each condition
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
        
        % load epoched data for Mu and Beta t/f calculations
        EEG_Con = pop_loadset('filename',char(controlLoadNames(subIDX)),...
            'filepath',loadMuBetaEpochPath);

        EEG_Tap = pop_loadset('filename',char(tapLoadNames(subIDX)),...
            'filepath',loadMuBetaEpochPath);
        
        numComps = size(EEG_Con.icaweights,1);
        
        dataC.filename = char(controlLoadNames(subIDX));
        dataT.filename = char(tapLoadNames(subIDX));      
        
        dataC.Events = EEG_Con.event;
        dataT.Events = EEG_Tap.event;
        
        dataC.Times = EEG_Con.times;
        dataT.Times = EEG_Tap.times;

        dataC.MuComps = EEG_Con.mu;
        dataT.MuComps = EEG_Tap.mu;

        
        for compIDX = 1:numComps
            
            %% Mu and Beta t/f calculations
            
            % perform t/f with common baseline from 8 to 35 Hz 
            [ersp,itc,powbase,times,freqs,erspboot,itcboot,tfdata] = newtimef({EEG_Con.icaact(compIDX,:,:)...
            EEG_Tap.icaact(compIDX,:,:)},EEG_Con.pnts,[EEG_Con.xmin EEG_Con.xmax]*1000, EEG_Con.srate,... 
            'cycles', [4 0], 'padratio',2, 'ntimesout', 625, 'baseline', [-1500 1496],'freqs', [8 35],...
            'freqscale', 'linear','plotphasesign','off', 'plotersp','off', 'plotitc','off','commonbase','off');
        
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
            dataC_ComBasTF.MuBetaCom(compIDX).ersp = cell2mat(ersp(1));
            dataC_ComBasTF.MuBetaCom(compIDX).itc = cell2mat(itc(1));
            dataC_ComBasTF.MuBetaCom(compIDX).powbase = cell2mat(powbase(1));
            dataC_ComBasTF.MuBetaCom(compIDX).tfdata = cell2mat(tfdata(1));
            
            dataC_ComBasTF.MuBetaTimes = times;
            dataC_ComBasTF.MuBetaFreqs = freqs;

            dataT_ComBasTF.MuBetaCom(compIDX).ersp = cell2mat(ersp(2));
            dataT_ComBasTF.MuBetaCom(compIDX).itc = cell2mat(itc(2));
            dataT_ComBasTF.MuBetaCom(compIDX).powbase = cell2mat(powbase(2));
            dataT_ComBasTF.MuBetaCom(compIDX).tfdata = cell2mat(tfdata(1));

            dataT_ComBasTF.MuBetaTimes = times;
            dataT_ComBasTF.MuBetaFreqs = freqs;
            
            clear ersp itc powbase times freqs erspboot itcboot tfdata
            
            % perform t/f on control condition with individual baseline from 8 to 35 Hz 
            [ersp,itc,powbase,times,freqs,erspboot,itcboot,tfdata] = newtimef(EEG_Con.icaact(compIDX,:,:),...
            EEG_Con.pnts,[EEG_Con.xmin EEG_Con.xmax]*1000, EEG_Con.srate,... 
            'cycles', [4 0], 'padratio',2, 'ntimesout', 625, 'baseline', [-1500 1496],'freqs', [8 35],...
            'freqscale', 'linear','plotphasesign','off', 'plotersp','off', 'plotitc','off');
   
            % store data
            dataC_IndBasTF.MuBetaInd(compIDX).ersp = ersp;
            dataC_IndBasTF.MuBetaInd(compIDX).itc = itc;
            dataC_IndBasTF.MuBetaInd(compIDX).powbase = powbase;
            dataC_IndBasTF.MuBetaInd(compIDX).tfdata = tfdata;
            
            % Compute and store ERSP without baseline data
            % Not needed. Can be calculated at need from tfdata to save space.
            % dataC.MuBetaNoBase(compIDX).ersp = 10*log10(mean(abs(tfdata).^2,3));
            
            clear ersp itc powbase times freqs erspboot itcboot tfdata
            
            % perform t/f on tap condition with individual baseline from 8 to 35 Hz 
            [ersp,itc,powbase,times,freqs,erspboot,itcboot,tfdata] = newtimef(EEG_Tap.icaact(compIDX,:,:),...
            EEG_Tap.pnts,[EEG_Tap.xmin EEG_Tap.xmax]*1000, EEG_Tap.srate,... 
            'cycles', [4 0], 'padratio',2, 'ntimesout', 625, 'baseline', [-1500 1496],'freqs', [8 35],...
            'freqscale', 'linear','plotphasesign','off', 'plotersp','off', 'plotitc','off');

            % store data
            dataT_IndBasTF.MuBetaInd(compIDX).ersp = ersp;
            dataT_IndBasTF.MuBetaInd(compIDX).itc = itc;
            dataT_IndBasTF.MuBetaInd(compIDX).powbase = powbase;
            dataT_IndBasTF.MuBetaInd(compIDX).tfdata = tfdata;
           
            % Compute and store ERSP without baseline data
            % Not needed. Can be calculated at need from tfdata to save space.
            % dataT.MuBetaNoBase(compIDX).ersp = 10*log10(mean(abs(tfdata).^2,3));
            
            clear ersp itc powbase times freqs erspboot itcboot tfdata

            
        end

        clear EEG_Con EEG_Tap
        
        %% Save output files for later plotting
        
        % Save control combined baseline data
        savename = dataC.filename(1:end-4);
        fullsavedata = [saveMuBetaDataPath savename '_ComBase'];

        TF_data.filename = dataC.filename;          
        TF_data.Events = dataC.Events;
        TF_data.Times = dataC.Times;
        TF_data.MuComps = dataC.MuComps;
        TF_data.MuBetaTimes = dataC_ComBasTF.MuBetaTimes;
        TF_data.MuBetaFreqs = dataC_ComBasTF.MuBetaFreqs;
        
        for compIDX = 1:numComps
            TF_data.data(compIDX).ersp = dataC_ComBasTF.MuBetaCom(compIDX).ersp;
            TF_data.data(compIDX).itc = dataC_ComBasTF.MuBetaCom(compIDX).itc;
            TF_data.data(compIDX).powbase = dataC_ComBasTF.MuBetaCom(compIDX).powbase;
            TF_data.data(compIDX).tfdata = dataC_ComBasTF.MuBetaCom(compIDX).tfdata;
        end

        save(fullsavedata, 'TF_data');
        
        %Save control individual baseline data
        savename = dataC.filename(1:end-4);
        fullsavedata = [saveMuBetaDataPath savename '_IndBase'];

        for compIDX = 1:numComps
            TF_data.data(compIDX).ersp = dataC_IndBasTF.MuBetaInd(compIDX).ersp;
            TF_data.data(compIDX).itc = dataC_IndBasTF.MuBetaInd(compIDX).itc;
            TF_data.data(compIDX).powbase = dataC_IndBasTF.MuBetaInd(compIDX).powbase;
            TF_data.data(compIDX).tfdata = dataC_IndBasTF.MuBetaInd(compIDX).tfdata;
        end

        save(fullsavedata, 'TF_data');
        
        % Save tap combined baseline data
        
        savename = dataT.filename(1:end-4);
        fullsavedata = [saveMuBetaDataPath savename '_ComBase'];
        
        TF_data.filename = dataT.filename;          
        TF_data.Events = dataT.Events;
        TF_data.Times = dataT.Times;
        TF_data.MuComps = dataT.MuComps;
        TF_data.MuBetaTimes = dataT_ComBasTF.MuBetaTimes;
        TF_data.MuBetaFreqs = dataT_ComBasTF.MuBetaFreqs;

        for compIDX = 1:numComps
            TF_data.data(compIDX).ersp = dataT_ComBasTF.MuBetaCom(compIDX).ersp;
            TF_data.data(compIDX).itc = dataT_ComBasTF.MuBetaCom(compIDX).itc;
            TF_data.data(compIDX).powbase = dataT_ComBasTF.MuBetaCom(compIDX).powbase;
            TF_data.data(compIDX).tfdata = dataT_ComBasTF.MuBetaCom(compIDX).tfdata;
        end

        save(fullsavedata, 'TF_data');
        
        % Save tap individual baseline data
        
        savename = dataT.filename(1:end-4);
        fullsavedata = [saveMuBetaDataPath savename '_IndBase'];

        for compIDX = 1:numComps
            TF_data.data(compIDX).ersp = dataT_IndBasTF.MuBetaInd(compIDX).ersp;
            TF_data.data(compIDX).itc = dataT_IndBasTF.MuBetaInd(compIDX).itc;
            TF_data.data(compIDX).powbase = dataT_IndBasTF.MuBetaInd(compIDX).powbase;
            TF_data.data(compIDX).tfdata = dataT_IndBasTF.MuBetaInd(compIDX).tfdata;
        end
        save(fullsavedata, 'TF_data');

        clear TF_data dataT_IndBasTF dataT_ComBasTF dataC_IndBasTF dataC_ComBasTF
        
       


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

       