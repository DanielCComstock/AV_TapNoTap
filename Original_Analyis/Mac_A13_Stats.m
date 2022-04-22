

loadpath = '/Users/danielcomstock/Documents/Data/AV_TapNoTap/Data/09_f02Mu_BoxPlots/data/';
%% ITC AVG ANOVAs

%All avg components
fullLoad = [loadpath 'ITC_AllComp.mat'];
load(fullLoad);

%Transform data
data(1:18,1) = ITCData(:,1); % Aud no Tap
data(19:36,1) = ITCData(:,2); % Aud Tap
data(1:18,2) = ITCData(:,3); % Vis no Tap
data(19:36,2) = ITCData(:,4); % Vis Tap

% run ANOVA
[~,tbl,stats] = anova2(data,18) 

ITC_Avg_tbl = tbl;
ITC_Avg_stats = stats;
% Results

% Source          SS      df     MS        F     Prob>F
% -----------------------------------------------------
% Columns       0.02399    1   0.02399    7.26   0.0089     Aud vs Vis
% Rows          0.04078    1   0.04078   12.34   0.0008     Tap vs No Tap
% Interaction   0.00002    1   0.00002    0.01   0.9386
% Error         0.22472   68   0.0033                  
% Total         0.28951   71 


% Tests between Aud Tap & Aud no Tap

[h,p,ci,stats] = ttest(data(1:18,1),data(19:36,1))
ITC_Avg_Tstats.AudN_AudT.h=h;
ITC_Avg_Tstats.AudN_AudT.p =p;
ITC_Avg_Tstats.AudN_AudT.ci=ci;
ITC_Avg_Tstats.AudN_AudT.tstat=stats.tstat;
ITC_Avg_Tstats.AudN_AudT.df=stats.df;
ITC_Avg_Tstats.AudN_AudT.sd=stats.sd;
% p = 0.0035

% Tests between Vis Tap & Vis no Tap

[h,p,ci,stats] = ttest(data(1:18,2),data(19:36,2))
ITC_Avg_Tstats.VisN_VisT.h=h;
ITC_Avg_Tstats.VisN_VisT.p =p;
ITC_Avg_Tstats.VisN_VisT.ci=ci;
ITC_Avg_Tstats.VisN_VisT.tstat=stats.tstat;
ITC_Avg_Tstats.VisN_VisT.df=stats.df;
ITC_Avg_Tstats.VisN_VisT.sd=stats.sd;
% p = 0.0053

% Tests between Aud Tap & Vis Tap

[h,p,ci,stats] = ttest(data(19:36,1),data(19:36,2))
ITC_Avg_Tstats.AudT_VisT.h=h;
ITC_Avg_Tstats.AudT_VisT.p =p;
ITC_Avg_Tstats.AudT_VisT.ci=ci;
ITC_Avg_Tstats.AudT_VisT.tstat=stats.tstat;
ITC_Avg_Tstats.AudT_VisT.df=stats.df;
ITC_Avg_Tstats.AudT_VisT.sd=stats.sd;
% p = 0.0457

% Tests between Aud no Tap & Vis no Tap

[h,p,ci,stats] = ttest(data(1:18,1),data(1:18,2))
ITC_Avg_Tstats.AudN_VisN.h=h;
ITC_Avg_Tstats.AudN_VisN.p =p;
ITC_Avg_Tstats.AudN_VisN.ci=ci;
ITC_Avg_Tstats.AudN_VisN.tstat=stats.tstat;
ITC_Avg_Tstats.AudN_VisN.df=stats.df;
ITC_Avg_Tstats.AudN_VisN.sd=stats.sd;
% p = 0.0060

% 1 sample t-test of aud no tap
[h,p,ci,stats] = ttest(data(1:18,1))
ITC_Avg_Tstats.AudN.h=h;
ITC_Avg_Tstats.AudN.p =p;
ITC_Avg_Tstats.AudN.ci=ci;
ITC_Avg_Tstats.AudN.tstat=stats.tstat;
ITC_Avg_Tstats.AudN.df=stats.df;
ITC_Avg_Tstats.AudN.sd=stats.sd;
ITC_Avg_Tstats.AudN.avg = mean(data(1:18,1));
% p = 3.5939e-19

