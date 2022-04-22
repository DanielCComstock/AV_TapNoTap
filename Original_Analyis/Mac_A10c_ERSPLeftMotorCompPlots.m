%% plot beta power and f0 ITC for selected motor components

clear

%% Create Component Matrix for plotting

MotorClusters(1).sub = 'AVTapNoTap1';
MotorClusters(2).sub = 'AVTapNoTap2';
MotorClusters(3).sub = 'AVTapNoTap4';
MotorClusters(4).sub = 'AVTapNoTap5';
MotorClusters(5).sub = 'AVTapNoTap6';
MotorClusters(6).sub = 'AVTapNoTap7';
MotorClusters(7).sub = 'AVTapNoTap8';
MotorClusters(8).sub = 'AVTapNoTap9';
MotorClusters(9).sub = 'AVTapNoTap10';
MotorClusters(10).sub = 'AVTapNoTap11';
MotorClusters(11).sub = 'AVTapNoTap12';
MotorClusters(12).sub = 'AVTapNoTap13';
MotorClusters(13).sub = 'AVTapNoTap14';
MotorClusters(14).sub = 'AVTapNoTap17';
MotorClusters(15).sub = 'AVTapNoTap18';
MotorClusters(16).sub = 'AVTapNoTap19';
MotorClusters(17).sub = 'AVTapNoTap20';
MotorClusters(18).sub = 'AVTapNoTap21';

MotorClusters(1).lm = 15;
MotorClusters(2).lm = 13;
MotorClusters(3).lm = 9;
MotorClusters(4).lm = 6;
MotorClusters(5).lm = 10;
MotorClusters(6).lm = 8;
MotorClusters(7).lm = 6;
MotorClusters(8).lm = 14;
MotorClusters(9).lm = 11;
MotorClusters(10).lm = 5;
MotorClusters(11).lm = 20;
MotorClusters(12).lm = 16;
MotorClusters(13).lm = 5;
MotorClusters(14).lm = 5;
MotorClusters(15).lm = 7;
MotorClusters(16).lm = 14;
MotorClusters(17).lm = 3;
MotorClusters(18).lm = 15;

MotorClusters(1).rm = 8;
MotorClusters(2).rm = 7;
MotorClusters(3).rm = 12;
MotorClusters(4).rm = 14;
MotorClusters(5).rm = 8;
MotorClusters(6).rm = 13;
MotorClusters(7).rm = 3;
MotorClusters(8).rm = 8;
MotorClusters(9).rm = 7;
MotorClusters(10).rm = 10;
MotorClusters(11).rm = 15;
MotorClusters(12).rm = 18;
MotorClusters(13).rm = 4;
MotorClusters(14).rm = 17;
MotorClusters(15).rm = 9;
MotorClusters(16).rm = 4;
MotorClusters(17).rm = 7;
MotorClusters(18).rm = 2;

%% Data loading

% file paths
loadF0ITCPath = '/Users/danielcomstock/Documents/Data/AV_TapNoTap/Data/07_Comp_TF_Data/f0ITC/';
loadMuBetaPath = '/Users/danielcomstock/Documents/Data/AV_TapNoTap/Data/07_Comp_TF_Data/MuBeta/';
saveMotorAvgPath = '/Users/danielcomstock/Documents/Data/AV_TapNoTap/Data/08_Comp_TF_Plots/MotorCompAvg/Power/';
saveMotorIndPath = '/Users/danielcomstock/Documents/Data/AV_TapNoTap/Data/08_Comp_TF_Plots/MotorCompInd/Power/LeftMotor/';

% File directory
allFiles = dir([loadF0ITCPath,'*.mat']);


%% ITC plotting

