
%% ERSP plots for Aud Con Left mu data
ersp = mean(AudConLeftERSP,3);

% Compute absolute highest ERSP values in the Average ERSP for symetrical scalling
ERSPmax = [max(max(abs(ersp)))];
% convert absolute highest ERSP values for symetrical scale
ERSPminmax = [-6 6];


times = MuStimTrainTimes/1000; % convert ms to s
freqs = MuStimTrainFreqs;

%tempname = [saveName '_IB_ERSP'];
titleName = 'Auditory Control Left Mu';%strrep(tempname, '_', ' ');

figure; imagesc(times, freqs, ersp, ERSPminmax); 
% sets scaling direction
set(gca, 'ydir', 'normal'); 
% set font
set(gca, 'FontSize', 12, 'FontWeight', 'bold');
% set plotbackground to white
set(gcf,'color','w');
set(gcf,'PaperPositionMode','auto')
% set x & y coord limits and x ticks
xlim([1 20 ]);
xticks([1 5 10 15 20])
xticklabels({'1', '5', '10', '15', '20'})
ylim([7 15]);
hold on;
% x axis label
xlabel('Time (sec)', 'FontSize',14, 'FontWeight', 'bold'); 
% y axis label
ylabel('Frequencies (Hz)', 'FontSize',14, 'FontWeight', 'bold'); 
% Set title and font
title(titleName, 'FontSize', 14, 'FontWeight','bold');
% adds colorbar to side showing color scale. Scale determined by
% erspmax
c=colorbar;
c.Label.String = 'dB';
c.Label.Position = [.5 ERSPminmax*1.13];
c.Label.Rotation = 0;
colormap jet;

%% ERSP plot for Aud Tap Left mu data
ersp = mean(AudTapLeftERSP,3);

% Compute absolute highest ERSP values in the Average ERSP for symetrical scalling
ERSPmax = [max(max(abs(ersp)))];
% convert absolute highest ERSP values for symetrical scale
ERSPminmax = [-6 6];


times = MuStimTrainTimes/1000; % convert ms to s
freqs = MuStimTrainFreqs;

%tempname = [saveName '_IB_ERSP'];
titleName = 'Auditory Tap Left Mu';%strrep(tempname, '_', ' ');

figure; imagesc(times, freqs, ersp, ERSPminmax); 
% sets scaling direction
set(gca, 'ydir', 'normal'); 
% set font
set(gca, 'FontSize', 12, 'FontWeight', 'bold');
% set plotbackground to white
set(gcf,'color','w');
set(gcf,'PaperPositionMode','auto')
% set x & y coord limits and x ticks
xlim([1 20 ]);
xticks([1 5 10 15 20])
xticklabels({'1', '5', '10', '15', '20'})
ylim([7 15]);
hold on;
% x axis label
xlabel('Time (sec)', 'FontSize',14, 'FontWeight', 'bold'); 
% y axis label
ylabel('Frequencies (Hz)', 'FontSize',14, 'FontWeight', 'bold'); 
% Set title and font
title(titleName, 'FontSize', 14, 'FontWeight','bold');
% adds colorbar to side showing color scale. Scale determined by
% erspmax
c=colorbar;
c.Label.String = 'dB';
c.Label.Position = [.5 ERSPminmax*1.13];
c.Label.Rotation = 0;
colormap jet;


%% ERSP plot for Vis Con Left mu data
ersp = mean(VisConLeftERSP,3);

% Compute absolute highest ERSP values in the Average ERSP for symetrical scalling
ERSPmax = [max(max(abs(ersp)))];
% convert absolute highest ERSP values for symetrical scale
ERSPminmax = [-6 6]; 


times = MuStimTrainTimes/1000; % convert ms to s
freqs = MuStimTrainFreqs;

%tempname = [saveName '_IB_ERSP'];
titleName = 'Visual Control Left Mu';%strrep(tempname, '_', ' ');