% 1 sample t-test of vis no tap

[h,p,ci,stats] = ttest(data(1:18,2))
ITC_Avg_Tstats.VisN.h=h;
ITC_Avg_Tstats.VisN.p =p;
ITC_Avg_Tstats.VisN.ci=ci;
ITC_Avg_Tstats.VisN.tstat=stats.tstat;
ITC_Avg_Tstats.VisN.df=stats.df;
ITC_Avg_Tstats.VisN.sd=stats.sd;
ITC_Avg_Tstats.VisN.avg = mean(data(1:18,2));
% p = 2.0094e-16

% 1 sample t-test of Aud tap

[h,p,ci,stats] = ttest(data(19:36,1))
ITC_Avg_Tstats.AudT.h=h;
ITC_Avg_Tstats.AudT.p =p;
ITC_Avg_Tstats.AudT.ci=ci;
ITC_Avg_Tstats.AudT.tstat=stats.tstat;
ITC_Avg_Tstats.AudT.df=stats.df;
ITC_Avg_Tstats.AudT.sd=stats.sd;
ITC_Avg_Tstats.AudT.avg = mean(data(19:36,1));
% p = 1.3438e-14

% 1 sample t-test of Vis tap

[h,p,ci,stats] = ttest(data(19:36,2))
ITC_Avg_Tstats.VisT.h=h;
ITC_Avg_Tstats.VisT.p =p;
ITC_Avg_Tstats.VisT.ci=ci;
ITC_Avg_Tstats.VisT.tstat=stats.tstat;
ITC_Avg_Tstats.VisT.df=stats.df;
ITC_Avg_Tstats.VisT.sd=stats.sd;
ITC_Avg_Tstats.AudT.avg = mean(data(19:36,1));
% p = 5.8831e-13

%% ITC LeftMotor ANOVAs

%All avg components
fullLoad = [loadpath 'ITC_LeftMotor.mat'];
load(fullLoad);

%Transform data
data(1:18,1) = ITCData(:,1); % Aud no Tap
data(19:36,1) = ITCData(:,2); % Aud Tap
data(1:18,2) = ITCData(:,3); % Vis no Tap
data(19:36,2) = ITCData(:,4); % Vis Tap

% run ANOVA
[~,tbl,stats] = anova2(data,18) 

ITC_LeftM_tbl = tbl;
ITC_LeftM_stats = stats;
% Results

% Source          SS      df     MS        F     Prob>F
% -----------------------------------------------------
% Columns       0.18967    1   0.18967    4.96   0.0293
% Rows          0.65403    1   0.65403   17.09   0.0001
% Interaction   0.0443     1   0.0443     1.16   0.2857
% Error         2.60173   68   0.03826                 
% Total         3.48972   71                           


% Tests between Aud Tap & Aud no Tap

[h,p,ci,stats] = ttest(data(1:18,1),data(19:36,1))
ITC_LeftM_Tstats.AudN_AudT.h=h;
ITC_LeftM_Tstats.AudN_AudT.p =p;
ITC_LeftM_Tstats.AudN_AudT.ci=ci;
ITC_LeftM_Tstats.AudN_AudT.tstat=stats.tstat;
ITC_LeftM_Tstats.AudN_AudT.df=stats.df;
ITC_LeftM_Tstats.AudN_AudT.sd=stats.sd;
% p = 0.0036

% Tests between Vis Tap & Vis no Tap

[h,p,ci,stats] = ttest(data(1:18,2),data(19:36,2))
ITC_LeftM_Tstats.VisN_VisT.h=h;
ITC_LeftM_Tstats.VisN_VisT.p =p;
ITC_LeftM_Tstats.VisN_VisT.ci=ci;
ITC_LeftM_Tstats.VisN_VisT.tstat=stats.tstat;
ITC_LeftM_Tstats.VisN_VisT.df=stats.df;
ITC_LeftM_Tstats.VisN_VisT.sd=stats.sd;
% p = 0.0091