for conditionIDX = 1:4
    if conditionIDX == 1
        conMod  = 'Vis_Con.mat';    
    elseif conditionIDX == 2
        conMod  = 'Vis_Tap.mat';
    elseif conditionIDX == 3
        conMod  = 'Aud_Con.mat';
    elseif conditionIDX == 4
        conMod  = 'Aud_Tap.mat';
    end
    
    for subIDX = 1:length(MotorClusters)
        
        % load absoluteValue ERSP data
        fileName = [MotorClusters(subIDX).sub conMod];
        saveName = fileName(1:end-4);

        fullLoad = [loadMuBetaPath fileName];
        
        load(fullLoad);
        
        lmc = MotorClusters(subIDX).lm(1);
        
        ibERSP = TF_data.MuBetaInd(lmc).ersp;
        tfdata = TF_data.MuBetaInd(lmc).tfdata;
        times = TF_data.MuBetaTimes;
        freqs = TF_data.MuBetaFreqs;
        
        % convert tfdata to absolute power
        absERSP = 10*log10(mean(abs(tfdata).^2,3));
        
        % Compute absolute highest ERSP values in the Average ERSP for symetrical scalling
        abserspmax = [max(max(absERSP))];
        abserspmin = [min(min(absERSP))];
        % convert absolute highest ERSP values for symetrical scale
        abserspminmax = [abserspmin abserspmax];  
        
        % Compute absolute highest ERSP values in the Average ERSP for symetrical scalling
        iberspmax = [max(max(abs(ibERSP)))];
        % convert absolute highest ERSP values for symetrical scale
        iberspminmax = [-iberspmax iberspmax];  
        
        MotorERSP_Avg.data(subIDX).absERSP = absERSP;
        MotorERSP_Avg.data(subIDX).ibERSP = ibERSP;
        MotorERSP_Avg.times = times;
        MotorERSP_Avg.freqs = freqs;
        
%         %% Plot absERSP
%         
%         tempname = [saveName '_ABS_Power'];
%         titleName = strrep(tempname, '_', ' ');
%         
%         figure; imagesc(times, freqs, absERSP, abserspminmax); 
%         % sets scaling direction
%         set(gca, 'ydir', 'normal'); 
%         % set font
%         set(gca, 'FontSize', 12, 'FontWeight', 'bold');
%         % set plotbackground to white
%         set(gcf,'color','w');
%         set(gcf,'PaperPositionMode','auto')
%         % set x & y coord limits and x ticks
%         xlim([-1215 1215]);
%         xticks([-1200 -600 0 600 1200])
%         xticklabels({'-1200', '-600', '0', '600', '1200'})
%         ylim([8 35]);
%         hold on;
%         % x axis label
%         xlabel('Time (ms)', 'FontSize',14, 'FontWeight', 'bold'); 
%         % y axis label
%         ylabel('Frequencies (Hz)', 'FontSize',14, 'FontWeight', 'bold'); 
%         % Set title and font
%       %  title(titleName, 'FontSize', 14, 'FontWeight','bold');
%         % adds colorbar to side showing color scale. Scale determined by
%         % erspmax
%         c=colorbar;
%         c.Label.String = 'power';
%         c.Label.Position = [.5 abserspmax*1.13];
%         c.Label.Rotation = 0;
%         colormap jet;
%         % Add lines
%         line([0 0],ylim,'color','k', 'LineWidth', 2, 'LineStyle','--');
%         line([600 600],ylim,'color','k', 'LineWidth', 2, 'LineStyle','--');
%         line([-600 -600],ylim,'color','k', 'LineWidth', 2, 'LineStyle','--');
%         line([1200 1200],ylim,'color','k', 'LineWidth', 2, 'LineStyle','--');
%         line([-1200 -1200],ylim,'color','k', 'LineWidth', 2, 'LineStyle','--');
% 
% 
%         % save as .fig file
%         ERSPfigfullsave = [saveMotorIndPath 'ABS/fig/' tempname];
%         savefig(ERSPfigfullsave);        
%         % save as .png file
%         ERSPfigfullsave = [saveMotorIndPath 'ABS/png/'  tempname];
%         saveas(gcf,ERSPfigfullsave,'png');        
%         % close figure
%         close;
%         
%         clear absERSP abserspmin abserspmax abserspminmax tfdata
        
        
        %% Plot individual condition baseline ERSP
        
        tempname = [saveName '_IB_ERSP'];
        titleName = strrep(tempname, '_', ' ');
        
        figure; imagesc(times, freqs, ibERSP, iberspminmax); 
        % sets scaling direction
        set(gca, 'ydir', 'normal'); 
        % set font
        set(gca, 'FontSize', 12, 'FontWeight', 'bold');
        % set plotbackground to white
        set(gcf,'color','w');
        set(gcf,'PaperPositionMode','auto')
        % set x & y coord limits and x ticks
        xlim([-1215 1215]);
        xticks([-1200 -600 0 600 1200])
        xticklabels({'-1200', '-600', '0', '600', '1200'})
        ylim([8 35]);
        hold on;
        % x axis label
        xlabel('Time (ms)', 'FontSize',14, 'FontWeight', 'bold'); 
        % y axis label
        ylabel('Frequencies (Hz)', 'FontSize',14, 'FontWeight', 'bold'); 
        % Set title and font
        title(titleName, 'FontSize', 14, 'FontWeight','bold');
        % adds colorbar to side showing color scale. Scale determined by
        % erspmax
        c=colorbar;
        c.Label.String = 'dB';
        c.Label.Position = [.5 iberspminmax*1.13];
        c.Label.Rotation = 0;
        colormap jet;
        % Add lines
        line([0 0],ylim,'color','k', 'LineWidth', 2, 'LineStyle','--');
        line([600 600],ylim,'color','k', 'LineWidth', 2, 'LineStyle','--');
        line([-600 -600],ylim,'color','k', 'LineWidth', 2, 'LineStyle','--');
        line([1200 1200],ylim,'color','k', 'LineWidth', 2, 'LineStyle','--');
        line([-1200 -1200],ylim,'color','k', 'LineWidth', 2, 'LineStyle','--');


        % save as .fig file
        ERSPfigfullsave = [saveMotorIndPath 'indBase/fig/' tempname];
        savefig(ERSPfigfullsave);        
        % save as .png file
        ERSPfigfullsave = [saveMotorIndPath 'indBase/png/'  tempname];
        saveas(gcf,ERSPfigfullsave,'png');        
        % close figure
        close;
        
        clear ibERSP iberspmax iberspminmax
        
        
        
    end
    
    %% Plot Avg ERSPs
    
    % concatenate left motor ERSP
    for subIDX = 1:length(MotorClusters)
