
%% load Data
close
clear
clc


loadBasePath = '/Users/dcc/Data/AV_TapNoTap/Data/Revision1_Analysis/04b_Epoch_Baseline/AllComps/';
loadStimTrainPath = '/Users/dcc/Data/AV_TapNoTap/Data/Revision1_Analysis/04a_Epoch_StimTrains/AllComps/';
saveMuBasePath = '/Users/dcc/Data/AV_TapNoTap/Data/Revision1_Analysis/05b_TF_MuStimTrainBaseLines/';
saveMuStimTrainPath = '/Users/dcc/Data/AV_TapNoTap/Data/Revision1_Analysis/05c_TF_MuStimTrain/';
saveMuERSPPlotDataPath = '/Users/dcc/Data/AV_TapNoTap/Data/Revision1_Analysis/05d_TF_MuERSP_PlotData/';


allFiles = dir([loadBasePath,'*.set']);

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
        
        % load baseline data
        EEG_Base = pop_loadset('filename',char(loadName(subIDX)),...
            'filepath',loadBasePath);

        EEG_StimTrain = pop_loadset('filename',char(loadName(subIDX)),...
            'filepath',loadStimTrainPath);
        
        numComps = size(EEG_Base.icaweights,1);
        
        dataB.filename = char(loadName(subIDX));
        dataM.filename = char(loadName(subIDX));      
        
        dataB.Events = EEG_Base.event;
        dataM.Events = EEG_StimTrain.event;
        
        dataB.EEG_Times = EEG_Base.times;
        dataM.EEG_Times = EEG_StimTrain.times;

        dataB.MuComps = EEG_Base.mu;
        dataM.MuComps = EEG_StimTrain.mu;

            
        %% Mu Baseline t/f calculations
        
        muFreqs = 7:0.25:15;

        % perform t/f with common baseline from ~7 to ~14 Hz using FFT
        [ersp,itc,powbase,times,freqs,erspboot,itcboot,tfdata] = newtimef(EEG_Base.icaact(EEG_Base.mu.left,:,:),...
         EEG_Base.pnts,[EEG_Base.xmin EEG_Base.xmax]*1000, EEG_Base.srate, ... 
        'cycles', 0, 'winsize',256, 'ntimesout', 400, 'baseline', [EEG_Base.xmin EEG_Base.xmax]*1000,'freqs', [7 15],'padratio', 4,...
        'freqscale', 'linear','plotphasesign','off', 'plotersp','off', 'plotitc','off','commonbase','off');

        % Read out information from above parameters:
            % Computing Event-Related Spectral Perturbation (ERSP) and
            %   Inter-Trial Phase Coherence (ITC) images based on 3 trials
            %   of 1280 frames sampled at 256 Hz.
            % Each trial contains samples from -5000 ms before to
            %   -4 ms after the timelocking event.
            %   Image frequency direction: normal
            % Using hanning FFT tapering
            % Generating 400 time points (-4500.0 to -503.9 ms)
            % Finding closest points for time variable
            % Time values for time/freq decomposition is not perfectly uniformly distributed
            % The window size used is 256 samples (1000 ms) wide.
            % Estimating 33 linear-spaced frequencies from 7.0 Hz to 15.0 Hz.
            
        % store data into dataC for control and dataT for Tap
        dataB.leftMu.ersp =  ersp;
        dataB.leftMu.itc = itc;
        dataB.leftMu.powbase = powbase;
        dataB.leftMu.tfdata = tfdata;
        
        dataB.leftMu.ERSPtimes = times;
        dataB.leftMu.ERSPfreqs = freqs;

        clear ersp itc powbase times freqs erspboot itcboot tfdata

        % perform t/f for baseline from ~7 to ~14 Hz using FFT
        [ersp,itc,powbase,times,freqs,erspboot,itcboot,tfdata] = newtimef(EEG_Base.icaact(EEG_Base.mu.right,:,:),...
         EEG_Base.pnts,[EEG_Base.xmin EEG_Base.xmax]*1000, EEG_Base.srate, ... 
        'cycles', 0, 'winsize', 256, 'ntimesout', 400, 'baseline', [EEG_Base.xmin EEG_Base.xmax]*1000,'freqs', [7 15],'padratio', 4,...
        'freqscale', 'linear','plotphasesign','off', 'plotersp','off', 'plotitc','off','commonbase','off');

        dataB.rightMu.ersp =  ersp;
        dataB.rightMu.itc = itc;
        dataB.rightMu.powbase = powbase;
        dataB.rightMu.tfdata = tfdata;
        
        dataB.rightMu.ERSPtimes = times;
        dataB.rightMu.ERSPfreqs = freqs;



        
        clear ersp itc powbase times freqs erspboot itcboot tfdata
        
        % perform t/f on stimtrains from ~7 to ~14 Hz using FFT
        % using the baseline above
        % note use actual freq list instead of padratio. 
        [ersp,itc,powbase,times,freqs,erspboot,itcboot,tfdata] = newtimef(EEG_StimTrain.icaact(EEG_StimTrain.mu.left,:,:),...
         EEG_StimTrain.pnts,[EEG_StimTrain.xmin EEG_StimTrain.xmax]*1000, EEG_StimTrain.srate, ... 
        'cycles', 0, 'winsize', 512, 'ntimesout', 2080, 'powbase', dataB.leftMu.powbase,'freqs', muFreqs,...
        'freqscale', 'linear','plotphasesign','off', 'plotersp','off', 'plotitc','off','commonbase','off');

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
         EEG_StimTrain.pnts,[EEG_StimTrain.xmin EEG_StimTrain.xmax]*1000, EEG_StimTrain.srate, ... 
        'cycles', 0, 'winsize', 512, 'ntimesout', 2080, 'powbase', dataB.rightMu.powbase,'freqs', muFreqs,...
        'freqscale', 'linear','plotphasesign','off', 'plotersp','off', 'plotitc','off','commonbase','off');


        % store data
        dataM.rightMu.ersp = ersp;
        dataM.rightMu.itc = itc;
        dataM.rightMu.powbase = powbase;
        dataM.rightMu.tfdata = tfdata;

        dataM.rightMu.ERSPtimes = times;
        dataM.rightMu.ERSPfreqs = freqs;

        clear ersp itc powbase times freqs erspboot itcboot tfdata

        %% Store ERSP data directly for plots
        MuBaseTimes = dataB.rightMu.ERSPtimes;
        MuBaseFreqs = dataB.rightMu.ERSPfreqs;
        MuStimTrainTimes = dataM.rightMu.ERSPtimes;
        MuStimTrainFreqs = dataM.rightMu.ERSPfreqs;
        if condition == 1
            VisConLeftBaseERSP(:,:,subIDX) = dataB.leftMu.ersp;
            VisConRightBaseERSP(:,:,subIDX) = dataB.rightMu.ersp;
            VisConLeftERSP(:,:,subIDX) = dataM.leftMu.ersp;
            VisConRightERSP(:,:,subIDX) = dataM.rightMu.ersp;
        elseif condition == 2
            VisTapLeftBaseERSP(:,:,subIDX) = dataB.leftMu.ersp;
            VisTapRightBaseERSP(:,:,subIDX) = dataB.rightMu.ersp;
            VisTapLeftERSP(:,:,subIDX) = dataM.leftMu.ersp;
            VisTapRightERSP(:,:,subIDX) = dataM.rightMu.ersp;
        elseif condition == 3
            AudConLeftBaseERSP(:,:,subIDX) = dataB.leftMu.ersp;
            AudConRightBaseERSP(:,:,subIDX) = dataB.rightMu.ersp;
            AudConLeftERSP(:,:,subIDX) = dataM.leftMu.ersp;
            AudConRightERSP(:,:,subIDX) = dataM.rightMu.ersp;
        elseif condition == 4
            AudTapLeftBaseERSP(:,:,subIDX) = dataB.leftMu.ersp;
            AudTapRightBaseERSP(:,:,subIDX) = dataB.rightMu.ersp;
            AudTapLeftERSP(:,:,subIDX) = dataM.leftMu.ersp;
            AudTapRightERSP(:,:,subIDX) = dataM.rightMu.ersp;
        end
        

        
        %% Save output data files for later plotting and statistics
        
        % Save control combined baseline data
        savename = dataB.filename(1:end-4);
        fullsavedata = [saveMuBasePath savename '_MuBaseLine'];

        save(fullsavedata, 'dataB');
        
        %Save control individual baseline data
        savename = dataM.filename(1:end-4);
        fullsavedata = [saveMuStimTrainPath savename '_MuStimTrain'];

        save(fullsavedata, 'dataM');
        
        clear dataM dataB
        
      
    end