% Tests between Aud Tap & Vis Tap

[h,p,ci,stats] = ttest(data(19:36,1),data(19:36,2))
ITC_LeftM_Tstats.AudT_VisT.h=h;
ITC_LeftM_Tstats.AudT_VisT.p =p;
ITC_LeftM_Tstats.AudT_VisT.ci=ci;
ITC_LeftM_Tstats.AudT_VisT.tstat=stats.tstat;
ITC_LeftM_Tstats.AudT_VisT.df=stats.df;
ITC_LeftM_Tstats.AudT_VisT.sd=stats.sd;
% p = 0.4231

% Tests between Aud no Tap & Vis no Tap

[h,p,ci,stats] = ttest(data(1:18,1),data(1:18,2))
ITC_LeftM_Tstats.AudN_VisN.h=h;
ITC_LeftM_Tstats.AudN_VisN.p =p;
ITC_LeftM_Tstats.AudN_VisN.ci=ci;
ITC_LeftM_Tstats.AudN_VisN.tstat=stats.tstat;
ITC_LeftM_Tstats.AudN_VisN.df=stats.df;
ITC_LeftM_Tstats.AudN_VisN.sd=stats.sd;
% p = 0.0031

% 1 sample t-test of aud no tap
[h,p,ci,stats] = ttest(data(1:18,1))
ITC_LeftM_Tstats.AudN.h=h;
ITC_LeftM_Tstats.AudN.p =p;
ITC_LeftM_Tstats.AudN.ci=ci;
ITC_LeftM_Tstats.AudN.tstat=stats.tstat;
ITC_LeftM_Tstats.AudN.df=stats.df;
ITC_LeftM_Tstats.AudN.sd=stats.sd;
ITC_LeftM_Tstats.AudN.avg = mean(data(1:18,1));
% p = 6.2399e-07

% 1 sample t-test of vis no tap

[h,p,ci,stats] = ttest(data(1:18,2))
ITC_LeftM_Tstats.VisN.h=h;
ITC_LeftM_Tstats.VisN.p =p;
ITC_LeftM_Tstats.VisN.ci=ci;
ITC_LeftM_Tstats.VisN.tstat=stats.tstat;
ITC_LeftM_Tstats.VisN.df=stats.df;
ITC_LeftM_Tstats.VisN.sd=stats.sd;
ITC_LeftM_Tstats.VisN.avg = mean(data(1:18,2));
% p = 3.2546e-09

% 1 sample t-test of Aud tap

[h,p,ci,stats] = ttest(data(19:36,1))
ITC_LeftM_Tstats.AudT.h=h;
ITC_LeftM_Tstats.AudT.p =p;
ITC_LeftM_Tstats.AudT.ci=ci;
ITC_LeftM_Tstats.AudT.tstat=stats.tstat;
ITC_LeftM_Tstats.AudT.df=stats.df;
ITC_LeftM_Tstats.AudT.sd=stats.sd;
ITC_LeftM_Tstats.AudT.avg = mean(data(19:36,1));
% p = 3.1601e-07

% 1 sample t-test of Vis tap

[h,p,ci,stats] = ttest(data(19:36,2))
ITC_LeftM_Tstats.VisT.h=h;
ITC_LeftM_Tstats.VisT.p =p;
ITC_LeftM_Tstats.VisT.ci=ci;
ITC_LeftM_Tstats.VisT.tstat=stats.tstat;
ITC_LeftM_Tstats.VisT.df=stats.df;
ITC_LeftM_Tstats.VisT.sd=stats.sd;
ITC_LeftM_Tstats.VisT.avg = mean(data(19:36,2));
% p = 6.5387e-09

%%  Avg Mu Stats

%All avg components
fullLoad = [loadpath 'Mu_AllComp.mat'];
load(fullLoad);

%Transform data
data(1:18,1) = MuData(:,1); % Aud no Tap
data(19:36,1) = MuData(:,2); % Aud Tap
data(1:18,2) = MuData(:,3); % Vis no Tap
data(19:36,2) = MuData(:,4); % Vis Tap