%         absERSP(:,:,subIDX)=MotorERSP_Avg.data(subIDX).absERSP;
        ibERSP(:,:,subIDX)=MotorERSP_Avg.data(subIDX).ibERSP;
    end
    
    % Compute absolute highest ERSP values in the Average ERSP for symetrical scalling
%     avgabsERSP = mean(absERSP,3); 
    avgibERSP = mean(ibERSP,3);

%     avgabserspmax = [max(max(avgabsERSP))];
%     avgabserspmin = [min(min(avgabsERSP))];
    avgiberspmax = [max(max(abs(avgibERSP)))];
    
    % convert absolute highest ERSP values for symetrical scale
    avgabserspminmax = [avgabserspmin avgabserspmax]; 
    avgiberspminmax = [-avgiberspmax avgiberspmax]; 

%     %% Plot Average absERSP
%         
%         tempname = [conMod(1:end-4) '_Left_Motor_ABS_Power'];
%         titleName = strrep(tempname, '_', ' ');
%         
%         figure; imagesc(times, freqs, avgabsERSP, avgabserspminmax); 
%         % sets scaling direction
%         set(gca, 'ydir', 'normal'); 
%         % set font
%         set(gca, 'FontSize', 12, 'FontWeight', 'bold');
%         % set plotbackground to white
%         set(gcf,'color','w');
%         set(gcf,'PaperPositionMode','auto')
%         % set x & y coord limits and x ticks
%         xlim([-1215 1215]);
%         xticks([-1200 -600 0 600 1200])
%         xticklabels({'-1200', '-600', '0', '600', '1200'})
%         ylim([8 35]);
%         hold on;
%         % x axis label
%         xlabel('Time (ms)', 'FontSize',14, 'FontWeight', 'bold'); 
%         % y axis label
%         ylabel('Frequencies (Hz)', 'FontSize',14, 'FontWeight', 'bold'); 
%         % Set title and font
%         title(titleName, 'FontSize', 14, 'FontWeight','bold');
%         % adds colorbar to side showing color scale. Scale determined by
%         % erspmax
%         c=colorbar;
%         c.Label.String = 'power';
%         c.Label.Position = [.5 avgabserspminmax*1.13];
%         c.Label.Rotation = 0;
%         colormap jet;
%         % Add lines
%         line([0 0],ylim,'color','k', 'LineWidth', 2, 'LineStyle','--');
%         line([600 600],ylim,'color','k', 'LineWidth', 2, 'LineStyle','--');
%         line([-600 -600],ylim,'color','k', 'LineWidth', 2, 'LineStyle','--');
%         line([1200 1200],ylim,'color','k', 'LineWidth', 2, 'LineStyle','--');
%         line([-1200 -1200],ylim,'color','k', 'LineWidth', 2, 'LineStyle','--');
% 
% 
%         % save as .fig file
%         ERSPfigfullsave = [saveMotorAvgPath 'fig/' tempname];
%         savefig(ERSPfigfullsave);        
%         % save as .png file
%         ERSPfigfullsave = [saveMotorAvgPath 'png/'  tempname];
%         saveas(gcf,ERSPfigfullsave,'png');        
%         % close figure
%         close;
        
        %% Plot Average ibERSP
        
        tempname = [conMod(1:end-4) '_Left_Motor_IB_ERSP'];
        titleName = strrep(tempname, '_', ' ');
        
        figure; imagesc(times, freqs, avgibERSP, avgiberspminmax); 
        % sets scaling direction
        set(gca, 'ydir', 'normal'); 
        % set font
        set(gca, 'FontSize', 12, 'FontWeight', 'bold');
        % set plotbackground to white
        set(gcf,'color','w');
        set(gcf,'PaperPositionMode','auto')
        % set x & y coord limits and x ticks
        xlim([-1215 1215]);
        xticks([-1200 -600 0 600 1200])
        xticklabels({'-1200', '-600', '0', '600', '1200'})
        ylim([8 35]);
        hold on;
        % x axis label
        xlabel('Time (ms)', 'FontSize',14, 'FontWeight', 'bold'); 
        % y axis label
        ylabel('Frequencies (Hz)', 'FontSize',14, 'FontWeight', 'bold'); 
        % Set title and font
        title(titleName, 'FontSize', 14, 'FontWeight','bold');
        % adds colorbar to side showing color scale. Scale determined by
        % erspmax
        c=colorbar;
        c.Label.String = 'dB';
        c.Label.Position = [.5 avgiberspminmax*1.13];
        c.Label.Rotation = 0;
        colormap jet;
        % Add lines
        line([0 0],ylim,'color','k', 'LineWidth', 2, 'LineStyle','--');
        line([600 600],ylim,'color','k', 'LineWidth', 2, 'LineStyle','--');
        line([-600 -600],ylim,'color','k', 'LineWidth', 2, 'LineStyle','--');
        line([1200 1200],ylim,'color','k', 'LineWidth', 2, 'LineStyle','--');
        line([-1200 -1200],ylim,'color','k', 'LineWidth', 2, 'LineStyle','--');


        % save as .fig file
        ERSPfigfullsave = [saveMotorAvgPath 'fig/' tempname];
        savefig(ERSPfigfullsave);        
        % save as .png file
        ERSPfigfullsave = [saveMotorAvgPath 'png/'  tempname];
        saveas(gcf,ERSPfigfullsave,'png');        
        % close figure
        close;        
    
    % save data
    
    fullDataSave = [saveMotorAvgPath 'data/' titleName];
    save(fullDataSave, 'MotorERSP_Avg');

    clear avgabsERSP avgibERSP avgabserspmax avgabserspmin avgiberspmax avgabserspminmax avgiberspminmax MotorERSP_Avg
end
    
    
    
    
        
        

        
        
        
        
        
        
        
        
        

        
    
    
    





