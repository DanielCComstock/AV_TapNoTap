%% Computing Channel t/f for AV_TapNoTap project %%
 
% t/f will be computed without a common baseline. 
% Output of each t/f will be saved into a mat file
% for latter processing and ploting using the imagesc and std_stat
% functions. 

    
%% Load study information

% first load study in EEGLAB to extract the study information. The study
% is cleared after study information is extracted

% Set memory option for only loading 1 dataset into memory at a time
pop_editoptions( 'option_storedisk', 1);

STUDY = []; CURRENTSTUDY = 0; ALLEEG = []; EEG=[]; CURRENTSET=[];
% load study
[STUDY ALLEEG] = pop_loadstudy('filename', 'AV_TapNoTap_6AMICA_Cluster.study', 'filepath', 'H:\Data\AV_TapNoTap\05c_Study');
CURRENTSTUDY = 1; EEG = ALLEEG; CURRENTSET = [1:length(EEG)];

% Save study info and clear stuyd
studyinfo = STUDY;
STUDY = []; CURRENTSTUDY = 0; ALLEEG = []; EEG=[]; CURRENTSET=[]; 


%% t/f functions (chan)

% Set memory option to allow for loading of multiple datasets into memory
pop_editoptions( 'option_storedisk', 0);

% For loop for each channel
%   i = channel
%   j = control or omit indicator
%   k = dataset and component indicator
for i = 1:32
    
    % for loop for number of conditions. In this case there are 4
    % conditions, but I am only using 2 at a time. 
    for j = 1:4
        
        if j==1
            condition = 'Aud_Tap';
        elseif j==2
            condition = 'Aud_NoTap';
        elseif j==3
            condition = 'Vis_Tap';
        else 
            condition = 'Vis_NoTap';
        end

        % for loop for the number of subjects
        for k = 1:18  
            
            % find indices of datsets needed for each t/f analysis.
            % sets key:
            %   sets(1,x) = aud tap
            %   sets(2,x) = aud no tap
            %   sets(3,x) = vis tap
            %   sets(4,x) = vis no tap 
            %   sTap & sNoTap = aud if j = 1 & = vis if j = 2
            datasetInd = studyinfo.setind(j,k);
            
        
            % load sTap & sNoTap datafiles
            EEG = pop_loadset('filename',studyinfo.datasetinfo(datasetInd).filename,...
                'filepath',studyinfo.datasetinfo(datasetInd).filepath);
            EEG = eeg_checkset( EEG );
            [ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG );
            
            % get channel number
            chanNum = studyinfo.changrp(i).allinds{1}(k);
            chanName = studyinfo.changrp(i).name;

            % perform t/f with common baseline from 3 to 35 Hz 
            % ALLEEG 1 = cont, ALLEEG 2 = omit
            [ersp,itc,powbase,times,freqs,erspboot,itcboot] = newtimef(ALLEEG(1).data(chanNum,:,:),...
            ALLEEG(1).pnts,[ALLEEG(1).xmin ALLEEG(1).xmax]*1000, ALLEEG(1).srate,... 
            'cycles', [3 0.6], 'nfreqs',90 , 'ntimesout', 500, 'baseline', [-2000 1996],'freqs', [6 50],...
            'freqscale', 'linear','plotphasesign','off', 'plotersp','off', 'plotitc','off');
        
            % Read out information from above parameters:
%                 Each trial contains samples from -2000 ms before to
%                 1996 ms after the timelocking event.
%                 Image frequency direction: normal
%                 Using 3 cycles at lowest frequency to 10 at highest.
%                 Generating 400 time points (-1720.4 to 1716.4 ms)
%                 Finding closest points for time variable
%                 Time values for time/freq decomposition is not perfectly uniformly distributed
%                 The window size used is 143 samples (558.594 ms) wide.
%                 Estimating 90 linear-spaced frequencies from 6.0 Hz to 50.0 Hz
 
            % Load data into TF_data
            TF_data(k).ersp = ersp;
            TF_data(k).itc = itc;
            TF_data(k).powbase = powbase; 
            TF_data(k).times = times;
            TF_data(k).freqs = freqs;
            TF_data(k).filename = studyinfo.datasetinfo(datasetInd).filename;
            TF_data(k).channel = chanName;           
           
            STUDY = []; CURRENTSTUDY = 0; ALLEEG = []; EEG=[]; CURRENTSET=[]; 
            
        end
   
        % Save output files for later plotting

        % create savepath and savename
        savepath = 'H:\Data\AV_TapNoTap\06a_TF_Chan\';
        
        savenameData = ['Chan_' chanName '_' condition];
        
        savenameStudy = 'AV_TapNoTap_Chan_Study';
        fullsaveData = [savepath savenameData];
        fullsaveStudy = [savepath savenameStudy];
        
        % Save data files
        save(fullsaveData, 'TF_data');
       
        
        % Clear dataC & data 
        clear TF_data;
        
    end
    
end

save(fullsaveStudy, 'studyinfo');

