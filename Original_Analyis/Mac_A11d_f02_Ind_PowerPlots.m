% transform and plot ITC and Power data

clear

% filePaths
loadPath = '/Users/danielcomstock/Documents/Data/AV_TapNoTap/Data/07b_f02_tfStatsPlotData/';
savePath = '/Users/danielcomstock/Documents/Data/AV_TapNoTap/Data/08c_Indf02Plots/';

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
        indPlotData(:,:,condIDX) = tempdata(85:116,:);
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
    musicianIDX =[1,2,3,9,10,13,17,18];
    nonMusicanIDX = [4,5,6,7,8,11,12,14,15,16];
    muscianPlotData = neighborCorrectedData(:,musicianIDX,:);
    nonMusicianPlotData = neighborCorrectedData(:,nonMusicanIDX,:);
    
    % save data for stats
    statsData.neighborCorrectedData = neighborCorrectedData;
    statsData.neighborCorrectedFreqs = correctedFreqs;
    statsData.muData = indPlotData;
    statsData.MuFreqs = rawPlotFreqs;
    
    correctedPlotData = mean(neighborCorrectedData,2);
    correctedPlotData = squeeze(correctedPlotData);
    
    % plot mu data
    figure; 
    subplot(4,1,1);
    hold on
    plot(rawPlotFreqs,indPlotData(:,:,1),'-k', 'LineWidth', 0.5)
    plot(rawPlotFreqs,rawPlotData(:,1),'-r', 'LineWidth', 3)
    hold off
    title(char(lableNames(1)), 'FontSize', 10, 'FontWeight','bold');
    xlim([9.5 12.5]);
    
    subplot(4,1,2);
    hold on
    plot(rawPlotFreqs,indPlotData(:,:,2),'-k', 'LineWidth', 0.5)
    plot(rawPlotFreqs,rawPlotData(:,2),'-r', 'LineWidth', 3)
    hold off
    title(char(lableNames(2)), 'FontSize', 10, 'FontWeight','bold');
    xlim([9.5 12.5]);
    
    subplot(4,1,3);
    hold on
    plot(rawPlotFreqs,indPlotData(:,:,3),'-k', 'LineWidth', 0.5)
    plot(rawPlotFreqs,rawPlotData(:,3),'-r', 'LineWidth', 3)
    hold off
    title(char(lableNames(3)), 'FontSize', 10, 'FontWeight','bold');
    xlim([9.5 12.5]);
    
    subplot(4,1,4);
    hold on
    plot(rawPlotFreqs,indPlotData(:,:,4),'-k', 'LineWidth', 0.5)
    plot(rawPlotFreqs,rawPlotData(:,4),'-r', 'LineWidth', 3)
    hold off
    title(char(lableNames(4)), 'FontSize', 10, 'FontWeight','bold');
    xlim([9.5 12.5]);
    
    dataSave = [savePath 'data/' saveName];
    figSave = [savePath 'fig/' saveName];
    pngSave = [savePath 'png/' saveName];
    
    save(dataSave, 'statsData');
    savefig(figSave);
    saveas(gcf,pngSave,'png');
    
    close; 
    clear s rawPlotData statsData indPlotData
    
    
    % plot f0 power
    
    figure; 
    subplot(4,1,1);
    hold on
    plot(correctedFreqs,neighborCorrectedData(:,:,1),'-k', 'LineWidth', 0.5)
    plot(correctedFreqs,correctedPlotData(:,1),'-r', 'LineWidth', 3)
    hold off
    title(char(lableNames(1)), 'FontSize', 10, 'FontWeight','bold');
    xlim([1.3 7]);
    
    subplot(4,1,2);
    hold on
    plot(correctedFreqs,neighborCorrectedData(:,:,2),'-k', 'LineWidth', 0.5)
    plot(correctedFreqs,correctedPlotData(:,2),'-r', 'LineWidth', 3)
    hold off
    title(char(lableNames(2)), 'FontSize', 10, 'FontWeight','bold');
    xlim([1.3 7]);
    
    subplot(4,1,3);
    hold on
    plot(correctedFreqs,neighborCorrectedData(:,:,3),'-k', 'LineWidth', 0.5)
    plot(correctedFreqs,correctedPlotData(:,3),'-r', 'LineWidth', 3)
    hold off
    title(char(lableNames(3)), 'FontSize', 10, 'FontWeight','bold');
    xlim([1.3 7]);
    
    subplot(4,1,4);
    hold on
    plot(correctedFreqs,neighborCorrectedData(:,:,4),'-k', 'LineWidth', 0.5)
    plot(correctedFreqs,correctedPlotData(:,4),'-r', 'LineWidth', 3)
    hold off
    title(char(lableNames(4)), 'FontSize', 10, 'FontWeight','bold');
    xlim([1.3 7]);
    
    figSave = [savePath 'fig/New' saveName '_4'];
    pngSave = [savePath 'png/New' saveName '_4'];
    
    savefig(figSave);
    saveas(gcf,pngSave,'png');
    
    close;
    clear s correctedPlotData neighborCorrectedData
    
end
    
   
% Power plots


        
    
    
    
    
        
        



