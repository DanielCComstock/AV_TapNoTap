

savePath = '/Users/dcc/Data/AV_TapNoTap/Data/Revision1_Analysis/07d_StimTrain_ERSP_Plots/';

%% ERSP plots for Aud Con Left mu data
ersp = AudConLeftERSP;
% average ERSP accross components/subjects
avgersp = mean(AudConLeftERSP,3);
% Compute absolute highest ERSP values in the Average ERSP for symetrical scalling
ERSPmax = [max(max(abs(avgersp)))];
% convert absolute highest ERSP values for symetrical scale
ERSPminmax = [-6 6];

% % permutation statistics with FDR correction. Compares ERSP values
% % versus zeros (equivalent to baseline)
% erspPvals = std_stat({ ersp zeros(size(ersp)) }', 'method', 'permutation', 'condstats', 'on', 'correctm', 'fdr'); 
% 
% % save values for stat contouring
% tmpersp05 = zeros(size(avgersp));
% tmpersp01 = zeros(size(avgersp));
% % Mask any ERSP values with less than p.05 sig
% tmpersp05(erspPvals{1} > 0.05) = 1;
% % Mask any ERSP values with less than p.01 sig
% tmpersp01(erspPvals{1} > 0.001) = 1;
% maskAvgERSP = avgersp;
% maskAvgERSP(erspPvals{1} > 0.05) = 0;

times = MuStimTrainTimes/1000; % convert ms to s
freqs = MuStimTrainFreqs;

%tempname = [saveName '_IB_ERSP'];
titleName = 'Auditory Control Left ERSP';%strrep(tempname, '_', ' ');

figure('Position',[500 500 600 180]); imagesc(times, freqs, avgersp, ERSPminmax); 
% sets scaling direction
set(gca, 'ydir', 'normal'); 
% set font
set(gca, 'FontSize', 12, 'FontWeight', 'bold');
% set plotbackground to white
set(gcf,'color','w');
set(gcf,'PaperPositionMode','auto')
% set x & y coord limits and x ticks
xlim([-4.6 21]);
xticks([-4.6 -0.6 4.4 9.4 14.4 19.4])
xticklabels({'-4','0', '5', '10', '15', '20'})
ylim([7 20]);
% add line at 0 
line([-0.6 -0.6],ylim,'color','k', 'LineWidth', 1.5, 'LineStyle','--');
% add lines around mu at 0 
line([0 0],[8,13],'color','k', 'LineWidth', 2, 'LineStyle',':');
line([20.9 20.9],[8,13],'color','k', 'LineWidth', 2, 'LineStyle',':');
line([0 20.9],[8,8],'color','k', 'LineWidth', 2, 'LineStyle',':');
line([0 20.9],[13,13],'color','k', 'LineWidth', 2, 'LineStyle',':');
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
c.Label.Position = [.5 ERSPminmax(2)*1.22];
c.Label.Rotation = 0;
colormap jet;

% save as .fig file
saveName = strrep(titleName, ' ', '_');
ERSPfigfullsave = [savePath saveName];
savefig(ERSPfigfullsave);        
% save as .svg file
ERSPfigfullsave = [savePath saveName];
saveas(gcf,ERSPfigfullsave,'svg');        
% close figure
close;

%% ERSP plot for Aud Tap Left mu data
avgersp = mean(AudTapLeftERSP,3);

% Compute absolute highest ERSP values in the Average ERSP for symetrical scalling
ERSPmax = [max(max(abs(avgersp)))];
% convert absolute highest ERSP values for symetrical scale
ERSPminmax = [-6 6];


times = MuStimTrainTimes/1000; % convert ms to s
freqs = MuStimTrainFreqs;

%tempname = [saveName '_IB_ERSP'];
titleName = 'Auditory Tap Left ERSP';%strrep(tempname, '_', ' ');

figure('Position',[500 500 600 180]); imagesc(times, freqs, avgersp, ERSPminmax); 
% sets scaling direction
set(gca, 'ydir', 'normal'); 
% set font
set(gca, 'FontSize', 12, 'FontWeight', 'bold');
% set plotbackground to white
set(gcf,'color','w');
set(gcf,'PaperPositionMode','auto')
% set x & y coord limits and x ticks
xlim([-4.6 21]);
xticks([-4.6 -0.6 4.4 9.4 14.4 19.4])
xticklabels({'-4','0', '5', '10', '15', '20'})
ylim([7 20]);
% add line at 0 
line([-0.6 -0.6],ylim,'color','k', 'LineWidth', 1.5, 'LineStyle','--');
% add lines around mu at 0 
line([0 0],[8,13],'color','k', 'LineWidth', 2, 'LineStyle',':');
line([20.9 20.9],[8,13],'color','k', 'LineWidth', 2, 'LineStyle',':');
line([0 20.9],[8,8],'color','k', 'LineWidth', 2, 'LineStyle',':');
line([0 20.9],[13,13],'color','k', 'LineWidth', 2, 'LineStyle',':');
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
c.Label.Position = [.5 ERSPminmax(2)*1.22];
c.Label.Rotation = 0;
colormap jet;

% save as .fig file
saveName = strrep(titleName, ' ', '_');
ERSPfigfullsave = [savePath saveName];
savefig(ERSPfigfullsave);        
% save as .svg file
ERSPfigfullsave = [savePath saveName];
saveas(gcf,ERSPfigfullsave,'svg');        
% close figure
close;


%% ERSP plot for Vis Con Left mu data
avgersp = mean(VisConLeftERSP,3);

% Compute absolute highest ERSP values in the Average ERSP for symetrical scalling
ERSPmax = [max(max(abs(avgersp)))];
% convert absolute highest ERSP values for symetrical scale
ERSPminmax = [-6 6]; 


times = MuStimTrainTimes/1000; % convert ms to s
freqs = MuStimTrainFreqs;

%tempname = [saveName '_IB_ERSP'];
titleName = 'Visual Control Left ERSP';%strrep(tempname, '_', ' ');

figure('Position',[500 500 600 180]); imagesc(times, freqs, avgersp, ERSPminmax); 
% sets scaling direction
set(gca, 'ydir', 'normal'); 
% set font
set(gca, 'FontSize', 12, 'FontWeight', 'bold');
% set plotbackground to white
set(gcf,'color','w');
set(gcf,'PaperPositionMode','auto')
% set x & y coord limits and x ticks
xlim([-4.6 21]);
xticks([-4.6 -0.6 4.4 9.4 14.4 19.4])
xticklabels({'-4','0', '5', '10', '15', '20'})
ylim([7 20]);
% add line at 0 
line([-0.6 -0.6],ylim,'color','k', 'LineWidth', 1.5, 'LineStyle','--');
% add lines around mu at 0 
line([0 0],[8,13],'color','k', 'LineWidth', 2, 'LineStyle',':');
line([20.9 20.9],[8,13],'color','k', 'LineWidth', 2, 'LineStyle',':');
line([0 20.9],[8,8],'color','k', 'LineWidth', 2, 'LineStyle',':');
line([0 20.9],[13,13],'color','k', 'LineWidth', 2, 'LineStyle',':');
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
c.Label.Position = [.5 ERSPminmax(2)*1.22];
c.Label.Rotation = 0;
colormap jet;

% save as .fig file
saveName = strrep(titleName, ' ', '_');
ERSPfigfullsave = [savePath saveName];
savefig(ERSPfigfullsave);        
% save as .svg file
ERSPfigfullsave = [savePath saveName];
saveas(gcf,ERSPfigfullsave,'svg');        
% close figure
close;

%% ERSP plot for Vis Tap Left mu data
avgersp = mean(VisTapLeftERSP,3);

% Compute absolute highest ERSP values in the Average ERSP for symetrical scalling
ERSPmax = [max(max(abs(avgersp)))];
% convert absolute highest ERSP values for symetrical scale
ERSPminmax = [-6 6];  


times = MuStimTrainTimes/1000; % convert ms to s
freqs = MuStimTrainFreqs;

%tempname = [saveName '_IB_ERSP'];
titleName = 'Visual Tap Left ERSP';%strrep(tempname, '_', ' ');

figure('Position',[500 500 600 180]); imagesc(times, freqs, avgersp, ERSPminmax); 
% sets scaling direction
set(gca, 'ydir', 'normal'); 
% set font
set(gca, 'FontSize', 12, 'FontWeight', 'bold');
% set plotbackground to white
set(gcf,'color','w');
set(gcf,'PaperPositionMode','auto')
% set x & y coord limits and x ticks
xlim([-4.6 21]);
xticks([-4.6 -0.6 4.4 9.4 14.4 19.4])
xticklabels({'-4','0', '5', '10', '15', '20'})
ylim([7 20]);
% add line at 0 
line([-0.6 -0.6],ylim,'color','k', 'LineWidth', 1.5, 'LineStyle','--');
% add lines around mu at 0 
line([0 0],[8,13],'color','k', 'LineWidth', 2, 'LineStyle',':');
line([20.9 20.9],[8,13],'color','k', 'LineWidth', 2, 'LineStyle',':');
line([0 20.9],[8,8],'color','k', 'LineWidth', 2, 'LineStyle',':');
line([0 20.9],[13,13],'color','k', 'LineWidth', 2, 'LineStyle',':');
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
c.Label.Position = [.5 ERSPminmax(2)*1.22];
c.Label.Rotation = 0;
colormap jet;

% save as .fig file
saveName = strrep(titleName, ' ', '_');
ERSPfigfullsave = [savePath saveName];
savefig(ERSPfigfullsave);        
% save as .svg file
ERSPfigfullsave = [savePath saveName];
saveas(gcf,ERSPfigfullsave,'svg');        
% close figure
close;


%% ERSP plots for Aud Con Right mu data
avgersp = mean(AudConRightERSP,3);

% Compute absolute highest ERSP values in the Average ERSP for symetrical scalling
ERSPmax = [max(max(abs(avgersp)))];
% convert absolute highest ERSP values for symetrical scale
ERSPminmax = [-6 6];


times = MuStimTrainTimes/1000; % convert ms to s
freqs = MuStimTrainFreqs;

%tempname = [saveName '_IB_ERSP'];
titleName = 'Auditory Control Right ERSP';%strrep(tempname, '_', ' ');

figure('Position',[500 500 600 180]); imagesc(times, freqs, avgersp, ERSPminmax); 
% sets scaling direction
set(gca, 'ydir', 'normal'); 
% set font
set(gca, 'FontSize', 12, 'FontWeight', 'bold');
% set plotbackground to white
set(gcf,'color','w');
set(gcf,'PaperPositionMode','auto')
% set x & y coord limits and x ticks
xlim([-4.6 21]);
xticks([-4.6 -0.6 4.4 9.4 14.4 19.4])
xticklabels({'-4','0', '5', '10', '15', '20'})
ylim([7 20]);
% add line at 0 
line([-0.6 -0.6],ylim,'color','k', 'LineWidth', 1.5, 'LineStyle','--');
% add lines around mu at 0 
line([0 0],[8,13],'color','k', 'LineWidth', 2, 'LineStyle',':');
line([20.9 20.9],[8,13],'color','k', 'LineWidth', 2, 'LineStyle',':');
line([0 20.9],[8,8],'color','k', 'LineWidth', 2, 'LineStyle',':');
line([0 20.9],[13,13],'color','k', 'LineWidth', 2, 'LineStyle',':');
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
c.Label.Position = [.5 ERSPminmax(2)*1.22];
c.Label.Rotation = 0;
colormap jet;

% save as .fig file
saveName = strrep(titleName, ' ', '_');
ERSPfigfullsave = [savePath saveName];
savefig(ERSPfigfullsave);        
% save as .svg file
ERSPfigfullsave = [savePath saveName];
saveas(gcf,ERSPfigfullsave,'svg');        
% close figure
close;


%% ERSP plot for Aud Tap Right mu data
avgersp = mean(AudTapRightERSP,3);

% Compute absolute highest ERSP values in the Average ERSP for symetrical scalling
ERSPmax = [max(max(abs(avgersp)))];
% convert absolute highest ERSP values for symetrical scale
ERSPminmax = [-6 6];


times = MuStimTrainTimes/1000; % convert ms to s
freqs = MuStimTrainFreqs;

%tempname = [saveName '_IB_ERSP'];
titleName = 'Auditory Tap Right ERSP';%strrep(tempname, '_', ' ');

figure('Position',[500 500 600 180]); imagesc(times, freqs, avgersp, ERSPminmax); 
% sets scaling direction
set(gca, 'ydir', 'normal'); 
% set font
set(gca, 'FontSize', 12, 'FontWeight', 'bold');
% set plotbackground to white
set(gcf,'color','w');
set(gcf,'PaperPositionMode','auto')
% set x & y coord limits and x ticks
xlim([-4.6 21]);
xticks([-4.6 -0.6 4.4 9.4 14.4 19.4])
xticklabels({'-4','0', '5', '10', '15', '20'})
ylim([7 20]);
% add line at 0 
line([-0.6 -0.6],ylim,'color','k', 'LineWidth', 1.5, 'LineStyle','--');
% add lines around mu at 0 
line([0 0],[8,13],'color','k', 'LineWidth', 2, 'LineStyle',':');
line([20.9 20.9],[8,13],'color','k', 'LineWidth', 2, 'LineStyle',':');
line([0 20.9],[8,8],'color','k', 'LineWidth', 2, 'LineStyle',':');
line([0 20.9],[13,13],'color','k', 'LineWidth', 2, 'LineStyle',':');
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
c.Label.Position = [.5 ERSPminmax(2)*1.22];
c.Label.Rotation = 0;
colormap jet;

% save as .fig file
saveName = strrep(titleName, ' ', '_');
ERSPfigfullsave = [savePath saveName];
savefig(ERSPfigfullsave);        
% save as .svg file
ERSPfigfullsave = [savePath saveName];
saveas(gcf,ERSPfigfullsave,'svg');        
% close figure
close;


%% ERSP plot for Vis Con Right mu data
avgersp = mean(VisConRightERSP,3);

% Compute absolute highest ERSP values in the Average ERSP for symetrical scalling
ERSPmax = [max(max(abs(avgersp)))];
% convert absolute highest ERSP values for symetrical scale
ERSPminmax = [-6 6]; 


times = MuStimTrainTimes/1000; % convert ms to s
freqs = MuStimTrainFreqs;

%tempname = [saveName '_IB_ERSP'];
titleName = 'Visual Control Right ERSP';%strrep(tempname, '_', ' ');

figure('Position',[500 500 600 180]); imagesc(times, freqs, avgersp, ERSPminmax); 
% sets scaling direction
set(gca, 'ydir', 'normal'); 
% set font
set(gca, 'FontSize', 12, 'FontWeight', 'bold');
% set plotbackground to white
set(gcf,'color','w');
set(gcf,'PaperPositionMode','auto')
% set x & y coord limits and x ticks
xlim([-4.6 21]);
xticks([-4.6 -0.6 4.4 9.4 14.4 19.4])
xticklabels({'-4','0', '5', '10', '15', '20'})
ylim([7 20]);
% add line at 0 
line([-0.6 -0.6],ylim,'color','k', 'LineWidth', 1.5, 'LineStyle','--');
% add lines around mu at 0 
line([0 0],[8,13],'color','k', 'LineWidth', 2, 'LineStyle',':');
line([20.9 20.9],[8,13],'color','k', 'LineWidth', 2, 'LineStyle',':');
line([0 20.9],[8,8],'color','k', 'LineWidth', 2, 'LineStyle',':');
line([0 20.9],[13,13],'color','k', 'LineWidth', 2, 'LineStyle',':');
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
c.Label.Position = [.5 ERSPminmax(2)*1.22];
c.Label.Rotation = 0;
colormap jet;

% save as .fig file
saveName = strrep(titleName, ' ', '_');
ERSPfigfullsave = [savePath saveName];
savefig(ERSPfigfullsave);        
% save as .svg file
ERSPfigfullsave = [savePath saveName];
saveas(gcf,ERSPfigfullsave,'svg');        
% close figure
close;

%% ERSP plot for Vis Tap Left mu data
avgersp = mean(VisTapRightERSP,3);

% Compute absolute highest ERSP values in the Average ERSP for symetrical scalling
ERSPmax = [max(max(abs(avgersp)))];
% convert absolute highest ERSP values for symetrical scale
ERSPminmax = [-6 6];  


times = MuStimTrainTimes/1000; % convert ms to s
freqs = MuStimTrainFreqs;

%tempname = [saveName '_IB_ERSP'];
titleName = 'Visual Tap Right ERSP';%strrep(tempname, '_', ' ');

figure('Position',[500 500 600 180]); imagesc(times, freqs, avgersp, ERSPminmax); 
% sets scaling direction
set(gca, 'ydir', 'normal'); 
% set font
set(gca, 'FontSize', 12, 'FontWeight', 'bold');
% set plotbackground to white
set(gcf,'color','w');
set(gcf,'PaperPositionMode','auto')
% set x & y coord limits and x ticks
xlim([-4.6 21]);
xticks([-4.6 -0.6 4.4 9.4 14.4 19.4])
xticklabels({'-4','0', '5', '10', '15', '20'})
ylim([7 20]);
% add line at 0 
line([-0.6 -0.6],ylim,'color','k', 'LineWidth', 1.5, 'LineStyle','--');
% add lines around mu at 0 
line([0 0],[8,13],'color','k', 'LineWidth', 2, 'LineStyle',':');
line([20.9 20.9],[8,13],'color','k', 'LineWidth', 2, 'LineStyle',':');
line([0 20.9],[8,8],'color','k', 'LineWidth', 2, 'LineStyle',':');
line([0 20.9],[13,13],'color','k', 'LineWidth', 2, 'LineStyle',':');
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
c.Label.Position = [.5 ERSPminmax(2)*1.22];
c.Label.Rotation = 0;
colormap jet;

% save as .fig file
saveName = strrep(titleName, ' ', '_');
ERSPfigfullsave = [savePath saveName];
savefig(ERSPfigfullsave);        
% save as .svg file
ERSPfigfullsave = [savePath saveName];
saveas(gcf,ERSPfigfullsave,'svg');        
% close figure
close;


