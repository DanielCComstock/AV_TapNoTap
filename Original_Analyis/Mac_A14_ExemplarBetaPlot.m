%% plot beta power and f0 ITC for selected motor components

clear

%% Create Component Matrix for plotting

MotorClusters.sub = 'AVTapNoTap9';



MotorClusters.lm = 14;


%% Data loading

% file paths
loadMuBetaPath = '/Users/danielcomstock/Documents/Data/AV_TapNoTap/Data/07_Comp_TF_Data/MuBeta/';
saveMotorIndPath = '/Users/danielcomstock/Documents/Data/AV_TapNoTap/Data/ExtraFigs/';

% File directory
allFiles = dir([loadMuBetaPath,'*.mat']);


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
    

        
        % load absoluteValue ERSP data
        fileName = [MotorClusters.sub conMod];
        saveName = fileName(1:end-4);

        fullLoad = [loadMuBetaPath fileName];
        
        load(fullLoad);
        
        lmc = MotorClusters.lm;
        
        ibERSP = TF_data.MuBetaInd(lmc).ersp;
        times = TF_data.MuBetaTimes;
        freqs = TF_data.MuBetaFreqs;
        
        
        % Compute absolute highest ERSP values in the Average ERSP for symetrical scalling
        iberspmax = 4%[max(max(abs(ibERSP)))];
        % convert absolute highest ERSP values for symetrical scale
        iberspminmax = [-iberspmax iberspmax];  
               

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
        ERSPfigfullsave = [saveMotorIndPath tempname];
        savefig(ERSPfigfullsave);        
        % save as .png file
        ERSPfigfullsave = [saveMotorIndPath tempname];
        saveas(gcf,ERSPfigfullsave,'png');        
        % close figure
        close;
        
        clear ibERSP iberspmax iberspminmax

end
    
    
    
    
        
        

        
        
        
        
        
        
        
        
        

        
    
    
    





