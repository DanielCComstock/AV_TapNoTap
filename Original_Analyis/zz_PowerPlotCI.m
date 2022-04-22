% transform and plot ITC and Power data

clear

% filePaths
loadPath = '/Users/danielcomstock/Documents/Data/AV_TapNoTap/Data/07b_f02_tfStatsPlotData/';
savePath = '/Users/danielcomstock/Documents/Data/AV_TapNoTap/Data/08c_Indf02Plots/';

% loadname lists
condNames = ["Aud_Con.mat","Aud_Tap.mat","Vis_Con.mat","Vis_Tap.mat"];
avgTypes = ["AvgAll_","AvgMinLeftMotor_","AvgMinLRMotor_","LeftMotor_","RightMotor_"];

lableNames = {'Aud Still','Aud Tap','Vis Still','Vis Tap'};




    
   
            % Calculate confidence interval
            stdErrAudCon = std(neighborCorrectedData(:,:,1).')/sqrt(size(neighborCorrectedData,2));
            CI95 = tinv([0.025 0.975], size(neighborCorrectedData,2)-1);
            audConCI95 = stdErrAudCon*CI95(2);
            
            stdErrAudTap = std(neighborCorrectedData(:,:,2).')/sqrt(size(neighborCorrectedData,2));
            CI95 = tinv([0.025 0.975], size(neighborCorrectedData,2)-1);
            audTapCI95 = stdErrAudTap*CI95(2);
            
            stdErrVisCon = std(neighborCorrectedData(:,:,3).')/sqrt(size(neighborCorrectedData,2));
            CI95 = tinv([0.025 0.975], size(neighborCorrectedData,2)-1);
            visConCI95 = stdErrVisCon*CI95(2);
            
            stdErrVisTap = std(neighborCorrectedData(:,:,4).')/sqrt(size(neighborCorrectedData,2));
            CI95 = tinv([0.025 0.975], size(neighborCorrectedData,2)-1);
            visTapCI95 = stdErrVisTap*CI95(2);
            




            %% Plot & save Beta With 95 Confidence interval



    
    
    % plot f0 power
    
    figure;
    set(gcf,'color','w');
    subplot(4,1,1);

    shadedErrorBar2(correctedFreqs, avgNeighborCorrectedLMotorData(:,1), audConCI95,'lineprops',{'-b','LineWidth', 2,'markerfacecolor','b'});

    title(char(lableNames(1)), 'FontSize', 10, 'FontWeight','bold');
    xlim([1 7.1]);
    ylim([-2 6]);
    yticks([0 3 6])
    yticklabels({'0','3','6'})
    set(gca, 'FontSize', 12, 'FontName','Helvetica','LineWidth',1,'FontWeight', 'bold');
    
    subplot(4,1,2);

    shadedErrorBar2(correctedFreqs, avgNeighborCorrectedLMotorData(:,2), audTapCI95,'lineprops',{'-b','LineWidth', 2,'markerfacecolor','b'});

    title(char(lableNames(2)), 'FontSize', 10, 'FontWeight','bold');
    xlim([1 7.1]);
    ylim([-2 6]);
    yticks([0 3 6])
    yticklabels({'0','3','6'})
    set(gca, 'FontSize', 12, 'FontName','Helvetica','LineWidth',1,'FontWeight', 'bold');
    
    subplot(4,1,3);
    shadedErrorBar2(correctedFreqs, avgNeighborCorrectedLMotorData(:,3), visConCI95,'lineprops',{'-b','LineWidth', 2,'markerfacecolor','b'});
    title(char(lableNames(3)), 'FontSize', 10, 'FontWeight','bold');
    xlim([1 7.1]);
    ylim([-2 6]);
    yticks([0 3 6])
    yticklabels({'0','3','6'})
    set(gca, 'FontSize', 12, 'FontName','Helvetica','LineWidth',1,'FontWeight', 'bold');
    
    subplot(4,1,4);
    shadedErrorBar2(correctedFreqs, avgNeighborCorrectedLMotorData(:,4), visTapCI95,'lineprops',{'-b','LineWidth', 2,'markerfacecolor','b'});
    title(char(lableNames(4)), 'FontSize', 10, 'FontWeight','bold');
    xlim([1 7.1]);
    ylim([-2 6]);
    yticks([0 3 6])
    yticklabels({'0','3','6'})
    set(gca, 'FontSize', 12, 'FontName','Helvetica','LineWidth',1,'FontWeight', 'bold');
    
%     figSave = [savePath 'fig/New' saveName '_4'];
%     pngSave = [savePath 'png/New' saveName '_4'];
%     
%     savefig(figSave);
%     saveas(gcf,pngSave,'png');
%     
%     close;
%     clear s correctedPlotData neighborCorrectedData
    

   
% Power plots


        
    
    
    
    
        
        