% Reset memory option for keeping only dataset loaded at a time
pop_editoptions( 'option_storedisk', 1);

%% Computing Cluster t/f for AV_TapNoTap project %%
 
% t/f will be computed without a common baseline. 
% Output of each t/f will be saved into a mat file
% for latter processing and ploting using the imagesc and std_stat
% functions.



    
    
%% Load study information

% first load study in EEGLAB to extract the study information. The study
% is cleared after study information is extracted

% Set memory option for only loading 1 dataset into memory at a time
pop_editoptions( 'option_storedisk', 1);

% load study
[STUDY ALLEEG] = pop_loadstudy('filename', 'AV_TapNoTap_6AMICA_Cluster.study', 'filepath', 'H:\Data\AV_TapNoTap\05c_Study');
CURRENTSTUDY = 1; EEG = ALLEEG; CURRENTSET = [1:length(EEG)];

% Save study info and clear stuyd
studyinfo = STUDY;
STUDY = []; CURRENTSTUDY = 0; ALLEEG = []; EEG=[]; CURRENTSET=[]; 


%% t/f functions (cluster)

% Set memory option to allow for loading of multiple datasets into memory
pop_editoptions( 'option_storedisk', 0);

% For loop for each channel
%   i = channel
%   j = control or omit indicator
%   k = dataset and component indicator
for i = 3:12
    
    % for loop for number of conditions. In this case there are 4
    % conditions, but I am only using 2 at a time. 
    for j = 1:4
        
        if j==1
            condition = 'Aud_Tap';
        elseif j==2
            condition = 'Aud_NoTap';
        elseif j==3
            condition = 'Vis_Tap';
        else 
            condition = 'Vis_NoTap';
        end

        % for loop that determines number of components in each cluster
        for k = 1:size(studyinfo.cluster(i).sets,2) 
            
            % find indices of datsets needed for each t/f analysis.
            % sets key:
            %   sets(1,x) = aud tap
            %   sets(2,x) = aud no tap
            %   sets(3,x) = vis tap
            %   sets(4,x) = vis no tap 
            %   sTap & sNoTap = aud if j = 1 & = vis if j = 2
            datasetInd = studyinfo.cluster(i).sets(j,k);
            
            
            % get component number.
            compNum = studyinfo.cluster(i).comps(k);
            
        
            % load datafile
            EEG = pop_loadset('filename',studyinfo.datasetinfo(datasetInd).filename,...
                'filepath',studyinfo.datasetinfo(datasetInd).filepath);
            EEG = eeg_checkset( EEG );
            [ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG );
            

            % perform t/f with common baseline from 3 to 35 Hz 
            % ALLEEG 1 = cont, ALLEEG 2 = omit
            [ersp,itc,powbase,times,freqs,erspboot,itcboot] = newtimef(ALLEEG(1).icaact(compNum,:,:),...
            ALLEEG(1).pnts,[ALLEEG(1).xmin ALLEEG(1).xmax]*1000, ALLEEG(1).srate,... 
            'cycles', [3 0.6], 'nfreqs',90 , 'ntimesout', 500, 'baseline', [-2000 1996],'freqs', [6 50],...
            'freqscale', 'linear','plotphasesign','off', 'plotersp','off', 'plotitc','off');
        
            % Read out information from above parameters:
%                 Each trial contains samples from -2000 ms before to
%                 1996 ms after the timelocking event.
%                 Image frequency direction: normal
%                 Using 3 cycles at lowest frequency to 10 at highest.
%                 Generating 400 time points (-1720.4 to 1716.4 ms)
%                 Finding closest points for time variable
%                 Time values for time/freq decomposition is not perfectly uniformly distributed
%                 The window size used is 143 samples (558.594 ms) wide.
%                 Estimating 90 linear-spaced frequencies from 6.0 Hz to 50.0 Hz
 
            % Load data into TF_data
            TF_data(k).ersp = ersp;
            TF_data(k).itc = itc;
            TF_data(k).powbase = powbase;  
            TF_data(k).times = times;
            TF_data(k).freqs = freqs;
            TF_data(k).filename = studyinfo.datasetinfo(datasetInd).filename;
            TF_data(k).component = num2str(compNum);         
           
            STUDY = []; CURRENTSTUDY = 0; ALLEEG = []; EEG=[]; CURRENTSET=[]; 
            
        end
   
        % Save output files for later plotting

        % create savepath and savename
        savepath = 'H:\Data\AV_TapNoTap\06b_TF_Clus\';
        
        savenameData = ['Clust_' num2str(i) '_' condition];

        
        savenameStudy = 'AV_TapNoTap_Chan_Study';
        fullsaveData = [savepath savenameData];

        fullsaveStudy = [savepath savenameStudy];
        
        % Save data files
        save(fullsaveData, 'TF_data');
 
       
        
        % Clear dataC & data 
        clear TF_data;
        
    end
    
end

save(fullsaveStudy, 'studyinfo');

% Reset memory option for keeping only dataset loaded at a time
pop_editoptions( 'option_storedisk', 1);
            
            