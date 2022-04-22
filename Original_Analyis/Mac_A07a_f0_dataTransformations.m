%% Select f0 t/f data for plotting

% Selects and averages f0 data for later plotting (ITC & Power)


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
loadITCPath = '/Users/danielcomstock/Documents/Data/AV_TapNoTap/Data/07_Comp_TF_Data/f0ITC/';
loadPowerPath = '/Users/danielcomstock/Documents/Data/AV_TapNoTap/Data/07_Comp_TF_Data/f0tfPower/';
saveITCPath = '/Users/danielcomstock/Documents/Data/AV_TapNoTap/Data/07a_f0_tfStatsPlotData/ITC';
savePowerPath = '/Users/danielcomstock/Documents/Data/AV_TapNoTap/Data/07a_f0_tfStatsPlotData/Power';

% File directory
allFiles = dir([loadITCPath,'*.mat']);


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
        saveNameBase = conMod(1:end-4);
        loadITC = [loadITCPath fileName];
        load(loadITC);
        
        ITC_Data = eTF_dataW;
        clear eTF_dataW
        
        loadPower = [loadPowerPath fileName];
        load(loadPower);
        
        Pow_Data = eTF_dataW;
        clear eTF_dataW
        
        times = ITC_Data.times;
        freqs = ITC_Data.freqs;
        lmc = MotorClusters(subIDX).lm;
        rmc = MotorClusters(subIDX).rm;
        
        % counting variables
        cAmL = 1; 
        cAmLR = 1;

        
        for compIDX = 1:length(ITC_Data.Data)
            if compIDX == lmc
                leftMotorITC(:,:,subIDX) = ITC_Data.Data(compIDX).ITC;
                leftMotorPow(:,:,subIDX) = Pow_Data.Data(compIDX).tfPower;

                allAvgITC(:,:,compIDX)=ITC_Data.Data(compIDX).ITC;
                allAvgPow(:,:,compIDX)=Pow_Data.Data(compIDX).tfPower;
                
            elseif compIDX == rmc
                rightMotorITC(:,:,subIDX) = ITC_Data.Data(compIDX).ITC;
                rightMotorPow(:,:,subIDX) = Pow_Data.Data(compIDX).tfPower;
                
                avgMinLMotorITC(:,:,cAmL) = ITC_Data.Data(compIDX).ITC;
                avgMinLMotorPow(:,:,cAmL) = Pow_Data.Data(compIDX).tfPower;

                allAvgITC(:,:,compIDX)=ITC_Data.Data(compIDX).ITC;
                allAvgPow(:,:,compIDX)=Pow_Data.Data(compIDX).tfPower;
                
                cAmL = cAmL + 1;
            else
                avgMinLMotorITC(:,:,cAmL) = ITC_Data.Data(compIDX).ITC;
                avgMinLMotorPow(:,:,cAmL) = Pow_Data.Data(compIDX).tfPower;
                
                avgMinLR_MotorITC(:,:,cAmLR) = ITC_Data.Data(compIDX).ITC;
                avgMinLR_MotorPow(:,:,cAmLR) = Pow_Data.Data(compIDX).tfPower;
                
                allAvgITC(:,:,compIDX)=ITC_Data.Data(compIDX).ITC;
                allAvgPow(:,:,compIDX)=Pow_Data.Data(compIDX).tfPower;
                
                cAmL = cAmL + 1;
                cAmLR = cAmLR + 1;

            end
        end
        SubAvgMinLMotorITC(:,:,subIDX) = mean(avgMinLMotorITC,3);
        SubAvgMinLMotorPow(:,:,subIDX) = mean(avgMinLMotorPow,3);
                
        SubAvgMinLR_MotorITC(:,:,subIDX) = mean(avgMinLR_MotorITC,3);      
        SubAvgMinLR_MotorPow(:,:,subIDX) = mean(avgMinLR_MotorPow,3);    
        
        SubAllAvgITC(:,:,subIDX) = mean(allAvgITC,3);
        SubAllAvgPow(:,:,subIDX) = mean(allAvgPow,3);
        
        clear ITC_Data Pow_Data

    end
    
    % save data files
    
    ITClmsave = [saveITCPath '_LeftMotor_' conMod];
    ITCrmsave = [saveITCPath '_RightMotor_' conMod];
    ITClmsaveavgMinLsave = [saveITCPath '_AvgMinLeftMotor_' conMod];
    ITClmsaveavgMinLRsave = [saveITCPath '_AvgMinLRMotor_' conMod];
    ITClmsaveallAvgsave = [saveITCPath '_AvgAll_' conMod];
    
    Powlmsave = [savePowerPath '_LeftMotor_' conMod];
    Powrmsave = [savePowerPath '_RightMotor_' conMod];
    PowavgMinLsave = [savePowerPath '_AvgMinLeftMotor_' conMod];
    PowavgMinLRsave = [savePowerPath '_AvgMinLRMotor_' conMod];
    PowallAvgsave = [savePowerPath '_AvgAll_' conMod];
    
    save(ITClmsave, 'times', 'freqs', 'leftMotorITC');
    save(ITCrmsave, 'times', 'freqs', 'rightMotorITC');
    save(ITClmsaveavgMinLsave, 'times', 'freqs', 'SubAvgMinLMotorITC');
    save(ITClmsaveavgMinLRsave, 'times', 'freqs', 'SubAvgMinLR_MotorITC');
    save(ITClmsaveallAvgsave, 'times', 'freqs', 'SubAllAvgITC');
    
    save(Powlmsave, 'times', 'freqs', 'leftMotorPow');
    save(Powrmsave, 'times', 'freqs', 'rightMotorPow');
    save(PowavgMinLsave, 'times', 'freqs', 'SubAvgMinLMotorPow');
    save(PowavgMinLRsave, 'times', 'freqs', 'SubAvgMinLR_MotorPow');
    save(PowallAvgsave, 'times', 'freqs', 'SubAllAvgPow');
    
end




    
    
        
        

        
        
        
        
        
        
        
        
        

        
    
    
    





