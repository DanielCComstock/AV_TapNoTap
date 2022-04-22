loadpath = '/Users/danielcomstock/Documents/Data/AV_TapNoTap/Data/09_f02Mu_BoxPlots/data/';

musicianIDX =[1,2,3,9,10,13,17,18];
musician(1:18,1) = {'n'};
musician(musicianIDX,1) = {'y'};

%% ITC AVG ANOVAs

%All avg components
fullLoad = [loadpath 'ITC_AllComp.mat'];
load(fullLoad);


% 
% ITCData(:,1); % Aud no Tap
% ITCData(:,2); % Aud Tap
% ITCData(:,3); % Vis no Tap
% ITCData(:,4); % Vis Tap




%% ITC LeftMotor ANOVAs

%All Left Motor components
fullLoad = [loadpath 'ITC_LeftMotor.mat'];
load(fullLoad);


%%  Avg Mu Stats

%All avg components
fullLoad = [loadpath 'Mu_AllComp.mat'];
load(fullLoad);


%%  Left Motor Mu Stats

%All left motor components
fullLoad = [loadpath 'Mu_LeftMotor.mat'];
load(fullLoad);


%%  Avg f0Pow Stats

%All avg components
fullLoad = [loadpath 'Pow_AllComp.mat'];
load(fullLoad);

%%  LeftMotor f0Pow Stats

%All left motor components
fullLoad = [loadpath 'Pow_LeftMotor.mat'];
load(fullLoad);