figure; imagesc(times, freqs, ersp, ERSPminmax); 
% sets scaling direction
set(gca, 'ydir', 'normal'); 
% set font
set(gca, 'FontSize', 12, 'FontWeight', 'bold');
% set plotbackground to white
set(gcf,'color','w');
set(gcf,'PaperPositionMode','auto')
% set x & y coord limits and x ticks
xlim([1 20 ]);
xticks([1 5 10 15 20])
xticklabels({'1', '5', '10', '15', '20'})
ylim([7 15]);
hold on;
% x axis label
xlabel('Time (sec)', 'FontSize',14, 'FontWeight', 'bold'); 
% y axis label
ylabel('Frequencies (Hz)', 'FontSize',14, 'FontWeight', 'bold'); 
% Set title and font
title(titleName, 'FontSize', 14, 'FontWeight','bold');
% adds colorbar to side showing color scale. Scale determined by
% erspmax
c=colorbar;
c.Label.String = 'dB';
c.Label.Position = [.5 ERSPminmax*1.13];
c.Label.Rotation = 0;
colormap jet;


%% ERSP plot for Vis Tap Left mu data
ersp = mean(VisTapLeftERSP,3);

% Compute absolute highest ERSP values in the Average ERSP for symetrical scalling
ERSPmax = [max(max(abs(ersp)))];
% convert absolute highest ERSP values for symetrical scale
ERSPminmax = [-6 6];  


times = MuStimTrainTimes/1000; % convert ms to s
freqs = MuStimTrainFreqs;

%tempname = [saveName '_IB_ERSP'];
titleName = 'Visual Tap Left Mu';%strrep(tempname, '_', ' ');

figure; imagesc(times, freqs, ersp, ERSPminmax); 
% sets scaling direction
set(gca, 'ydir', 'normal'); 
% set font
set(gca, 'FontSize', 12, 'FontWeight', 'bold');
% set plotbackground to white
set(gcf,'color','w');
set(gcf,'PaperPositionMode','auto')
% set x & y coord limits and x ticks
xlim([1 20 ]);
xticks([1 5 10 15 20])
xticklabels({'1', '5', '10', '15', '20'})
ylim([7 15]);
hold on;
% x axis label
xlabel('Time (sec)', 'FontSize',14, 'FontWeight', 'bold'); 
% y axis label
ylabel('Frequencies (Hz)', 'FontSize',14, 'FontWeight', 'bold'); 
% Set title and font
title(titleName, 'FontSize', 14, 'FontWeight','bold');
% adds colorbar to side showing color scale. Scale determined by
% erspmax
c=colorbar;
c.Label.String = 'dB';
c.Label.Position = [.5 ERSPminmax*1.13];
c.Label.Rotation = 0;
colormap jet;















%% ERSP plots for Aud Con Right mu data
ersp = mean(AudConRightERSP,3);

% Compute absolute highest ERSP values in the Average ERSP for symetrical scalling
ERSPmax = [max(max(abs(ersp)))];
% convert absolute highest ERSP values for symetrical scale
ERSPminmax = [-6 6];


times = MuStimTrainTimes/1000; % convert ms to s
freqs = MuStimTrainFreqs;

%tempname = [saveName '_IB_ERSP'];
titleName = 'Auditory Control Right Mu';%strrep(tempname, '_', ' ');

figure; imagesc(times, freqs, ersp, ERSPminmax); 
% sets scaling direction
set(gca, 'ydir', 'normal'); 
% set font
set(gca, 'FontSize', 12, 'FontWeight', 'bold');
% set plotbackground to white
set(gcf,'color','w');
set(gcf,'PaperPositionMode','auto')
% set x & y coord limits and x ticks
xlim([1 20 ]);
xticks([1 5 10 15 20])
xticklabels({'1', '5', '10', '15', '20'})
ylim([7 15]);
hold on;
% x axis label
xlabel('Time (sec)', 'FontSize',14, 'FontWeight', 'bold'); 
% y axis label
ylabel('Frequencies (Hz)', 'FontSize',14, 'FontWeight', 'bold'); 
% Set title and font
title(titleName, 'FontSize', 14, 'FontWeight','bold');
% adds colorbar to side showing color scale. Scale determined by
% erspmax
c=colorbar;
c.Label.String = 'dB';
c.Label.Position = [.5 ERSPminmax*1.13];
c.Label.Rotation = 0;
colormap jet;

%% ERSP plot for Aud Tap Right mu data
ersp = mean(AudTapRightERSP,3);

% Compute absolute highest ERSP values in the Average ERSP for symetrical scalling
ERSPmax = [max(max(abs(ersp)))];
% convert absolute highest ERSP values for symetrical scale
ERSPminmax = [-6 6];


times = MuStimTrainTimes/1000; % convert ms to s
freqs = MuStimTrainFreqs;

%tempname = [saveName '_IB_ERSP'];
titleName = 'Auditory Tap Right Mu';%strrep(tempname, '_', ' ');

