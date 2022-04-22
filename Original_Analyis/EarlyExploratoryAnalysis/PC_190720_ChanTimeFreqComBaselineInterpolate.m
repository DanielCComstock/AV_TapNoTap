%% Computing Channel t/f for AV_TapNoTap project %%
 
% t/f will be computed with a common baseline between 2 conditions. 
% Output of each t/f will be saved into a mat file
% for latter processing and ploting using the imagesc and std_stat
% functions. Missing Channels are first interpolated as part of this script


%% Interpolate missing channels %%

% % Set memory option to allow for loading of multiple datasets into memory
% pop_editoptions( 'option_storedisk', 0);
% STUDY = []; CURRENTSTUDY = 0; ALLEEG = []; EEG=[]; CURRENTSET=[];
% loadpath = 'H:\Data\AV_TapNoTap\04c_Epoch6ModelAmica\';
% BaseFile = 'AV_TapNoTap_6_Epoch_1.set';
% allFiles = dir([loadpath,'*.set']);
% 
% EEG = pop_loadset('filename',BaseFile,'filepath',loadpath);
% [ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );
% 
% 
%  for j = 1:length(allFiles)
%     
%     loadFile = allFiles(j).name;
% 
%     savename = loadFile(1:end-4);
%     EEG = pop_loadset('filename',loadFile,'filepath',loadpath);
%     EEG = eeg_checkset( EEG );
%     [ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );
%     if EEG.nbchan ~= 32
%         EEG = pop_interp(EEG, ALLEEG(1).chanlocs, 'spherical');
%         EEG = pop_saveset( EEG, 'filename',savename,'filepath',loadpath);
%     end
%     ALLEEG = pop_delset( ALLEEG, [2] );
%     
%  end
STUDY = []; CURRENTSTUDY = 0; ALLEEG = []; EEG=[]; CURRENTSET=[]; 
    
    
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
    for j = 1:2:3

        % for loop for the number of subjects
        for k = 1:18  
            
            % find indices of datsets needed for each t/f analysis.
            % sets key:
            %   sets(1,x) = aud tap
            %   sets(2,x) = aud no tap
            %   sets(3,x) = vis tap
            %   sets(4,x) = vis no tap 
            %   sTap & sNoTap = aud if j = 1 & = vis if j = 2
            sTap = studyinfo.setind(j,k);
            sNoTap = studyinfo.setind(j+1,k);
        
            % load sTap & sNoTap datafiles
            EEG = pop_loadset('filename',studyinfo.datasetinfo(sTap).filename,...
                'filepath',studyinfo.datasetinfo(sTap).filepath);
            EEG = eeg_checkset( EEG );
            [ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG );

            EEG = pop_loadset('filename',studyinfo.datasetinfo(sNoTap).filename,...
                'filepath',studyinfo.datasetinfo(sNoTap).filepath);
            EEG = eeg_checkset( EEG );
            [ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG );
            
            % get channel number. will always be the same for both
            chanNum = studyinfo.changrp(i).allinds{1}(k);
            chanName = studyinfo.changrp(i).name;

            % perform t/f with common baseline from 3 to 35 Hz 
            % ALLEEG 1 = cont, ALLEEG 2 = omit
            [ersp,itc,powbase,times,freqs,erspboot,itcboot] = newtimef({ALLEEG(1).data(chanNum,:,:)...
            ALLEEG(2).data(chanNum,:,:)},ALLEEG(1).pnts,[ALLEEG(1).xmin ALLEEG(1).xmax]*1000, ALLEEG(1).srate,... 
            'cycles', [3 0.7], 'nfreqs',75 , 'ntimesout', 500, 'baseline', [-2000 1996],'freqs', [6 35],...
            'freqscale', 'linear','plotphasesign','off', 'plotersp','off', 'plotitc','off','commonbase','on');
        
            % Read out information from above parameters:
                % Each trial contains samples from -2000 ms before to
                % 1996 ms after the timelocking event.
                % Image frequency direction: normal
                % Using 3 cycles at lowest frequency to 5.25 at highest.
                % Generating 500 time points (-1720.7 to 1716.8 ms)
                % Finding closest points for time variable
                % Time values for time/freq decomposition is not perfectly uniformly distributed
                % The window size used is 143 samples (558.594 ms) wide.
                % Estimating 75 linear-spaced frequencies from 6 Hz to 35.0 Hz.
 
            % Load data into dataC for control and dataO for omit
            dataTap(k).ersp = cell2mat(ersp(1));
            dataTap(k).itc = cell2mat(itc(1));
            dataTap(k).powbase = cell2mat(powbase(1)); 
            dataTap(k).times = times;
            dataTap(k).freqs = freqs;
            dataTap(k).filename = studyinfo.datasetinfo(sTap).filename;
            dataTap(k).channel = chanName;
            
            dataNoTap(k).ersp = cell2mat(ersp(2));
            dataNoTap(k).itc = cell2mat(itc(2));
            dataNoTap(k).powbase = cell2mat(powbase(2));
            dataNoTap(k).times = times;
            dataNoTap(k).freqs = freqs;
            dataNoTap(k).filename = studyinfo.datasetinfo(sNoTap).filename;
            dataNoTap(k).channel = chanName;

            
           
            STUDY = []; CURRENTSTUDY = 0; ALLEEG = []; EEG=[]; CURRENTSET=[]; 
            
        end
   
        % Save output files for later plotting

        % select vis or aud conditon
        if j == 1
            modality = 'Aud';
        else 
            modality = 'Vis';
        end;

        % create savepath and savename
        savepath = 'H:\Data\AV_TapNoTap\06a_TF_Chan\';
        
        savenameTap = ['Chan_' chanName '_' modality '_Tap'];
        savenameNoTap = ['Chan_' chanName '_' modality '_NoTap'];
        
        savenameStudy = 'AV_TapNoTap_Chan_Study';
        fullsaveTap = [savepath savenameTap];
        fullsaveNoTap = [savepath savenameNoTap];
        fullsaveStudy = [savepath savenameStudy];
        
        % Save data files
        save(fullsaveTap, 'dataTap');
        save(fullsaveNoTap, 'dataNoTap');
       
        
        % Clear dataC & data 
        clear dataTap dataNoTap;
        
    end
    
end

save(fullsaveStudy, 'studyinfo');

% Reset memory option for keeping only dataset loaded at a time
pop_editoptions( 'option_storedisk', 1);
            