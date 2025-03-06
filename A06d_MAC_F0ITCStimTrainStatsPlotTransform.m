%% Select f0 t/f data for plotting

% Transforms f0 data for Stats and plotting for left motor only ITC, right
% motor only ITC, and average across components ITC. Puts ITC data in
% single files containing data from all subjects.


clear


%% Data loading

% file paths
loadITCPath = '/Users/dcc/Data/AV_TapNoTap/Data/Revision1_Analysis/06c_f0ITCStimTrains2ndEpoch/';

saveITCPath = '/Users/dcc/Data/AV_TapNoTap/Data/Revision1_Analysis/06d_f0ITCStimTrainStatsPlotTransformed/ITC';

% File directory
VisConFiles = dir([loadITCPath,'*Vis_Con.mat']);
VisTapFiles = dir([loadITCPath,'*Vis_Tap.mat']);
AudConFiles = dir([loadITCPath,'*Aud_Con.mat']);
AudTapFiles = dir([loadITCPath,'*Aud_Tap.mat']);
%% f0 ITC Transform

for conditionIDX = 1:4
    if conditionIDX == 1
        fileDirectory = VisConFiles; 
        conMod  = 'Vis_Con.mat'; 
    elseif conditionIDX == 2
        fileDirectory = VisTapFiles;
        conMod  = 'Vis_Tap.mat';
    elseif conditionIDX == 3
        fileDirectory = AudConFiles; 
        conMod  = 'Aud_Con.mat';
    elseif conditionIDX == 4
        fileDirectory = AudTapFiles; 
        conMod  = 'Aud_Tap.mat';
    end
    
    for subIDX = 1:length(fileDirectory)
        
        % load ITC data
        fileName = fileDirectory(subIDX).name;
        saveNameBase = fileName(1:end-4);
        loadITC = [loadITCPath fileName];
        load(loadITC);
        
        subNum = char(regexp(fileName, '\d*','match'));
        if length(subNum) == 1
            subNum = ['0' subNum];
        end
        subIDKey(subIDX) = str2double(subNum);
        times = eTF_data.times;
        freqs = eTF_data.freqs;
        lmc = eTF_data.mu.left;
        rmc = eTF_data.mu.right;
       


        
        for compIDX = 1:length(eTF_data.tfdata)
            if compIDX == lmc
                leftMotorITC(:,:,subIDX) = eTF_data.tfdata(compIDX).ITC;

                allAvgITC(:,:,compIDX)=eTF_data.tfdata(compIDX).ITC;
                
            elseif compIDX == rmc
                rightMotorITC(:,:,subIDX) = eTF_data.tfdata(compIDX).ITC;

                allAvgITC(:,:,compIDX)=eTF_data.tfdata(compIDX).ITC;

            else
                allAvgITC(:,:,compIDX)=eTF_data.tfdata(compIDX).ITC;

            end
            
            
        end  
        
        SubAllAvgITC(:,:,subIDX) = mean(allAvgITC,3);
        
        clear eTF_data

    end
    
    % save data files
    
    ITClmsave = [saveITCPath '_LeftMotor_' conMod];
    ITCrmsave = [saveITCPath '_RightMotor_' conMod];
    ITClmsaveallAvgsave = [saveITCPath '_AvgAll_' conMod];
    
    
    save(ITClmsave, 'subIDKey', 'times', 'freqs', 'leftMotorITC');
    save(ITCrmsave, 'subIDKey', 'times', 'freqs', 'rightMotorITC');
    save(ITClmsaveallAvgsave, 'subIDKey', 'times', 'freqs', 'SubAllAvgITC');

    
end




    
    
        
        

        
        
        
        
        
        
        
        
        

        
    
    
    