% run ANOVA
[~,tbl,stats] = anova2(data,18) 

Mu_Avg_tbl = tbl;
Mu_Avg_stats = stats;
% Results

% Source          SS      df     MS       F     Prob>F
% ----------------------------------------------------
% Columns        286.45    1   286.453   2.73   0.103 
% Rows             0.65    1     0.655   0.01   0.9373
% Interaction     10.55    1    10.546   0.1    0.7522
% Error         7132.64   68   104.892                
% Total         7430.29   71                          


% Tests between Aud Tap & Aud no Tap

[h,p,ci,stats] = ttest(data(1:18,1),data(19:36,1))
Mu_Avg_Tstats.AudN_AudT.h=h;
Mu_Avg_Tstats.AudN_AudT.p =p;
Mu_Avg_Tstats.AudN_AudT.ci=ci;
Mu_Avg_Tstats.AudN_AudT.tstat=stats.tstat;
Mu_Avg_Tstats.AudN_AudT.df=stats.df;
Mu_Avg_Tstats.AudN_AudT.sd=stats.sd;
% p = 0.6358

% Tests between Vis Tap & Vis no Tap

[h,p,ci,stats] = ttest(data(1:18,2),data(19:36,2))
Mu_Avg_Tstats.VisN_VisT.h=h;
Mu_Avg_Tstats.VisN_VisT.p =p;
Mu_Avg_Tstats.VisN_VisT.ci=ci;
Mu_Avg_Tstats.VisN_VisT.tstat=stats.tstat;
Mu_Avg_Tstats.VisN_VisT.df=stats.df;
Mu_Avg_Tstats.VisN_VisT.sd=stats.sd;
% p = 0.0421

% Tests between Aud Tap & Vis Tap

[h,p,ci,stats] = ttest(data(19:36,1),data(19:36,2))
Mu_Avg_Tstats.AudT_VisT.h=h;
Mu_Avg_Tstats.AudT_VisT.p =p;
Mu_Avg_Tstats.AudT_VisT.ci=ci;
Mu_Avg_Tstats.AudT_VisT.tstat=stats.tstat;
Mu_Avg_Tstats.AudT_VisT.df=stats.df;
Mu_Avg_Tstats.AudT_VisT.sd=stats.sd;
% p = 0.0240

% Tests between Aud no Tap & Vis no Tap

[h,p,ci,stats] = ttest(data(1:18,1),data(1:18,2))
Mu_Avg_Tstats.AudN_VisN.h=h;
Mu_Avg_Tstats.AudN_VisN.p =p;
Mu_Avg_Tstats.AudN_VisN.ci=ci;
Mu_Avg_Tstats.AudN_VisN.tstat=stats.tstat;
Mu_Avg_Tstats.AudN_VisN.df=stats.df;
Mu_Avg_Tstats.AudN_VisN.sd=stats.sd;
% p = 0.0394

Mu_Avg_Tstats.AudN.avg = mean(data(1:18,1));
Mu_Avg_Tstats.AudN.sd = std(data(1:18,1));
Mu_Avg_Tstats.VisN.avg = mean(data(1:18,2));
Mu_Avg_Tstats.VisN.sd = std(data(1:18,2));
Mu_Avg_Tstats.AudT.avg = mean(data(19:36,1));
Mu_Avg_Tstats.AudT.sd = std(data(19:36,1));
Mu_Avg_Tstats.VisT.avg = mean(data(19:36,2));
Mu_Avg_Tstats.VisT.sd = std(data(19:36,2));

%%  Left Motor Mu Stats

%All avg components
fullLoad = [loadpath 'Mu_LeftMotor.mat'];
load(fullLoad);

%Transform data
data(1:18,1) = MuData(:,1); % Aud no Tap
data(19:36,1) = MuData(:,2); % Aud Tap
data(1:18,2) = MuData(:,3); % Vis no Tap
data(19:36,2) = MuData(:,4); % Vis Tap

% run ANOVA
[~,tbl,stats] = anova2(data,18) 

Mu_LeftM_tbl = tbl;
Mu_LeftM_stats = stats;
% Results

