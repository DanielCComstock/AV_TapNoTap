
loadPath = '/Users/dcc/Data/AV_TapNoTap/Data/Revision1_Analysis/05a_TF_IndStims/';
savePath = '/Users/dcc/Data/AV_TapNoTap/Data/Revision1_Analysis/05e_IndStims_Beta_ERSP_PlotData/';



allFiles = dir([loadPath,'*IndBase.mat']);

% Get file name lists for each condition
allFileNames = {allFiles.name}';

visList = strfind(allFileNames, 'Vis');
visIndex = find(~cellfun('isempty', visList));
visSubs = allFileNames(visIndex);
visTapList = strfind(visSubs, 'Vis_Tap');
visTapIndex = find(~cellfun('isempty', visTapList)); % Obtain the index numbers of the 'vis tap' subjects.
visTapSubs = visSubs(visTapIndex);
visConIndex = find(cellfun('isempty', visTapList));
visConSubs = string(visSubs(visConIndex));

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

    for subIDX = 1:length(loadName)
        
        
        fullLoad = [loadPath char(loadName(subIDX))];

        load(fullLoad);

        % Get mu component indexes
        leftMuIDX = TF_data.MuComps.left;
        rightMuIDX = TF_data.MuComps.right;

        times = TF_data.MuBetaTimes;
        freqs = TF_data.MuBetaFreqs;

        % extract ERSPs 



        if condition == 1
            VisConLeftERSP(:,:,subIDX) = TF_data.data(leftMuIDX).ersp;
            VisConRightERSP(:,:,subIDX) = TF_data.data(rightMuIDX).ersp;
        elseif condition == 2
            VisTapLeftERSP(:,:,subIDX) = TF_data.data(leftMuIDX).ersp;
            VisTapRightERSP(:,:,subIDX) = TF_data.data(rightMuIDX).ersp;
        elseif condition == 3
            AudConLeftERSP(:,:,subIDX) = TF_data.data(leftMuIDX).ersp;
            AudConRightERSP(:,:,subIDX) = TF_data.data(rightMuIDX).ersp;
        elseif condition == 4
            AudTapLeftERSP(:,:,subIDX) = TF_data.data(leftMuIDX).ersp;
            AudTapRightERSP(:,:,subIDX) = TF_data.data(rightMuIDX).ersp;
        end



    end
end

%% rough plots

figure(1), imagesc(times, freqs, mean(AudConLeftERSP,3));
figure(2), imagesc(times, freqs, mean(VisConLeftERSP,3));
figure(3), imagesc(times, freqs, mean(AudTapLeftERSP,3));
figure(4), imagesc(times, freqs, mean(VisTapLeftERSP,3));
figure(5), imagesc(times, freqs, mean(AudConRightERSP,3));
figure(6), imagesc(times, freqs, mean(VisConRightERSP,3));
figure(7), imagesc(times, freqs, mean(AudTapRightERSP,3));
figure(7), imagesc(times, freqs, mean(VisTapRightERSP,3));
