% transform and plot ITC and Power data

clear

% filePaths
loadPath = '/Users/danielcomstock/Documents/Data/AV_TapNoTap/Data/07b_f02_tfStatsPlotData/';
savePath = '/Users/danielcomstock/Documents/Data/AV_TapNoTap/Data/newFigData/';

% loadname lists
condNames = ["Aud_Con.mat","Aud_Tap.mat","Vis_Con.mat","Vis_Tap.mat"];
avgTypes = ["AvgAll_","LeftMotor_"];

lableNames = {'Aud Con','Aud Tap','Vis Con','Vis Tap'};

%ITC plots

for typeIDX = 1:length(avgTypes)
    
    saveName = ['ITC_' char(avgTypes(typeIDX))];
    titleName = strrep(saveName, '_', ' ');
    
    for condIDX = 1:length(condNames)
        
        fileName = ['ITC_' char(avgTypes(typeIDX)) char(condNames(condIDX))];
        
        fullLoad = [loadPath fileName];
        
        load(fullLoad);
         
        
        
        % change data variable names to standard name tfdata
        if exist('leftMotorITC','var') == 1
            tfData = leftMotorITC;
            clear leftMotorITC
        elseif exist('rightMotorITC','var') == 1
            tfData = rightMotorITC;
            clear rightMotorITC
        elseif exist('SubAllAvgITC','var') == 1
            tfData = SubAllAvgITC;
            clear SubAllAvgITC
        elseif exist('SubAvgMinLMotorITC','var') == 1
            tfData = SubAvgMinLMotorITC;
            clear SubAvgMinLMotorITC
        elseif exist('SubAvgMinLR_MotorITC','var') == 1
            tfData = SubAvgMinLR_MotorITC;
            clear SubAvgMinLR_MotorITC
        end
       
        %transform and save data for plotting
        tempdata = mean(tfData,2);
        tempdata = squeeze(tempdata);
        indPlotData(:,:,condIDX) = tempdata(1:61,:);
        avgPlotData(:,condIDX) = mean(tempdata(1:61,:),2);
        
        
        
        clear tfData tempdata
    end
    
    % save data for stats
    
    plotFreqs = freqs(1:61);
    
    
    statsData.indITCData = indPlotData;
    statsData.avgITCData = avgPlotData;
    statsData.freqs = freqs;
    statsData.plotFreqs = plotFreqs;
    statsData.times = times;
    
    % Calculate confidence interval
    stdErrAudCon = std(indPlotData(:,:,1).')/sqrt(size(indPlotData,2));
    CI95 = tinv([0.025 0.975], size(indPlotData,2)-1);
    audConCI95 = stdErrAudCon*CI95(2);

    stdErrAudTap = std(indPlotData(:,:,2).')/sqrt(size(indPlotData,2));
    CI95 = tinv([0.025 0.975], size(indPlotData,2)-1);
    audTapCI95 = stdErrAudTap*CI95(2);

    stdErrVisCon = std(indPlotData(:,:,3).')/sqrt(size(indPlotData,2));
    CI95 = tinv([0.025 0.975], size(indPlotData,2)-1);
    visConCI95 = stdErrVisCon*CI95(2);

    stdErrVisTap = std(indPlotData(:,:,4).')/sqrt(size(indPlotData,2));
    CI95 = tinv([0.025 0.975], size(indPlotData,2)-1);
    visTapCI95 = stdErrVisTap*CI95(2);
            
    
    
    % plot f0 ITC
    
    figure; 
    subplot(4,1,1);
    shadedErrorBar2(plotFreqs, avgPlotData(:,1), audConCI95,'lineprops',{'-r','LineWidth', 2,'markerfacecolor','r'});
    title(char(lableNames(1)), 'FontSize', 10, 'FontWeight','bold');
    ylim([0 1]);
    xlim([1 7.1]);
    
    subplot(4,1,2);
    shadedErrorBar2(plotFreqs, avgPlotData(:,2), audTapCI95,'lineprops',{'-r','LineWidth', 2,'markerfacecolor','r'});
    title(char(lableNames(2)), 'FontSize', 10, 'FontWeight','bold');
    ylim([0 1]);
    xlim([1 7.1]);
    
    subplot(4,1,3);
    shadedErrorBar2(plotFreqs, avgPlotData(:,3), visConCI95,'lineprops',{'-r','LineWidth', 2,'markerfacecolor','r'});
    title(char(lableNames(3)), 'FontSize', 10, 'FontWeight','bold');
    ylim([0 1]);
    xlim([1 7.1]);
    
    subplot(4,1,4);
    shadedErrorBar2(plotFreqs, avgPlotData(:,4), visTapCI95,'lineprops',{'-r','LineWidth', 2,'markerfacecolor','r'});
    title(char(lableNames(4)), 'FontSize', 10, 'FontWeight','bold');
    ylim([0 1]);
    xlim([1 7.1]);
    

    figSave = [savePath  saveName];
    pngSave = [savePath  saveName];
    
    savefig(figSave);
    saveas(gcf,pngSave,'png');
    
    close; 
    clear s indPlotData avgPlotData statsdata
    
end
    
   
% for IDX = 1:4
%     ITC_avg(:,:,IDX) = mean(statsData.data(IDX).tfData,2);
%     tempData = ITC_avg(7,:,IDX);
%     f0ITC_avg(:,IDX) = tempData;
% end
% 
% freqs = statsData.freqs;
% 
% 
% for IDX = 1:4
%     ITC_LMotor(:,:,IDX) = mean(statsData.data(IDX).tfData,2);
%     tempData = ITC_LMotor(7,:,IDX);
%     f0ITC_LMotor(:,IDX) = tempData;
% end
% freqs = statsData.freqs;

    
    
    
        
        