% Source          SS      df     MS        F     Prob>F
% -----------------------------------------------------
% Columns          72.3    1     72.26    0.23   0.6347
% Rows           3334.3    1   3334.26   10.51   0.0018
% Interaction     217.4    1    217.44    0.69   0.4106
% Error         21570.9   68    317.22                 
% Total         25194.8   71                                                


% Tests between Aud Tap & Aud no Tap

[h,p,ci,stats] = ttest(data(1:18,1),data(19:36,1))
Mu_LeftM_Tstats.AudN_AudT.h=h;
Mu_LeftM_Tstats.AudN_AudT.p =p;
Mu_LeftM_Tstats.AudN_AudT.ci=ci;
Mu_LeftM_Tstats.AudN_AudT.tstat=stats.tstat;
Mu_LeftM_Tstats.AudN_AudT.df=stats.df;
Mu_LeftM_Tstats.AudN_AudT.sd=stats.sd;
% p = 0.0137

% Tests between Vis Tap & Vis no Tap

[h,p,ci,stats] = ttest(data(1:18,2),data(19:36,2))
Mu_LeftM_Tstats.VisN_VisT.h=h;
Mu_LeftM_Tstats.VisN_VisT.p =p;
Mu_LeftM_Tstats.VisN_VisT.ci=ci;
Mu_LeftM_Tstats.VisN_VisT.tstat=stats.tstat;
Mu_LeftM_Tstats.VisN_VisT.df=stats.df;
Mu_LeftM_Tstats.VisN_VisT.sd=stats.sd;
% p = 0.0186

% Tests between Aud Tap & Vis Tap

[h,p,ci,stats] = ttest(data(19:36,1),data(19:36,2))
Mu_LeftM_Tstats.AudT_VisT.h=h;
Mu_LeftM_Tstats.AudT_VisT.p =p;
Mu_LeftM_Tstats.AudT_VisT.ci=ci;
Mu_LeftM_Tstats.AudT_VisT.tstat=stats.tstat;
Mu_LeftM_Tstats.AudT_VisT.df=stats.df;
Mu_LeftM_Tstats.AudT_VisT.sd=stats.sd;
% p = 0.2827

% Tests between Aud no Tap & Vis no Tap

[h,p,ci,stats] = ttest(data(1:18,1),data(1:18,2))
Mu_LeftM_Tstats.AudN_VisN.h=h;
Mu_LeftM_Tstats.AudN_VisN.p =p;
Mu_LeftM_Tstats.AudN_VisN.ci=ci;
Mu_LeftM_Tstats.AudN_VisN.tstat=stats.tstat;
Mu_LeftM_Tstats.AudN_VisN.df=stats.df;
Mu_LeftM_Tstats.AudN_VisN.sd=stats.sd;
% p = 0.0389

Mu_LeftM_Tstats.AudN.avg = mean(data(1:18,1));
Mu_LeftM_Tstats.AudN.sd = std(data(1:18,1));
Mu_LeftM_Tstats.VisN.avg = mean(data(1:18,2));
Mu_LeftM_Tstats.VisN.sd = std(data(1:18,2));
Mu_LeftM_Tstats.AudT.avg = mean(data(19:36,1));
Mu_LeftM_Tstats.AudT.sd = std(data(19:36,1));
Mu_LeftM_Tstats.VisT.avg = mean(data(19:36,2));
Mu_LeftM_Tstats.VisT.sd = std(data(19:36,2));

%%  Avg f0Pow Stats

%All avg components
fullLoad = [loadpath 'Pow_AllComp.mat'];
load(fullLoad);

%Transform data
data(1:18,1) = f0PowData(:,1); % Aud no Tap
data(19:36,1) = f0PowData(:,2); % Aud Tap
data(1:18,2) = f0PowData(:,3); % Vis no Tap
data(19:36,2) = f0PowData(:,4); % Vis Tap

% run ANOVA
[~,tbl,stats] = anova2(data,18) 

f0Pow_Avg_tbl = tbl;
f0Pow_Avg_stats = stats;
% Results

