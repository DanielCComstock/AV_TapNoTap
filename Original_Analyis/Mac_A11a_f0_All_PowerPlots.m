% transform and plot ITC and Power data

clear

% filePaths
loadPath = '/Users/danielcomstock/Documents/Data/AV_TapNoTap/Data/07a_f0_tfStatsPlotData/';
savePath = '/Users/danielcomstock/Documents/Data/AV_TapNoTap/Data/08a_Avgf0Plots/';

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
        tempdata = mean(tfData,3);
        plotdata(:,condIDX) = mean(tempdata,2);
        tempdata2 = mean(tempdata,2);
        newFreqs = freqs(5:end-4);
        for IDX = 5 : length(tempdata2) - 8
            subIDX = [IDX-4  IDX+4];
            subVal = mean(tempdata2(subIDX));
            newPlotData(IDX,condIDX) = tempdata2(IDX) - subVal;
        end
            
        
        % save data for stats
        statsData.data(condIDX).tfData = tfData;
        statsData.freqs = freqs;
        statsData.times = times;
        
        clear tfData tempdata
    end
    
    figure; 
    s = stackedplot(freqs,plotdata,'Title',titleName,'DisplayLabels',lableNames,'Color','r','LineWidth',1);

    dataSave = [savePath 'data/' saveName];
    figSave = [savePath 'fig/' saveName];
    pngSave = [savePath 'png/' saveName];
    
    save(dataSave, 'statsData');
    savefig(figSave);
    saveas(gcf,pngSave,'png');
    
    close; 
    clear s plotdata statsData
    
    figure; 
    s = stackedplot(newFreqs,newPlotData,'Title',titleName,'DisplayLabels',lableNames,'Color','r','LineWidth',1);
    
    figSave = [savePath 'fig/New' saveName '_4'];
    pngSave = [savePath 'png/New' saveName '_4'];
    
    savefig(figSave);
    saveas(gcf,pngSave,'png');
    
    close;
    clear s newPlotData
    
end
    
   
% Power plots


        
    
    
    
    
        
        



