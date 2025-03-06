%% Meta Data

% get subject IDs
loadPath = '/Users/dcc/Data/AV_TapNoTap/Data/Revision1_Analysis/06d_f0ITCStimTrainStatsPlotTransformed/';
load([loadPath 'ITC_AvgAll_Aud_Con.mat'],'subIDKey');
subIDKey = subIDKey';
% get musician status
musicianKey = [1 1 0 0 1 0 0 0 1 1 1 1 1 0 0 0 0 0]';


%% ITC f0 data
% grab avg ITC data at f0 for each subject from
% 07b_f0ITC_StimTrainPlots/data
% conditions in statsData: 1 = Aud Con, 2 = Aud Tap, 3 = Vis Con, 4 = Vis
% Tap

loadPath = '/Users/dcc/Data/AV_TapNoTap/Data/Revision1_Analysis/07b_f0ITC_StimtrainPlots/data/';

% load left motor data
load([loadPath 'ITC_LeftMotor.mat']);

% get freq of interest index
f0IDX = find([statsData.freqs] == 1.6666);

fIDXs = [7 22 23 40 41 57];
allPlotFreqIDXs = 1:61;
temp = [];
for IDX = 1:length(fIDXs)
    temp = [temp fIDXs(IDX)-4:fIDXs(IDX)+4];
end
avoidIDXs = unique(temp)';
temp2 = allPlotFreqIDXs;
temp2(avoidIDXs) = 0;
rSampIDXs = randsample(find(temp2),18)';
% temp3 = randsample(samplePoolIDXs,18);


AudConLeftITCf0 = statsData.indITCData(f0IDX,:,1)';

AudTapLeftITCf0 = statsData.indITCData(f0IDX,:,2)';

VisConLeftITCf0 = statsData.indITCData(f0IDX,:,3)';

VisTapLeftITCf0 = statsData.indITCData(f0IDX,:,4)';

AudConLeftITCrSamp = mean(statsData.indITCData(rSampIDXs,:,1),1)';

AudTapLeftITCrSamp = mean(statsData.indITCData(rSampIDXs,:,2),1)';

VisConLeftITCrSamp = mean(statsData.indITCData(rSampIDXs,:,3),1)';

VisTapLeftITCrSamp = mean(statsData.indITCData(rSampIDXs,:,4),1)';

% load right motor data
load([loadPath 'ITC_RightMotor.mat']);

AudConRightITCf0 = statsData.indITCData(f0IDX,:,1)';

AudTapRightITCf0 = statsData.indITCData(f0IDX,:,2)';

VisConRightITCf0 = statsData.indITCData(f0IDX,:,3)';

VisTapRightITCf0 = statsData.indITCData(f0IDX,:,4)';

AudConRightITCrSamp = mean(statsData.indITCData(rSampIDXs,:,1),1)';

AudTapRightITCrSamp = mean(statsData.indITCData(rSampIDXs,:,2),1)';

VisConRightITCrSamp = mean(statsData.indITCData(rSampIDXs,:,3),1)';

VisTapRightITCrSamp = mean(statsData.indITCData(rSampIDXs,:,4),1)';

% load component Avg data
load([loadPath 'ITC_AvgAll.mat']);

AudConAvgITCf0 = statsData.indITCData(f0IDX,:,1)';

AudTapAvgITCf0 = statsData.indITCData(f0IDX,:,2)';

VisConAvgITCf0 = statsData.indITCData(f0IDX,:,3)';

VisTapAvgITCf0 = statsData.indITCData(f0IDX,:,4)';

AudConAvgITCrSamp = mean(statsData.indITCData(rSampIDXs,:,1),1)';

AudTapAvgITCrSamp = mean(statsData.indITCData(rSampIDXs,:,2),1)';

VisConAvgITCrSamp = mean(statsData.indITCData(rSampIDXs,:,3),1)';

VisTapAvgITCrSamp = mean(statsData.indITCData(rSampIDXs,:,4),1)';


%% Create table & save as CSV (wide format)

allStatsDataWide = table(subIDKey, musicianKey,...
    AudConLeftITCf0, AudTapLeftITCf0, VisConLeftITCf0, VisTapLeftITCf0,...
    AudConLeftITCrSamp, AudTapLeftITCrSamp, VisConLeftITCrSamp, VisTapLeftITCrSamp,...
    AudConRightITCf0, AudTapRightITCf0, VisConRightITCf0, VisTapRightITCf0,...
    AudConRightITCrSamp, AudTapRightITCrSamp, VisConRightITCrSamp, VisTapRightITCrSamp,...
    AudConAvgITCf0, AudTapAvgITCf0, VisConAvgITCf0, VisTapAvgITCf0,...
    AudConAvgITCrSamp, AudTapAvgITCrSamp, VisConAvgITCrSamp, VisTapAvgITCrSamp);

%Save mat file
savePath = '/Users/dcc/Data/AV_TapNoTap/Data/Revision1_Analysis/08_StatsData/';
save([savePath 'ITC_TTestRSampData.mat'],'allStatsDataWide');

% Write as csv file
writetable(allStatsDataWide,[savePath 'ITC_TTestRSampData.csv']);

