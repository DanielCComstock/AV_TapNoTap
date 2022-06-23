
%% load Data
close
clear
clc


loadStimTrainPath = '/Users/dcc/Data/AV_TapNoTap/Data/Revision1_Analysis/04d_Epoch_StimTrainsWBaseline/AllComps/';
saveMuStimTrainPath = '/Users/dcc/Data/AV_TapNoTap/Data/Revision1_Analysis/05f_TF_FullStimTrainNewBase/';
saveMuERSPPlotDataPath = '/Users/dcc/Data/AV_TapNoTap/Data/Revision1_Analysis/06f_TF_MuERSP_PlotData/';


allFiles = dir([loadStimTrainPath,'*.set']);

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



for condition = 1:4
    if condition == 1
        loadName = visConSubs;
        VisConLeftERSP = [];
        VisConLeftBaseERSP = [];
        VisConRightERSP = [];
        VisConRightBaseERSP = [];

    elseif condition == 2
        loadName = visTapSubs;
        

    elseif condition == 3
        loadName = audConSubs;
        AudConLeftERSP = [];
        AudConLeftBaseERSP = [];
        AudConRightERSP = [];
        AudConRightBaseERSP = [];
        
    elseif condition == 4
        loadName = audTapSubs;
        AudTapLeftERSP = [];
        AudTapLeftBaseERSP = [];
        AudTapRightERSP = [];
        AudTapRightBaseERSP = [];

    end

    for subIDX = 1:length(loadName)
        
        % load data
        EEG_StimTrain = pop_loadset('filename',char(loadName(subIDX)),...
            'filepath',loadStimTrainPath);
        
        numComps = size(EEG_StimTrain.icaweights,1);
        
        dataM.filename = char(loadName(subIDX));      
        
        dataM.Events = EEG_StimTrain.event;

        dataM.EEG_Times = EEG_StimTrain.times;

        dataM.MuComps = EEG_StimTrain.mu;

            
       