% Source          SS      df     MS        F     Prob>F
% -----------------------------------------------------
% Columns       127.12     1   127.12    21.29   0     
% Rows           74.156    1    74.156   12.42   0.0008
% Interaction     1.342    1     1.342    0.22   0.6369
% Error         405.998   68     5.971                 
% Total         608.616   71                                                


% Tests between Aud Tap & Aud no Tap

[h,p,ci,stats] = ttest(data(1:18,1),data(19:36,1))
f0Pow_Avg_Tstats.AudN_AudT.h=h;
f0Pow_Avg_Tstats.AudN_AudT.p =p;
f0Pow_Avg_Tstats.AudN_AudT.ci=ci;
f0Pow_Avg_Tstats.AudN_AudT.tstat=stats.tstat;
f0Pow_Avg_Tstats.AudN_AudT.df=stats.df;
f0Pow_Avg_Tstats.AudN_AudT.sd=stats.sd;
% p = 7.0780e-04

% Tests between Vis Tap & Vis no Tap

[h,p,ci,stats] = ttest(data(1:18,2),data(19:36,2))
f0Pow_Avg_Tstats.VisN_VisT.h=h;
f0Pow_Avg_Tstats.VisN_VisT.p =p;
f0Pow_Avg_Tstats.VisN_VisT.ci=ci;
f0Pow_Avg_Tstats.VisN_VisT.tstat=stats.tstat;
f0Pow_Avg_Tstats.VisN_VisT.df=stats.df;
f0Pow_Avg_Tstats.VisN_VisT.sd=stats.sd;
% p = 5.6942e-04

% Tests between Aud Tap & Vis Tap

[h,p,ci,stats] = ttest(data(19:36,1),data(19:36,2))
f0Pow_Avg_Tstats.AudT_VisT.h=h;
f0Pow_Avg_Tstats.AudT_VisT.p =p;
f0Pow_Avg_Tstats.AudT_VisT.ci=ci;
f0Pow_Avg_Tstats.AudT_VisT.tstat=stats.tstat;
f0Pow_Avg_Tstats.AudT_VisT.df=stats.df;
f0Pow_Avg_Tstats.AudT_VisT.sd=stats.sd;
% p = 1.1753e-04

% Tests between Aud no Tap & Vis no Tap

[h,p,ci,stats] = ttest(data(1:18,1),data(1:18,2))
f0Pow_Avg_Tstats.AudN_VisN.h=h;
f0Pow_Avg_Tstats.AudN_VisN.p =p;
f0Pow_Avg_Tstats.AudN_VisN.ci=ci;
f0Pow_Avg_Tstats.AudN_VisN.tstat=stats.tstat;
f0Pow_Avg_Tstats.AudN_VisN.df=stats.df;
f0Pow_Avg_Tstats.AudN_VisN.sd=stats.sd;
% p = 0.0023

% 1 sample t-test of aud no tap
[h,p,ci,stats] = ttest(data(1:18,1))
f0Pow_Avg_Tstats.AudN.h=h;
f0Pow_Avg_Tstats.AudN.p =p;
f0Pow_Avg_Tstats.AudN.ci=ci;
f0Pow_Avg_Tstats.AudN.tstat=stats.tstat;
f0Pow_Avg_Tstats.AudN.df=stats.df;
f0Pow_Avg_Tstats.AudN.sd=stats.sd;
% p = 0.0301

% 1 sample t-test of vis no tap

[h,p,ci,stats] = ttest(data(1:18,2))
f0Pow_Avg_Tstats.VisN.h=h;
f0Pow_Avg_Tstats.VisN.p =p;
f0Pow_Avg_Tstats.VisN.ci=ci;
f0Pow_Avg_Tstats.VisN.tstat=stats.tstat;
f0Pow_Avg_Tstats.VisN.df=stats.df;
f0Pow_Avg_Tstats.VisN.sd=stats.sd;
% p = 0.0481

% 1 sample t-test of Aud tap

