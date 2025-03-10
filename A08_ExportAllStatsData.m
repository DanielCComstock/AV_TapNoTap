% Data transformation log
% Data convention is sub (row) x data (column)
%% Meta Data

% get subject IDs
loadPath = '/Users/dcc/Data/AV_TapNoTap/Data/Revision1_Analysis/06d_f0ITCStimTrainStatsPlotTransformed/';
load([loadPath 'ITC_AvgAll_Aud_Con.mat'],'subIDKey');
subIDKey = subIDKey';
% get musician status
musicianKey = [1 1 0 0 1 0 0 0 1 1 1 1 1 0 0 0 0 0]';

%% Mu data
% Grab avg mu band data (8-13 Hz) for each subject from
% 06f_TF_MuERSP_PlotData

loadPath = '/Users/dcc/Data/AV_TapNoTap/Data/Revision1_Analysis/06f_TF_MuERSP_PlotData/';
load([loadPath 'MuERSP_AudCon.mat']);
load([loadPath 'MuERSP_AudTap.mat']);
load([loadPath 'MuERSP_VisCon.mat']);
load([loadPath 'MuERSP_VisTap.mat']);
% get Indices for desired freqs and times

MuFreqIDXs = find(MuStimTrainFreqs >= 8 & MuStimTrainFreqs <= 13);
MuTimeIDXs = find(MuStimTrainTimes >= 0);

% average mu data across range in freq, then in time for each condition

temp = AudConLeftERSP(MuFreqIDXs,MuTimeIDXs,:);
AudConLeftMuAvg = mean(squeeze(mean(temp,1)),1)';

temp = AudTapLeftERSP(MuFreqIDXs,MuTimeIDXs,:);
AudTapLeftMuAvg = mean(squeeze(mean(temp,1)),1)';

temp = VisConLeftERSP(MuFreqIDXs,MuTimeIDXs,:);
VisConLeftMuAvg = mean(squeeze(mean(temp,1)),1)';

temp = VisTapLeftERSP(MuFreqIDXs,MuTimeIDXs,:);
VisTapLeftMuAvg = mean(squeeze(mean(temp,1)),1)';

temp = AudConRightERSP(MuFreqIDXs,MuTimeIDXs,:);
AudConRightMuAvg = mean(squeeze(mean(temp,1)),1)';

temp = AudTapRightERSP(MuFreqIDXs,MuTimeIDXs,:);
AudTapRightMuAvg = mean(squeeze(mean(temp,1)),1)';

temp = VisConRightERSP(MuFreqIDXs,MuTimeIDXs,:);
VisConRightMuAvg = mean(squeeze(mean(temp,1)),1)';

temp = VisTapRightERSP(MuFreqIDXs,MuTimeIDXs,:);
VisTapRightMuAvg = mean(squeeze(mean(temp,1)),1)';


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

AudConLeftITCf0 = statsData.indITCData(f0IDX,:,1)';

AudTapLeftITCf0 = statsData.indITCData(f0IDX,:,2)';

VisConLeftITCf0 = statsData.indITCData(f0IDX,:,3)';

VisTapLeftITCf0 = statsData.indITCData(f0IDX,:,4)';

% load right motor data
load([loadPath 'ITC_RightMotor.mat']);

AudConRightITCf0 = statsData.indITCData(f0IDX,:,1)';

AudTapRightITCf0 = statsData.indITCData(f0IDX,:,2)';

VisConRightITCf0 = statsData.indITCData(f0IDX,:,3)';

VisTapRightITCf0 = statsData.indITCData(f0IDX,:,4)';

% load component Avg data
load([loadPath 'ITC_AvgAll.mat']);

AudConAvgITCf0 = statsData.indITCData(f0IDX,:,1)';

AudTapAvgITCf0 = statsData.indITCData(f0IDX,:,2)';

VisConAvgITCf0 = statsData.indITCData(f0IDX,:,3)';

VisTapAvgITCf0 = statsData.indITCData(f0IDX,:,4)';


%% Power f0 data

% grab avg power (amplitude) data at f0 for each subject from
% 06g_f0Power_StatsPlotsTransformed/Amplitude
% conditions in statsData: 1 = Aud Con, 2 = Aud Tap, 3 = Vis Con, 4 = Vis
% Tap

loadPath = '/Users/dcc/Data/AV_TapNoTap/Data/Revision1_Analysis/06g_f0Power_StatsPlotsTransformed/Amplitude/';

% get freq of interest index
f0IDX = 28; % = 1.6666

% load left motor data
load([loadPath 'LM_Pow_2BinOff1.mat']);