%% TF calculations
        
        % perform t/f on stimtrains from ~7 to ~14 Hz using FFT
        % using the baseline above
        % note use actual freq list instead of padratio. 
        [ersp,itc,powbase,times,freqs,erspboot,itcboot,tfdata] = newtimef(EEG_StimTrain.icaact(EEG_StimTrain.mu.left,:,:),...
         EEG_StimTrain.pnts,[EEG_StimTrain.xmin EEG_StimTrain.xmax]*1000, EEG_StimTrain.srate, 'cycles',0,... 
         'winsize',512, 'ntimesout',-50, 'baseline',[EEG_StimTrain.xmin*1000 -600], 'freqs', [7 30], 'padratio',4,...
        'freqscale','linear', 'plotphasesign','off', 'plotersp','off', 'plotitc','off','commonbase','off');

        % Read out information from above parameters:
            % Computing Event-Related Spectral Perturbation (ERSP) and
            %   Inter-Trial Phase Coherence (ITC) images based on 3 trials
            %   of 5837 frames sampled at 256 Hz.
            % Each trial contains samples from 0 ms before to
            %   22797 ms after the timelocking event.
            %   Image frequency direction: normal
            % Using hanning FFT tapering
            % Generating 2180 time points (1000.0 to 21796.9 ms)
            % Finding closest points for time variable
            % Time values for time/freq decomposition is not perfectly uniformly distributed
            % The window size used is 512 samples (2000 ms) wide.
            % Estimating 33 linear-spaced frequencies from 7.0 Hz to 15.0 Hz.

        % store data
        dataM.leftMu.ersp = ersp;
        dataM.leftMu.itc = itc;
        dataM.leftMu.powbase = powbase;
        dataM.leftMu.tfdata = tfdata;

        dataM.leftMu.ERSPtimes = times;
        dataM.leftMu.ERSPfreqs = freqs;
        
        % Compute and store ERSP without baseline data
        % Not needed. Can be calculated at need from tfdata to save space.
        % dataM.compTFData(compIDX).erspNoBase = 10*log10(mean(abs(tfdata).^2,3));
        
        clear ersp itc powbase times freqs erspboot itcboot tfdata

        [ersp,itc,powbase,times,freqs,erspboot,itcboot,tfdata] = newtimef(EEG_StimTrain.icaact(EEG_StimTrain.mu.right,:,:),...
         EEG_StimTrain.pnts,[EEG_StimTrain.xmin EEG_StimTrain.xmax]*1000, EEG_StimTrain.srate, 'cycles',0,... 
         'winsize',512, 'ntimesout',-50, 'baseline',[EEG_StimTrain.xmin*1000 -600], 'freqs', [7 30], 'padratio',4,...
        'freqscale','linear', 'plotphasesign','off', 'plotersp','off', 'plotitc','off','commonbase','off');


        % store data
        dataM.rightMu.ersp = ersp;
        dataM.rightMu.itc = itc;
        dataM.rightMu.powbase = powbase;
        dataM.rightMu.tfdata = tfdata;

        dataM.rightMu.ERSPtimes = times;
        dataM.rightMu.ERSPfreqs = freqs;

        clear ersp itc powbase times freqs erspboot itcboot tfdata

        %% Store ERSP data directly for plots
        MuStimTrainTimes = dataM.rightMu.ERSPtimes;
        MuStimTrainFreqs = dataM.rightMu.ERSPfreqs;
        if condition == 1
            VisConLeftERSP(:,:,subIDX) = dataM.leftMu.ersp;
            VisConRightERSP(:,:,subIDX) = dataM.rightMu.ersp;
        elseif condition == 2
            VisTapLeftERSP(:,:,subIDX) = dataM.leftMu.ersp;
            VisTapRightERSP(:,:,subIDX) = dataM.rightMu.ersp;
        elseif condition == 3
            AudConLeftERSP(:,:,subIDX) = dataM.leftMu.ersp;
            AudConRightERSP(:,:,subIDX) = dataM.rightMu.ersp;
        elseif condition == 4
            AudTapLeftERSP(:,:,subIDX) = dataM.leftMu.ersp;
            AudTapRightERSP(:,:,subIDX) = dataM.rightMu.ersp;
        end
        

        
        %% Save output data files for later plotting and statistics
        
        
        %Save control individual baseline data
        savename = dataM.filename(1:end-4);
        fullsavedata = [saveMuStimTrainPath savename '_FullStimTrain'];

        save(fullsavedata, 'dataM');
        
        clear dataM 
        
      
    end

end

    %% Save output ERSP plotting data

    fullsavedata = [saveMuERSPPlotDataPath 'MuERSP_VisCon'];
    save(fullsavedata,'MuStimTrainTimes','MuStimTrainFreqs','VisConLeftERSP','VisConRightERSP');

    fullsavedata = [saveMuERSPPlotDataPath 'MuERSP_VisTap'];
    save(fullsavedata,'MuStimTrainTimes','MuStimTrainFreqs','VisTapLeftERSP','VisTapRightERSP');

    fullsavedata = [saveMuERSPPlotDataPath 'MuERSP_AudCon'];
    save(fullsavedata,'MuStimTrainTimes','MuStimTrainFreqs','AudConLeftERSP','AudConRightERSP');

    fullsavedata = [saveMuERSPPlotDataPath 'MuERSP_AudTap'];
    save(fullsavedata, 'MuStimTrainTimes','MuStimTrainFreqs','AudTapLeftERSP','AudTapRightERSP');

% these two are equivalent
% figure(1);
% imagesc(TF_data.f0(1).ersp);
% colormap jet;
% 
% figure(2);
% imagesc(10*log10(mean(abs(TF_data.f0(1).tfdata).^2,3)));
% colormap jet;
% 
% figure;
% imagesc(mean(AudConLeftERSP,3))
% colormap jet;