[h,p,ci,stats] = ttest(data(19:36,1))
f0Pow_Avg_Tstats.AudT.h=h;
f0Pow_Avg_Tstats.AudT.p =p;
f0Pow_Avg_Tstats.AudT.ci=ci;
f0Pow_Avg_Tstats.AudT.tstat=stats.tstat;
f0Pow_Avg_Tstats.AudT.df=stats.df;
f0Pow_Avg_Tstats.AudT.sd=stats.sd;
% p = 0.4013

% 1 sample t-test of Vis tap

[h,p,ci,stats] = ttest(data(19:36,2))
f0Pow_Avg_Tstats.VisT.h=h;
f0Pow_Avg_Tstats.VisT.p =p;
f0Pow_Avg_Tstats.VisT.ci=ci;
f0Pow_Avg_Tstats.VisT.tstat=stats.tstat;
f0Pow_Avg_Tstats.VisT.df=stats.df;
f0Pow_Avg_Tstats.VisT.sd=stats.sd;
% p = 3.7932e-05

f0Pow_Avg_Tstats.AudN.avg = mean(data(1:18,1));
f0Pow_Avg_Tstats.VisN.avg = mean(data(1:18,2));
f0Pow_Avg_Tstats.AudT.avg = mean(data(19:36,1));
f0Pow_Avg_Tstats.VisT.avg = mean(data(19:36,2));


%%  LeftMotor f0Pow Stats

%All avg components
fullLoad = [loadpath 'Pow_LeftMotor.mat'];
load(fullLoad);

%Transform data
data(1:18,1) = f0PowData(:,1); % Aud no Tap
data(19:36,1) = f0PowData(:,2); % Aud Tap
data(1:18,2) = f0PowData(:,3); % Vis no Tap
data(19:36,2) = f0PowData(:,4); % Vis Tap

% run ANOVA
[~,tbl,stats] = anova2(data,18) 

f0Pow_LeftM_tbl = tbl;
f0Pow_LeftM_stats = stats;
% Results

% Source          SS      df     MS       F     Prob>F
% ----------------------------------------------------
% Columns         64.02    1    64.022   1.45   0.2333
% Rows           382.88    1   382.88    8.65   0.0045
% Interaction      8.27    1     8.274   0.19   0.6669
% Error         3010.28   68    44.269                
% Total         3465.45   71                                                                       


% Tests between Aud Tap & Aud no Tap

[h,p,ci,stats] = ttest(data(1:18,1),data(19:36,1))
f0Pow_LeftM_Tstats.AudN_AudT.h=h;
f0Pow_LeftM_Tstats.AudN_AudT.p =p;
f0Pow_LeftM_Tstats.AudN_AudT.ci=ci;
f0Pow_LeftM_Tstats.AudN_AudT.tstat=stats.tstat;
f0Pow_LeftM_Tstats.AudN_AudT.df=stats.df;
f0Pow_LeftM_Tstats.AudN_AudT.sd=stats.sd;
% p = 0.0157

% Tests between Vis Tap & Vis no Tap

[h,p,ci,stats] = ttest(data(1:18,2),data(19:36,2))
f0Pow_LeftM_Tstats.VisN_VisT.h=h;
f0Pow_LeftM_Tstats.VisN_VisT.p =p;
f0Pow_LeftM_Tstats.VisN_VisT.ci=ci;
f0Pow_LeftM_Tstats.VisN_VisT.tstat=stats.tstat;
f0Pow_LeftM_Tstats.VisN_VisT.df=stats.df;
f0Pow_LeftM_Tstats.VisN_VisT.sd=stats.sd;
% p = 0.0320

% Tests between Aud Tap & Vis Tap

[h,p,ci,stats] = ttest(data(19:36,1),data(19:36,2))
f0Pow_LeftM_Tstats.AudT_VisT.h=h;
f0Pow_LeftM_Tstats.AudT_VisT.p =p;
f0Pow_LeftM_Tstats.AudT_VisT.ci=ci;
f0Pow_LeftM_Tstats.AudT_VisT.tstat=stats.tstat;
f0Pow_LeftM_Tstats.AudT_VisT.df=stats.df;
f0Pow_LeftM_Tstats.AudT_VisT.sd=stats.sd;
% p = 0.3839