AudConLeftAmpf0 = freqData(:,f0IDX,1);

AudTapLeftAmpf0 = freqData(:,f0IDX,2);

VisConLeftAmpf0 = freqData(:,f0IDX,3);

VisTapLeftAmpf0 = freqData(:,f0IDX,4);

% load right motor data
load([loadPath 'RM_Pow_2BinOff1.mat']);

AudConRightAmpf0 = freqData(:,f0IDX,1);

AudTapRightAmpf0 = freqData(:,f0IDX,2);

VisConRightAmpf0 = freqData(:,f0IDX,3);

VisTapRightAmpf0 = freqData(:,f0IDX,4);

% load component Avg data
load([loadPath 'ChanAvg_Pow_2BinOff1.mat']);

AudConAvgAmpf0 = freqData(:,f0IDX,1);

AudTapAvgAmpf0 = freqData(:,f0IDX,2);

VisConAvgAmpf0 = freqData(:,f0IDX,3);

VisTapAvgAmpf0 = freqData(:,f0IDX,4);

%% Create table & save as CSV (wide format)

allStatsDataWide = table(subIDKey, musicianKey,...
    AudConLeftMuAvg, AudTapLeftMuAvg, VisConLeftMuAvg, VisTapLeftMuAvg,...
    AudConRightMuAvg, AudTapRightMuAvg, VisConRightMuAvg, VisTapRightMuAvg,...
    AudConLeftITCf0, AudTapLeftITCf0, VisConLeftITCf0, VisTapLeftITCf0,...
    AudConRightITCf0, AudTapRightITCf0, VisConRightITCf0, VisTapRightITCf0,...
    AudConAvgITCf0, AudTapAvgITCf0, VisConAvgITCf0, VisTapAvgITCf0,...
    AudConLeftAmpf0, AudTapLeftAmpf0, VisConLeftAmpf0, VisTapLeftAmpf0,...
    AudConRightAmpf0, AudTapRightAmpf0, VisConRightAmpf0, VisTapRightAmpf0,...
    AudConAvgAmpf0, AudTapAvgAmpf0, VisConAvgAmpf0, VisTapAvgAmpf0);

%Save mat file
savePath = '/Users/dcc/Data/AV_TapNoTap/Data/Revision1_Analysis/08_StatsData/';
save([savePath 'allANOVADataWide.mat'],'allStatsDataWide');

% Write as csv file
writetable(allStatsDataWide,[savePath 'allANOVADataWide.csv']);

%% Create data table with long format (for ggplot)

SubjectID = [subIDKey; subIDKey; subIDKey; subIDKey];
MusicianKey = [musicianKey; musicianKey; musicianKey; musicianKey;];
Condition = [repmat("Aud NoTap",18,1); repmat("Aud Tap",18,1); repmat("Vis NoTap",18,1); repmat("Vis Tap",18,1)];
MuLeft = [AudConLeftMuAvg; AudTapLeftMuAvg; VisConLeftMuAvg; VisTapLeftMuAvg];
MuRight = [AudConRightMuAvg; AudTapRightMuAvg; VisConRightMuAvg; VisTapRightMuAvg];
ITCf0Left = [AudConLeftITCf0; AudTapLeftITCf0; VisConLeftITCf0; VisTapLeftITCf0];
ITCf0Right = [AudConRightITCf0; AudTapRightITCf0; VisConRightITCf0; VisTapRightITCf0];
ITCf0Avg = [AudConAvgITCf0; AudTapAvgITCf0; VisConAvgITCf0; VisTapAvgITCf0];
Ampf0Left = [AudConLeftAmpf0; AudTapLeftAmpf0; VisConLeftAmpf0; VisTapLeftAmpf0];
Ampf0Right = [AudConRightAmpf0; AudTapRightAmpf0; VisConRightAmpf0; VisTapRightAmpf0];
Ampf0Avg = [AudConAvgAmpf0; AudTapAvgAmpf0; VisConAvgAmpf0; VisTapAvgAmpf0];

allStatsDataLong = table(SubjectID, MusicianKey, Condition, MuLeft, MuRight,...
    ITCf0Left, ITCf0Right, ITCf0Avg, Ampf0Left, Ampf0Right, Ampf0Avg);

%Save mat file
savePath = '/Users/dcc/Data/AV_TapNoTap/Data/Revision1_Analysis/08_StatsData/';
save([savePath 'allANOVADataLong.mat'],'allStatsDataLong');

% Write as csv file
writetable(allStatsDataLong,[savePath 'allANOVADataLong.csv']);