end

    %% Save output ERSP plotting data

    fullsavedata = [saveMuERSPPlotDataPath 'MuERSP_VisCon'];
    save(fullsavedata, 'MuBaseTimes','MuBaseFreqs','MuStimTrainTimes','MuStimTrainFreqs',...
        'VisConLeftBaseERSP','VisConRightBaseERSP','VisConLeftERSP','VisConRightERSP');

    fullsavedata = [saveMuERSPPlotDataPath 'MuERSP_VisTap'];
    save(fullsavedata, 'MuBaseTimes','MuBaseFreqs','MuStimTrainTimes','MuStimTrainFreqs',...
        'VisTapLeftBaseERSP','VisTapRightBaseERSP','VisTapLeftERSP','VisTapRightERSP');

    fullsavedata = [saveMuERSPPlotDataPath 'MuERSP_AudCon'];
    save(fullsavedata, 'MuBaseTimes','MuBaseFreqs','MuStimTrainTimes','MuStimTrainFreqs',...
        'AudConLeftBaseERSP','AudConRightBaseERSP','AudConLeftERSP','AudConRightERSP');

    fullsavedata = [saveMuERSPPlotDataPath 'MuERSP_AudTap'];
    save(fullsavedata, 'MuBaseTimes','MuBaseFreqs','MuStimTrainTimes','MuStimTrainFreqs',...
        'AudTapLeftBaseERSP','AudTapRightBaseERSP','AudTapLeftERSP','AudTapRightERSP');

% these two are equivalent
% figure(1);
% imagesc(TF_data.f0(1).ersp);
% colormap jet;
% 
% figure(2);
% imagesc(10*log10(mean(abs(TF_data.f0(1).tfdata).^2,3)));
% colormap jet;

figure;
imagesc(mean(AudConLeftERSP,3))
colormap jet;