figure; imagesc(times, freqs, ersp, ERSPminmax); 
% sets scaling direction
set(gca, 'ydir', 'normal'); 
% set font
set(gca, 'FontSize', 12, 'FontWeight', 'bold');
% set plotbackground to white
set(gcf,'color','w');
set(gcf,'PaperPositionMode','auto')
% set x & y coord limits and x ticks
xlim([1 20 ]);
xticks([1 5 10 15 20])
xticklabels({'1', '5', '10', '15', '20'})
ylim([7 15]);
hold on;
% x axis label
xlabel('Time (sec)', 'FontSize',14, 'FontWeight', 'bold'); 
% y axis label
ylabel('Frequencies (Hz)', 'FontSize',14, 'FontWeight', 'bold'); 
% Set title and font
title(titleName, 'FontSize', 14, 'FontWeight','bold');
% adds colorbar to side showing color scale. Scale determined by
% erspmax
c=colorbar;
c.Label.String = 'dB';
c.Label.Position = [.5 ERSPminmax*1.13];
c.Label.Rotation = 0;
colormap jet;


%% ERSP plot for Vis Con Right mu data
ersp = mean(VisConRightERSP,3);

% Compute absolute highest ERSP values in the Average ERSP for symetrical scalling
ERSPmax = [max(max(abs(ersp)))];
% convert absolute highest ERSP values for symetrical scale
ERSPminmax = [-6 6]; 


times = MuStimTrainTimes/1000; % convert ms to s
freqs = MuStimTrainFreqs;

%tempname = [saveName '_IB_ERSP'];
titleName = 'Visual Control Right Mu';%strrep(tempname, '_', ' ');

figure; imagesc(times, freqs, ersp, ERSPminmax); 
% sets scaling direction
set(gca, 'ydir', 'normal'); 
% set font
set(gca, 'FontSize', 12, 'FontWeight', 'bold');
% set plotbackground to white
set(gcf,'color','w');
set(gcf,'PaperPositionMode','auto')
% set x & y coord limits and x ticks
xlim([1 20 ]);
xticks([1 5 10 15 20])
xticklabels({'1', '5', '10', '15', '20'})
ylim([7 15]);
hold on;
% x axis label
xlabel('Time (sec)', 'FontSize',14, 'FontWeight', 'bold'); 
% y axis label
ylabel('Frequencies (Hz)', 'FontSize',14, 'FontWeight', 'bold'); 
% Set title and font
title(titleName, 'FontSize', 14, 'FontWeight','bold');
% adds colorbar to side showing color scale. Scale determined by
% erspmax
c=colorbar;
c.Label.String = 'dB';
c.Label.Position = [.5 ERSPminmax*1.13];
c.Label.Rotation = 0;
colormap jet;


%% ERSP plot for Vis Tap Left mu data
ersp = mean(VisTapRightERSP,3);

% Compute absolute highest ERSP values in the Average ERSP for symetrical scalling
ERSPmax = [max(max(abs(ersp)))];
% convert absolute highest ERSP values for symetrical scale
ERSPminmax = [-6 6];  


times = MuStimTrainTimes/1000; % convert ms to s
freqs = MuStimTrainFreqs;

%tempname = [saveName '_IB_ERSP'];
titleName = 'Visual Tap Right Mu';%strrep(tempname, '_', ' ');

figure; imagesc(times, freqs, ersp, ERSPminmax); 
% sets scaling direction
set(gca, 'ydir', 'normal'); 
% set font
set(gca, 'FontSize', 12, 'FontWeight', 'bold');
% set plotbackground to white
set(gcf,'color','w');
set(gcf,'PaperPositionMode','auto')
% set x & y coord limits and x ticks
xlim([1 20 ]);
xticks([1 5 10 15 20])
xticklabels({'1', '5', '10', '15', '20'})
ylim([7 15]);
hold on;
% x axis label
xlabel('Time (sec)', 'FontSize',14, 'FontWeight', 'bold'); 
% y axis label
ylabel('Frequencies (Hz)', 'FontSize',14, 'FontWeight', 'bold'); 
% Set title and font
title(titleName, 'FontSize', 14, 'FontWeight','bold');
% adds colorbar to side showing color scale. Scale determined by
% erspmax
c=colorbar;
c.Label.String = 'dB';
c.Label.Position = [.5 ERSPminmax*1.13];
c.Label.Rotation = 0;
colormap jet;


