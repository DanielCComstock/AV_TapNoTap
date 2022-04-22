% transform and plot ITC and Power data

clear

% filePaths
loadPath = '/Users/danielcomstock/Documents/Data/AV_TapNoTap/Data/07b_f02_tfStatsPlotData/';
savePath = '/Users/danielcomstock/Documents/Data/AV_TapNoTap/Data/08b_Avgf02Plots/';

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
        tempdata = mean(tfData,3);
        plotdata(:,condIDX) = mean(tempdata(1:61,:),2);
        
        % save data for stats
        statsData.data(condIDX).tfData = tfData;
        statsData.freqs = freqs;
        statsData.times = times;
        
        clear tfData tempdata
    end
    
    plotFreqs = freqs(1:61);
    figure; 
    s = stackedplot(plotFreqs,plotdata,'Title',titleName,'DisplayLabels',lableNames,'Color','r','LineWidth',1);
    s.AxesProperties(1).YLimits = [0 0.55];
    s.AxesProperties(2).YLimits = [0 0.55];
    s.AxesProperties(3).YLimits = [0 0.55];
    s.AxesProperties(4).YLimits = [0 0.55];
    
%     figure; 
%     s = bar3(freqs,tableplotdata);
%     
%     figure; 
%     s = plot(freqs,tableplotdata,'LineWidth',2);
    
    dataSave = [savePath 'data/' saveName];
    figSave = [savePath 'fig/' saveName];
    pngSave = [savePath 'png/' saveName];
    
    save(dataSave, 'statsData');
    savefig(figSave);
    saveas(gcf,pngSave,'png');
    
    close; 
    clear s plotdata statsdata
    
end
    
   
% Power plots


%         % change data variable names to standard name tfdata
%         if exist('leftMotorPow','var') == 1
%             tfData = leftMotorPow;
%             clear leftMotorPow  
%         elseif exist('rightMotorPow','var') == 1
%             tfData = rightMotorPow;
%             clear rightMotorPow
%         elseif exist('SubAllAvgPow','var') == 1
%             tfData = SubAllAvgPow;
%             clear SubAllAvgPow
%         elseif exist('SubAvgMinLMotorPow','var') == 1
%             tfData = SubAvgMinLMotorPow;
%             clear SubAvgMinLMotorPow
%         elseif exist('SubAvgMinLR_MotorPow','var') == 1
%             tfData = SubAvgMinLR_MotorPow;
%             clear SubAvgMinLR_MotorPow
%         end
    
    
    
    
        
        



