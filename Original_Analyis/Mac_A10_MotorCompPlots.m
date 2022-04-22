%% plot beta power and f0 ITC for selected motor components

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
MotorClusters(3).lm = [9 10];
MotorClusters(4).lm = 6;
MotorClusters(5).lm = [10 7];
MotorClusters(6).lm = [8 15 24];
MotorClusters(7).lm = [6 16];
MotorClusters(8).lm = [14 11 2];
MotorClusters(9).lm = [11 14];
MotorClusters(10).lm = [6 5 14 21];
MotorClusters(11).lm = 20;
MotorClusters(12).lm = [16 9];
MotorClusters(13).lm = [5 11];
MotorClusters(14).lm = [3 9];
MotorClusters(15).lm = 7;
MotorClusters(16).lm = [14 9 12];
MotorClusters(17).lm = 3;
MotorClusters(18).lm = [15 13];

MotorClusters(1).rm = 8;
MotorClusters(2).rm = 7;
MotorClusters(3).rm = [12 11];
MotorClusters(4).rm = [11 14];
MotorClusters(5).rm = [8 9 16];
MotorClusters(6).rm = 13;
MotorClusters(7).rm = [3 7 8];
MotorClusters(8).rm = [8 4 6 7];
MotorClusters(9).rm = [7 21];
MotorClusters(10).rm = [3 10 11];
MotorClusters(11).rm = [3 15];
MotorClusters(12).rm = [10 18];
MotorClusters(13).rm = [4 13 14];
MotorClusters(14).rm = [1 17];
MotorClusters(15).rm = 9;
MotorClusters(16).rm = [2 4];
MotorClusters(17).rm = 7;
MotorClusters(18).rm = 2;

%% Data loading

% file paths
loadF0ITCPath = '/Users/danielcomstock/Documents/Data/AV_TapNoTap/Data/07_Comp_TF_Data/f0ITC/';
loadMuBetaPath = '/Users/danielcomstock/Documents/Data/AV_TapNoTap/Data/07_Comp_TF_Data/MuBeta/';
saveMotorAvgPath = '/Users/danielcomstock/Documents/Data/AV_TapNoTap/Data/08_Comp_TF_Plots/MotorCompAvg/';
saveMotorIndPath = '/Users/danielcomstock/Documents/Data/AV_TapNoTap/Data/08_Comp_TF_Plots/MotorCompInd/';

% File directory
allFiles = dir([loadF0ITCPath,'*.mat']);

