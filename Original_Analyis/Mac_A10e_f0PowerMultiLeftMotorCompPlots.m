%% plot beta power and f0 ITC for selected motor components

clear

%% Create Component Matrix for plotting

MotorClusters(1).sub = 'AVTapNoTap1';
MotorClusters(2).sub = 'AVTapNoTap2';
MotorClusters(3).sub = 'AVTapNoTap4';
MotorClusters(4).sub = 'AVTapNoTap5';
MotorClusters(5).sub = 'AVTapNoTap6';
MotorClusters(6).sub = 'AVTapNoTap7';
MotorClusters(7).sub = 'AVTapNoTap8';
MotorClusters(8).sub = 'AVTapNoTap9';
MotorClusters(9).sub = 'AVTapNoTap10';
MotorClusters(10).sub = 'AVTapNoTap11';
MotorClusters(11).sub = 'AVTapNoTap12';
MotorClusters(12).sub = 'AVTapNoTap13';
MotorClusters(13).sub = 'AVTapNoTap14';
MotorClusters(14).sub = 'AVTapNoTap17';
MotorClusters(15).sub = 'AVTapNoTap18';
MotorClusters(16).sub = 'AVTapNoTap19';
MotorClusters(17).sub = 'AVTapNoTap20';
MotorClusters(18).sub = 'AVTapNoTap21';

MotorClusters(1).lm = 15;
MotorClusters(2).lm = 13;
MotorClusters(3).lm = 9;
MotorClusters(4).lm = 6;
MotorClusters(5).lm = 10;
MotorClusters(6).lm = 8;
MotorClusters(7).lm = 6;
MotorClusters(8).lm = 14;
MotorClusters(9).lm = 11;
MotorClusters(10).lm = 5;
MotorClusters(11).lm = 20;
MotorClusters(12).lm = 16;
MotorClusters(13).lm = 5;
MotorClusters(14).lm = 5;
MotorClusters(15).lm = 7;
MotorClusters(16).lm = 14;
MotorClusters(17).lm = 3;
MotorClusters(18).lm = 15;

MotorClusters(1).rm = 8;
MotorClusters(2).rm = 7;
MotorClusters(3).rm = 12;
MotorClusters(4).rm = 14;
MotorClusters(5).rm = 8;
MotorClusters(6).rm = 13;
MotorClusters(7).rm = 3;
MotorClusters(8).rm = 8;
MotorClusters(9).rm = 7;
MotorClusters(10).rm = 10;
MotorClusters(11).rm = 15;
MotorClusters(12).rm = 18;
MotorClusters(13).rm = 4;
MotorClusters(14).rm = 17;
MotorClusters(15).rm = 9;
MotorClusters(16).rm = 4;
MotorClusters(17).rm = 7;
MotorClusters(18).rm = 2;

%% Data loading

% file paths
loadF0ITCPath = '/Users/danielcomstock/Documents/Data/AV_TapNoTap/Data/07_Comp_TF_Data/f0tfPower/';
loadMuBetaPath = '/Users/danielcomstock/Documents/Data/AV_TapNoTap/Data/07_Comp_TF_Data/MuBeta/';
saveMotorAvgPath = '/Users/danielcomstock/Documents/Data/AV_TapNoTap/Data/08_Comp_TF_Plots/MotorCompAvg/f0Power/';
saveMotorIndPath = '/Users/danielcomstock/Documents/Data/AV_TapNoTap/Data/08_Comp_TF_Plots/MotorCompInd/f0Power/LeftMotor/';

% File directory
allFiles = dir([loadF0ITCPath,'*.mat']);


