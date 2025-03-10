% transform and plot ITC and Power data

clear

% filePaths
loadPath = '/Users/dcc/Data/AV_TapNoTap/Data/Revision1_Analysis/06d_f0ITCStimTrainStatsPlotTransformed/';
savePath = '/Users/dcc/Data/AV_TapNoTap/Data/Revision1_Analysis/07b_f0ITC_StimtrainPlots/';

% loadname lists
condNames = ["Aud_Con.mat","Aud_Tap.mat","Vis_Con.mat","Vis_Tap.mat"];
avgTypes = ["AvgAll_","LeftMotor_","RightMotor_"];

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
    

            
    
    
    % plot f0 ITC
    
    figure; 
    set(gcf,'color','w');
    subplot(4,1,1);
    hold on
    plot(plotFreqs,indPlotData(:,:,1),'-k', 'LineWidth', 0.5)
    plot(plotFreqs,avgPlotData(:,1),'-r', 'LineWidth', 2)
    hold off
    title(char(lableNames(1)), 'FontSize', 10, 'FontWeight','bold');
    ylim([0 1]);
    xlim([1 7.1]);
    set(gca, 'FontSize', 12, 'FontName','Helvetica','LineWidth',1,'FontWeight', 'bold');
    
    subplot(4,1,2);
    hold on
    plot(plotFreqs,indPlotData(:,:,2),'-k', 'LineWidth', 0.5)
    plot(plotFreqs,avgPlotData(:,2),'-r', 'LineWidth', 2)
    hold off
    title(char(lableNames(2)), 'FontSize', 10, 'FontWeight','bold');
    ylim([0 1]);
    xlim([1 7.1]);
    set(gca, 'FontSize', 12, 'FontName','Helvetica','LineWidth',1,'FontWeight', 'bold');
    
    subplot(4,1,3);
    hold on
    plot(plotFreqs,indPlotData(:,:,3),'-k', 'LineWidth', 0.5)
    plot(plotFreqs,avgPlotData(:,3),'-r', 'LineWidth', 2)
    hold off
    title(char(lableNames(3)), 'FontSize', 10, 'FontWeight','bold');
    ylim([0 1]);
    xlim([1 7.1]);
    set(gca, 'FontSize', 12, 'FontName','Helvetica','LineWidth',1,'FontWeight', 'bold');
    
    subplot(4,1,4);
    hold on
    plot(plotFreqs,indPlotData(:,:,4),'-k', 'LineWidth', 0.5)
    plot(plotFreqs,avgPlotData(:,4),'-r', 'LineWidth', 2)
    hold off
    title(char(lableNames(4)), 'FontSize', 10, 'FontWeight','bold');
    ylim([0 1]);
    xlim([1 7.1]);
    set(gca, 'FontSize', 12, 'FontName','Helvetica','LineWidth',1,'FontWeight', 'bold');
    
    dataSave = [savePath 'data/' saveName(1:end-1)];
    figSave = [savePath 'fig/' saveName(1:end-1)];
    pngSave = [savePath 'png/' saveName(1:end-1)];
    
    save(dataSave, 'statsData');
    savefig(figSave);
    saveas(gcf,pngSave,'png');
    
    close; 
    clear s indPlotData avgPlotData statsdata
    
end
    
   

    
    
    
        
        



