% transform and plot Power data

clear all

% filePaths
loadPath = '/Users/dcc/Data/AV_TapNoTap/Data/Revision1_Analysis/06g_f0Power_StatsPlotsTransformed/Amplitude/';
savePath = '/Users/dcc/Data/AV_TapNoTap/Data/Revision1_Analysis/07c_f0Power_StimtrainPlots/';

lableNames = {'Aud Control','Aud Tap','Vis Control','Vis Tap'};
allFiles = dir([loadPath,'*.mat']);


for fileIDX = 1:length(allFiles)

    fileName = allFiles(fileIDX).name;
    saveName = fileName(1:end-4);
    plotTitle = strrep(saveName, '-',' ');
    fullLoad = [loadPath fileName];
    load(fullLoad);


    % Calculate confidence interval
    stdErrAudCon = std(freqData(:,:,1))/sqrt(size(freqData,1));
    CI95 = tinv([0.025 0.975], size(freqData,1)-1);
    audConCI95 = stdErrAudCon*CI95(2);
    
    stdErrAudTap = std(freqData(:,:,2))/sqrt(size(freqData,1));
    CI95 = tinv([0.025 0.975], size(freqData,1)-1);
    audTapCI95 = stdErrAudTap*CI95(2);
    
    stdErrVisCon = std(freqData(:,:,3))/sqrt(size(freqData,1));
    CI95 = tinv([0.025 0.975], size(freqData,1)-1);
    visConCI95 = stdErrVisCon*CI95(2);
    
    stdErrVisTap = std(freqData(:,:,4))/sqrt(size(freqData,1));
    CI95 = tinv([0.025 0.975], size(freqData,1)-1);
    visTapCI95 = stdErrVisTap*CI95(2);

    % find max vaules for scaling

    maxD(1) = max(mean(freqData(:,:,1),1));
    maxD(2) = max(mean(freqData(:,:,2),1));
    maxD(3) = max(mean(freqData(:,:,3),1));
    maxD(4) = max(mean(freqData(:,:,4),1));
    maxY = max(maxD);
    maxY = round(maxY*1.05,1);

    minD(1) = min(mean(freqData(:,:,1),1));
    minD(2) = min(mean(freqData(:,:,2),1));
    minD(3) = min(mean(freqData(:,:,3),1));
    minD(4) = min(mean(freqData(:,:,4),1));
    minY = min(minD);
    minY = round(minY*1.05,1);
            

    %% Plot & save Beta With 95 Confidence interval

    % plot f0 power
    
    figure;
    set(gcf,'color','w');
    subplot(4,1,1);

    shadedErrorBar2(freqs, mean(freqData(:,:,1),1), audConCI95,'lineprops',{'-b','LineWidth', 2,'markerfacecolor','b'});

    title(char(lableNames(1)), 'FontSize', 10, 'FontWeight','bold');
    xlim([1 7.1]);
    ylim([minY maxY]);
%     ylim([-1 1]);
%     yticks([0 0.5 1])
%     yticklabels({'0','0.5','1'})
    set(gca, 'FontSize', 12, 'FontName','Helvetica','LineWidth',1,'FontWeight', 'bold');
    
    subplot(4,1,2);

    shadedErrorBar2(freqs, mean(freqData(:,:,2),1), audTapCI95,'lineprops',{'-b','LineWidth', 2,'markerfacecolor','b'});

    title(char(lableNames(2)), 'FontSize', 10, 'FontWeight','bold');
    xlim([1 7.1]);
    ylim([minY maxY]);
%     ylim([-1 1]);
%     yticks([0 0.5 1])
%     yticklabels({'0','0.5','1'})
    set(gca, 'FontSize', 12, 'FontName','Helvetica','LineWidth',1,'FontWeight', 'bold');
    
    subplot(4,1,3);
    shadedErrorBar2(freqs, mean(freqData(:,:,3),1), visConCI95,'lineprops',{'-b','LineWidth', 2,'markerfacecolor','b'});
    title(char(lableNames(3)), 'FontSize', 10, 'FontWeight','bold');
    xlim([1 7.1]);
    ylim([minY maxY]);
%     ylim([-1 1]);
%     yticks([0 0.5 1])
%     yticklabels({'0','0.5','1'})
    set(gca, 'FontSize', 12, 'FontName','Helvetica','LineWidth',1,'FontWeight', 'bold');
    
    subplot(4,1,4);
    shadedErrorBar2(freqs, mean(freqData(:,:,4),1), visTapCI95,'lineprops',{'-b','LineWidth', 2,'markerfacecolor','b'});
    title(char(lableNames(4)), 'FontSize', 10, 'FontWeight','bold');
    xlim([1 7.1]);
    ylim([minY maxY]);
%     ylim([-1 1]);
%     yticks([0 0.5 1])
%     yticklabels({'0','0.5','1'})
    set(gca, 'FontSize', 12, 'FontName','Helvetica','LineWidth',1,'FontWeight', 'bold');
    
    figSave = [savePath 'fig/' saveName '_Amp4'];
    pngSave = [savePath 'png/' saveName '_Amp4'];
    
    savefig(figSave);
    saveas(gcf,pngSave,'png');
    
    close;
    clear s freqData 

end
    

   
% Power plots


        
    
    
    
    
        
        