%% f0 Power plotting

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
    
    for subIDX = 1:length(MotorClusters)
        
        % load power data
        fileName = [MotorClusters(subIDX).sub conMod];
        saveName = fileName(1:end-4);
        fullLoad = [loadF0ITCPath fileName];
        
        load(fullLoad);
        
        Motorf0Power_Avg.data(subIDX).f0Power = eTF_dataW.Data(MotorClusters(subIDX).lm(1)).tfPower;
        Motorf0Power_Avg.times = eTF_dataW.times;
        Motorf0Power_Avg.freqs = eTF_dataW.freqs;
        
        for compIDX = 1:length(MotorClusters(subIDX).lm)
        
            lmc = MotorClusters(subIDX).lm(compIDX);
        
            f0Power = eTF_dataW.Data(lmc).tfPower;
            times = eTF_dataW.times;
            freqs = eTF_dataW.freqs;

            % Compute absolute highest itc values in the Average itc for symetrical scalling
            f0Powermax = [max(max(f0Power))];
            f0Powermin = [min(min(f0Power))];
            % convert absolute highest itc values for symetrical scale
            f0PowerMinMax = [f0Powermin f0Powermax]; 

            %% Plot f0Power Ind
            
            tempname = [saveName '_Power_Comp_' num2str(lmc)];
            titleName = strrep(tempname, '_', ' ');

            figure; 
            imagesc(times, freqs, f0Power, f0PowerMinMax); 
            % sets scaling direction
            set(gca, 'ydir', 'normal'); 
            % set font
            set(gca, 'FontSize', 12, 'FontWeight', 'bold');
            % set plotbackground to white
            set(gcf,'color','w');
            % set x & y coord limits
            xlim([-1210 1210]);
            xticks([-1200 -600 0 600 1200])
            xticklabels({'-1200', '-600', '0', '600', '1200'})
            %ylim([8 50]);    
            % x axis label
            xlabel('Time (ms)', 'FontSize',14, 'FontWeight', 'bold'); 
            % y axis label
            ylabel('Frequencies (Hz)', 'FontSize',14, 'FontWeight', 'bold'); 
            % Set title and font
            title(titleName, 'FontSize', 14, 'FontWeight','bold');
            % adds colorbar to side showing color scale. Scale determined by
            % ITCMinMax
            c=colorbar;
            c.Label.String = 'power';
            c.Label.Position = [.5 f0Powermax*1.05];
            c.Label.Rotation = 0;
            colormap jet;

            % save as .fig file
            foPowerfigfullsave = [saveMotorIndPath '/fig/' saveName];
            savefig(foPowerfigfullsave);        
            % save as .png file
            foPowerfigfullsave = [saveMotorIndPath '/png/'  saveName];
            saveas(gcf,foPowerfigfullsave,'png');        
            % close figure
            close;

            clear f0Power f0PowerMinMax f0PowerMin f0PowerMax 

        end
    end
    
    %% Plot Avg Motor Power
    
    % concatenate left motor ITC
    for subIDX = 1:length(MotorClusters)
        f0Power(:,:,subIDX)=Motorf0Power_Avg.data(subIDX).f0Power;
    end
    
    % Compute absolute highest power values in the Average power for symetrical scalling
    avgf0Power = mean(f0Power,3); 
    f0Powermax = [max(max(avgf0Power))];
    f0Powermin = [min(min(avgf0Power))];
    % convert absolute highest itc values for symetrical scale
    f0PowerMinMax = [f0Powermin f0Powermax]; 

    %% Plot ITC Ind
    
    saveName = [conMod(1:end-4) '_Left_Motor_f0Power'];
    titleName = strrep(saveName, '_', ' ');


    figure; 
    imagesc(times, freqs, avgf0Power, f0PowerMinMax); 
    % sets scaling direction
    set(gca, 'ydir', 'normal'); 
    % set font
    set(gca, 'FontSize', 12, 'FontWeight', 'bold');
    % set plotbackground to white
    set(gcf,'color','w');
    % set x & y coord limits
    xlim([-1210 1210]);
    xticks([-1200 -600 0 600 1200])
    xticklabels({'-1200', '-600', '0', '600', '1200'})
    %ylim([8 50]);    
    % x axis label
    xlabel('Time (ms)', 'FontSize',14, 'FontWeight', 'bold'); 
    % y axis label
    ylabel('Frequencies (Hz)', 'FontSize',14, 'FontWeight', 'bold'); 
    % Set title and font
    title(titleName, 'FontSize', 14, 'FontWeight','bold');
    % adds colorbar to side showing color scale. Scale determined by
    c=colorbar;
    c.Label.String = 'power';
    c.Label.Position = [.5 f0Powermax*1.05];
    c.Label.Rotation = 0;
    colormap jet;

    % save as .fig file
    foPowerfigfullsave = [saveMotorAvgPath '/fig/' saveName];
    savefig(foPowerfigfullsave);        
    % save as .png file
    foPowerfigfullsave = [saveMotorAvgPath '/png/'  saveName];
    saveas(gcf,foPowerfigfullsave,'png');        
    % close figure
    close;
    
    % save data
    
    fullDataSave = [saveMotorAvgPath saveName];
    save(fullDataSave, 'Motorf0Power_Avg');

    clear avgf0Power f0PowerMinMax f0PowerMin f0PowerMax MotorITC_Avg 
end
    
    
    
    
        
        

        
        
        
        
        
        
        
        
        

        
    
    
    





