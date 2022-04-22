% transform and plot ITC and Power data

clear

% filePaths
loadPath = '/Users/danielcomstock/Documents/Data/AV_TapNoTap/Data/07b_f02_tfStatsPlotData/';
savePath = '/Users/danielcomstock/Documents/Data/AV_TapNoTap/Data/08d_IndSplitf02Plots/';

% loadname lists
condNames = ["Aud_Con.mat","Aud_Tap.mat","Vis_Con.mat","Vis_Tap.mat"];
avgTypes = ["AvgAll_","AvgMinLeftMotor_","AvgMinLRMotor_","LeftMotor_","RightMotor_"];

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
        musicianIDX =[1,2,3,9,10,13,17,18];
        nonMusicanIDX = [4,5,6,7,8,11,12,14,15,16];
        
        indPlotData(:,:,condIDX) = tempdata(1:61,:);
        avgPlotData(:,condIDX) = mean(tempdata(1:61,:),2);
        
        
        
        clear tfData tempdata
    end
    
    muscianPlotData = indPlotData(:,musicianIDX,:);
    nonMusicianPlotData = indPlotData(:,nonMusicanIDX,:);
    % save data for stats
    
    plotFreqs = freqs(1:61);
    
    
    statsData.musicITCData = muscianPlotData;
    statsData.noMusicITCData = nonMusicianPlotData;
    statsData.freqs = freqs;
    statsData.plotFreqs = plotFreqs;
    statsData.times = times;
    
    
    
    % plot f0 ITC
    
    figure; 
    subplot(4,1,1);
    hold on
    plot(plotFreqs,mean(muscianPlotData(:,:,1),2),'-g', 'LineWidth', 1)
    plot(plotFreqs,mean(nonMusicianPlotData(:,:,1),2),'-r', 'LineWidth', 1)
    hold off
    title(char(lableNames(1)), 'FontSize', 10, 'FontWeight','bold');
    ylim([0 1]);
    xlim([1 7.1]);
    
    subplot(4,1,2);
    hold on
    plot(plotFreqs,mean(muscianPlotData(:,:,2),2),'-g', 'LineWidth', 1)
    plot(plotFreqs,mean(nonMusicianPlotData(:,:,2),2),'-r', 'LineWidth', 1)
    hold off
    title(char(lableNames(2)), 'FontSize', 10, 'FontWeight','bold');
    ylim([0 1]);
    xlim([1 7.1]);
    
    subplot(4,1,3);
    hold on
    plot(plotFreqs,mean(muscianPlotData(:,:,3),2),'-g', 'LineWidth', 1)
    plot(plotFreqs,mean(nonMusicianPlotData(:,:,3),2),'-r', 'LineWidth', 1)
    hold off
    title(char(lableNames(3)), 'FontSize', 10, 'FontWeight','bold');
    ylim([0 1]);
    xlim([1 7.1]);
    
    subplot(4,1,4);
    hold on
    plot(plotFreqs,mean(muscianPlotData(:,:,4),2),'-g', 'LineWidth', 1)
    plot(plotFreqs,mean(nonMusicianPlotData(:,:,4),2),'-r', 'LineWidth', 1)
    hold off
    title(char(lableNames(4)), 'FontSize', 10, 'FontWeight','bold');
    ylim([0 1]);
    xlim([1 7.1]);
    
    dataSave = [savePath 'data/' saveName];
    figSave = [savePath 'fig/' saveName];
    pngSave = [savePath 'png/' saveName];
    
    save(dataSave, 'statsData');
    savefig(figSave);
    saveas(gcf,pngSave,'png');
    
    close; 
    clear s indPlotData avgPlotData statsdata
    
end
    
   

    
    
    
    
        
        