% Tests between Aud no Tap & Vis no Tap

[h,p,ci,stats] = ttest(data(1:18,1),data(1:18,2))
f0Pow_LeftM_Tstats.AudN_VisN.h=h;
f0Pow_LeftM_Tstats.AudN_VisN.p =p;
f0Pow_LeftM_Tstats.AudN_VisN.ci=ci;
f0Pow_LeftM_Tstats.AudN_VisN.tstat=stats.tstat;
f0Pow_LeftM_Tstats.AudN_VisN.df=stats.df;
f0Pow_LeftM_Tstats.AudN_VisN.sd=stats.sd;
% p = 0.3192

% 1 sample t-test of aud no tap
[h,p,ci,stats] = ttest(data(1:18,1))
f0Pow_LeftM_Tstats.AudN.h=h;
f0Pow_LeftM_Tstats.AudN.p =p;
f0Pow_LeftM_Tstats.AudN.ci=ci;
f0Pow_LeftM_Tstats.AudN.tstat=stats.tstat;
f0Pow_LeftM_Tstats.AudN.df=stats.df;
f0Pow_LeftM_Tstats.AudN.sd=stats.sd;
% p = 0.6956

% 1 sample t-test of vis no tap

[h,p,ci,stats] = ttest(data(1:18,2))
f0Pow_LeftM_Tstats.VisN.h=h;
f0Pow_LeftM_Tstats.VisN.p =p;
f0Pow_LeftM_Tstats.VisN.ci=ci;
f0Pow_LeftM_Tstats.VisN.tstat=stats.tstat;
f0Pow_LeftM_Tstats.VisN.df=stats.df;
f0Pow_LeftM_Tstats.VisN.sd=stats.sd;
% p = 0.3632

% 1 sample t-test of Aud tap

[h,p,ci,stats] = ttest(data(19:36,1))
f0Pow_LeftM_Tstats.AudT.h=h;
f0Pow_LeftM_Tstats.AudT.p =p;
f0Pow_LeftM_Tstats.AudT.ci=ci;
f0Pow_LeftM_Tstats.AudT.tstat=stats.tstat;
f0Pow_LeftM_Tstats.AudT.df=stats.df;
f0Pow_LeftM_Tstats.AudT.sd=stats.sd;
% p = 0.0292

% 1 sample t-test of Vis tap

[h,p,ci,stats] = ttest(data(19:36,2))
f0Pow_LeftM_Tstats.VisT.h=h;
f0Pow_LeftM_Tstats.VisT.p =p;
f0Pow_LeftM_Tstats.VisT.ci=ci;
f0Pow_LeftM_Tstats.VisT.tstat=stats.tstat;
f0Pow_LeftM_Tstats.VisT.df=stats.df;
f0Pow_LeftM_Tstats.VisT.sd=stats.sd;
% p = 0.0215

f0Pow_LeftM_Tstats.AudN.avg = mean(data(1:18,1));
f0Pow_LeftM_Tstats.VisN.avg = mean(data(1:18,2));
f0Pow_LeftM_Tstats.AudT.avg = mean(data(19:36,1));
f0Pow_LeftM_Tstats.VisT.avg = mean(data(19:36,2));

%% Save All Stats

savePath = '/Users/danielcomstock/Documents/Data/AV_TapNoTap/Data/10_Stats/Mu_f0ITC_f0Pow_Avg_LeftM_Stats';
save(savePath, 'f0Pow_Avg_stats', 'f0Pow_Avg_tbl', 'f0Pow_Avg_Tstats', 'f0Pow_LeftM_stats', 'f0Pow_LeftM_tbl', 'f0Pow_LeftM_Tstats', ...
    'ITC_Avg_stats', 'ITC_Avg_tbl', 'ITC_Avg_Tstats', 'ITC_LeftM_stats', 'ITC_LeftM_tbl', 'ITC_LeftM_Tstats', ...
    'Mu_Avg_stats', 'Mu_Avg_tbl', 'Mu_Avg_Tstats', 'Mu_LeftM_stats', 'Mu_LeftM_tbl', 'Mu_LeftM_Tstats');


