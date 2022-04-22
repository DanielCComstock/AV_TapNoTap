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
    
    saveName = ['Pow_' char(avgTypes(typeIDX))];
    titleName = strrep(saveName, '_', ' ');
    
    for condIDX = 1:length(condNames)
        
        fileName = ['Power_' char(avgTypes(typeIDX)) char(condNames(condIDX))];
        
        fullLoad = [loadPath fileName];
        
        load(fullLoad);
        

        
        % change data variable names to standard name tfdata
        if exist('leftMotorPow','var') == 1
            tfData = leftMotorPow;
            clear leftMotorPow  
        elseif exist('rightMotorPow','var') == 1
            tfData = rightMotorPow;
            clear rightMotorPow
        elseif exist('SubAllAvgPow','var') == 1
            tfData = SubAllAvgPow;
            clear SubAllAvgPow
        elseif exist('SubAvgMinLMotorPow','var') == 1
            tfData = SubAvgMinLMotorPow;
            clear SubAvgMinLMotorPow
        elseif exist('SubAvgMinLR_MotorPow','var') == 1
            tfData = SubAvgMinLR_MotorPow;
            clear SubAvgMinLR_MotorPow
        end
       
        %transform and save data for plotting
        tempdata = mean(tfData,2);
        tempdata = squeeze(tempdata);
        %tempdata2 = tempdata(70:131,:);
        rawPlotData(:,condIDX) = mean(tempdata(85:116,:),2);
        rawPlotFreqs = freqs(85:116);
        %tempdata2 = mean(tempdata,2);
        correctedFreqs = freqs(1:61);
        for subIDX = 1:size(tfData,3)
            
            for freqIDX = 5:length(correctedFreqs)
                neighborIDX = [freqIDX-4 freqIDX-3 freqIDX+3 freqIDX+4];
                neighborAvg = mean(tempdata(neighborIDX,subIDX));
                neighborCorrectedData(freqIDX,subIDX,condIDX) = tempdata(freqIDX,subIDX) - neighborAvg;
            end
        end
            
        
        
        
        clear tfData tempdata
    end
    
    % save data for stats
    statsData.neighborCorrectedData = neighborCorrectedData;
    statsData.freqs = correctedFreqs;
    
    correctedPlotData = mean(neighborCorrectedData,2);
    correctedPlotData = squeeze(correctedPlotData);
    
    figure; 
    s = stackedplot(rawPlotFreqs,rawPlotData,'Title',titleName,'DisplayLabels',lableNames,'Color','r','LineWidth',1);
    
    s.AxesProperties(1).YLimits = [0 45];
    s.AxesProperties(2).YLimits = [0 45];
    s.AxesProperties(3).YLimits = [0 45];
    s.AxesProperties(4).YLimits = [0 45];

    dataSave = [savePath 'data/' saveName];
    figSave = [savePath 'fig/' saveName];
    pngSave = [savePath 'png/' saveName];
    
    save(dataSave, 'statsData');
    savefig(figSave);
    saveas(gcf,pngSave,'png');
    
    close; 
    clear s rawPlotData statsData
    
    figure; 
    s = stackedplot(correctedFreqs,correctedPlotData,'Title',titleName,'DisplayLabels',lableNames,'Color','r','LineWidth',1);
    
    s.AxesProperties(1).YLimits = [-3 6.2];
    s.AxesProperties(2).YLimits = [-3 6.2];
    s.AxesProperties(3).YLimits = [-3 6.2];
    s.AxesProperties(4).YLimits = [-3 6.2];
    
    figSave = [savePath 'fig/New' saveName '_4'];
    pngSave = [savePath 'png/New' saveName '_4'];
    
    savefig(figSave);
    saveas(gcf,pngSave,'png');
    
    close;
    clear s newPlotData
    
end
    
   
% Power plots


        
    
    
    
    
        
        



