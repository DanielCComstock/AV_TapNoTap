%% Perform ERSP Statistics for AV_TapNoTap

% Loads in all matsave files in TF_Data format and converts to useable
% format and performs permutaion statistics. 
 


%% 


clear
eeglab

for i =1:2
    
    loadpathstart = 'H:\Data\AV_TapNoTap\';
    if i==1
        loadkey = '06a_TF_Chan\';
    else
        loadkey = '06b_TF_Clus\';
    end
    
    loadpath = [loadpathstart loadkey];
    savepath = [loadpathstart '07_Figures\ERSP_Stats_Data\'];

    allFiles = dir([loadpath,'*.mat']);
    for j = 1:length(allFiles)
        %% Load ERSP Data
        
        
        loadFile = allFiles(j).name;
        savename = loadFile(1:end-4);
        fullsave = [savepath savename];
        

        % Load data
        loadname = [loadpath loadFile];
        load(loadname);
        
        if exist('TF_dataTheta') == 1
            TF_data = TF_dataTheta;
        end
        
        %% Format data for stats use

        % get number of TF sets
        nsets = size(TF_data,2);

        % get freqs & times
        freqs = TF_data(1).freqs;
        times = TF_data(1).times; 

        % concatenate ersp
        for k = 1:nsets
            ersp(:,:,k)=TF_data(k).ersp;
            itc(:,:,k)=TF_data(k).itc;
        end


        % average ERSP accross components/subjects
        avgersp = mean(ersp,3); 

        % Compute absolute highest ERSP values in the Average ERSP for symetrical scalling
        erspmax = [max(max(abs(avgersp)))];

        % convert absolute highest ERSP values for symetrical scale
        erspminmax = [-erspmax erspmax]; 
        
                %% Permutation Stats with FDR correction %%

        % permutation statistics with FDR correction
        pvals = std_stat({ ersp zeros(size(ersp)) }', 'method', 'permutation', 'condstats', 'on', 'correctm', 'fdr'); 

        % save values for stat contouring
        tmpersp05 = avgersp;
        tmpersp01 = avgersp;

        % Mask any ERSP values with less than p.05 sig
        tmpersp05(pvals{1} > 0.05) = 1;

        % Mask any ERSP values with less than p.01 sig
        tmpersp01(pvals{1} > 0.01) = 1;

        % Make all significant values = 2, for only single contour line
        tmpersp05(tmpersp05 ~= 1) = 2; 
        tmpersp01(tmpersp01 ~= 1) = 2; 
        
        
        %% Save & clear variables
        save(fullsave, 'freqs','times','ersp','itc','avgersp','erspmax','erspminmax',...
             'pvals','tmpersp05','tmpersp01');
        
        clear nsets freqs times ersp itc avgersp erspmax erspminmax pvals tmpersp05 tmpersp01 TF_data;
        
    end
end