% allFileNames = {allFiles.name}';
% visList = strfind(allFileNames, 'Vis');
% visIndex = find(~cellfun('isempty', visList));
% visSubs = allFileNames(visIndex);
% visTapList = strfind(visSubs, 'Vis_Tap');
% visTapIndex = find(~cellfun('isempty', visTapList)); % Obtain the index numbers of the 'vis tap' subjects.
% visTapSubs = visSubs(visTapIndex);
% visConIndex = find(cellfun('isempty', visTapList));
% visConSubs = visSubs(visConIndex);
% 
% audList = strfind(allFileNames, 'Aud');
% audIndex = find(~cellfun('isempty', audList));
% audSubs = allFileNames(audIndex);
% audTapList = strfind(audSubs, 'Aud_Tap');
% audTapIndex = find(~cellfun('isempty', audTapList)); 
% audTapSubs = audSubs(audTapIndex);
% audConIndex = find(cellfun('isempty', audTapList));
% audConSubs = audSubs(audConIndex);

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
    
    MotorITC_Avg = [];
    for subIDX = 1:length(MotorClusters)
        
        % load ITC data
        fileName = [MotorClusters(subIDX).sub conMod];
        saveName = fileName(1:end-4);
        titleName = [saveName '_LeftMotor'];
        fullLoad = [loadF0ITCPath fileName];
        
        lmc = MotorClusters(subIDX).lm(1);
        
        itc = eTF_dataW.Data(lmc).ITC;
        times = eTF_dataW.times;
        freqs = eTF_dataW.freqs;
        
        MotorITC_Avg(subIDX).itc = itc;
        MotorITC_Avg.times = times;
        MotorITC_Avg.freqs = freqs;
        
        % Compute absolute highest itc values in the Average itc for symetrical scalling
        ITCmax = [max(max(itc))];
        ITCmin = [min(min(itc))];
        % convert absolute highest itc values for symetrical scale
        ITCMinMax = [ITCmin ITCmax]; 
        
        %% Plot ITC Ind

        figure; 
        imagesc(times, freqs, itc, ITCMinMax); 
        % sets scaling direction
        set(gca, 'ydir', 'normal'); 
        % set font
        set(gca, 'FontSize', 12, 'FontWeight', 'bold');
        % set plotbackground to white
        set(gcf,'color','w');
        % set x & y coord limits
        xlim([-1200 1200]);
        xticks([ -600 0 600 ])
        xticklabels({'-600', '0', '600',})
        %ylim([8 50]);    
        % x axis label
        xlabel('Time (ms)', 'FontSize',14, 'FontWeight', 'bold'); 
        % y axis label
        ylabel('Frequencies (Hz)', 'FontSize',14, 'FontWeight', 'bold'); 
        % Set title and font
        title(titleName, 'FontSize', 14, 'FontWeight','bold');
        % adds colorbar to side showing color scale. Scale determined by
        % ITCMinMax
        c=colorbar;
        c.Label.String = 'ITC';
        c.Label.Position = [.5 ITCmax*1.05];
        c.Label.Rotation = 0;
        % Sets limits of colorbar
        set(c,'Ylim',[ITCmin ITCmax]);
        % Sets the color map to half scale (just uses the warm portion of jet)
        cmap=jet(256);
        colormap(cmap(128:256,:));
        % Add lines
        line([0 0],ylim,'color','k', 'LineWidth', 2, 'LineStyle','--');
        line([600 600],ylim,'color','k', 'LineWidth', 2, 'LineStyle','--');
        line([-600 -600],ylim,'color','k', 'LineWidth', 2, 'LineStyle','--');

        % save as .fig file
        ITCfigfullsave = [saveMotorIndPath '/fig/' savename];
        savefig(ITCfigfullsave);        
        % save as .png file
        ITCfigfullsave = [saveMotorIndPath '/png/'  savename];
        saveas(gcf,ITCfigfullsave,'png');        
        % close figure
        close;
        
        clear itc ITCMinMax
        
    end
    
    %% Plot Avg Motor ITC
    
    % concatenate left motor ITC
    for subIDX = 1:length(MotorClusters)
        itc(:,:,subIDX)=MotorITC_Avg(subIDX).itc;
    end
    
    % Compute absolute highest itc values in the Average itc for symetrical scalling
    ITCmax = [max(max(itc))];
    ITCmin = [min(min(itc))];
    % convert absolute highest itc values for symetrical scale
    ITCMinMax = [ITCmin ITCmax]; 

    %% Plot ITC Ind
    
    titleName = 


    figure; 
    imagesc(times, freqs, itc, ITCMinMax); 
    % sets scaling direction
    set(gca, 'ydir', 'normal'); 
    % set font
    set(gca, 'FontSize', 12, 'FontWeight', 'bold');
    % set plotbackground to white
    set(gcf,'color','w');
    % set x & y coord limits
    xlim([-1200 1200]);
    xticks([ -600 0 600 ])
    xticklabels({'-600', '0', '600',})
    %ylim([8 50]);    
    % x axis label
    xlabel('Time (ms)', 'FontSize',14, 'FontWeight', 'bold'); 
    % y axis label
    ylabel('Frequencies (Hz)', 'FontSize',14, 'FontWeight', 'bold'); 
    % Set title and font
    title(titleName, 'FontSize', 14, 'FontWeight','bold');
    % adds colorbar to side showing color scale. Scale determined by
    % ITCMinMax
    c=colorbar;
    c.Label.String = 'ITC';
    c.Label.Position = [.5 ITCmax*1.05];
    c.Label.Rotation = 0;
    % Sets limits of colorbar
    set(c,'Ylim',[ITCmin ITCmax]);
    % Sets the color map to half scale (just uses the warm portion of jet)
    cmap=jet(256);
    colormap(cmap(128:256,:));
    % Add lines
    line([0 0],ylim,'color','k', 'LineWidth', 2, 'LineStyle','--');
    line([600 600],ylim,'color','k', 'LineWidth', 2, 'LineStyle','--');
    line([-600 -600],ylim,'color','k', 'LineWidth', 2, 'LineStyle','--');

    % save as .fig file
    ITCfigfullsave = [saveMotorIndPath '/fig/' savename];
    savefig(ITCfigfullsave);        
    % save as .png file
    ITCfigfullsave = [saveMotorIndPath '/png/'  savename];
    saveas(gcf,ITCfigfullsave,'png');        
    % close figure
    close;

    clear itc ITCMinMax
    
    
    
    
        
        

        
        
        
        
        
        
        
        
        

        
    
    
    





