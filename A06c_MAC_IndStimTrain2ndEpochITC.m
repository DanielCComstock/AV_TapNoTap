% epochs the fo data and calculates ITC for each component

clear
clc


loadPath = '/Users/dcc/Data/AV_TapNoTap/Data/Revision1_Analysis/05f_TF_f0StimTrains/';
savePath = '/Users/dcc/Data/AV_TapNoTap/Data/Revision1_Analysis/06c_f0ITCStimTrains2ndEpoch/';

allFiles = dir([loadPath,'*.mat']);

epochTimes = -1218.75:(1/256*1000):1218.75; % times for the epoch window. Calculated based on epoched data and sample rate of 256

for fileIDX = 1:length(allFiles)
    
    loadFile = allFiles(fileIDX).name;
    fullLoad = [loadPath loadFile];
    saveName = loadFile(1:end-4);
    fullSave = [savePath saveName];
    
    % load data
    load(fullLoad);
    


    rawTotalLength = TF_data.EEG_Times(end); % total length of 1 stimulus train in ms
    stepLength = TF_data.EEG_Times(2); % length of one sample step in ms

    % relable events to exclude events that will be outside of the new
    % epochs
    if length(TF_data.Events) == 117 % accounts for subjects that had 3 stim trains    
        eventsToChange = [1:9 31:48 70:87 109:117];  % events to relable (outside of t/f computation time limits)
        fullTimes = [TF_data.EEG_Times TF_data.EEG_Times+(rawTotalLength+stepLength) TF_data.EEG_Times+((rawTotalLength+stepLength)*2)]; % Times for unstacked stimtrain epochs
        full_f0_Times = [TF_data.f0Times TF_data.f0Times+(rawTotalLength+stepLength) TF_data.f0Times+((rawTotalLength+stepLength)*2)];
    else    
        eventsToChange = [1:9 31:48 70:87 109:126 148:156]; % for when there are 4 stim trains
        fullTimes = [TF_data.EEG_Times TF_data.EEG_Times+(rawTotalLength+stepLength) TF_data.EEG_Times+((rawTotalLength+stepLength)*2) TF_data.EEG_Times+((rawTotalLength+stepLength)*3)];
        full_f0_Times = [TF_data.f0Times TF_data.f0Times+(rawTotalLength+stepLength) TF_data.f0Times+((rawTotalLength+stepLength)*2) TF_data.f0Times+((rawTotalLength+stepLength)*3)];
    end

    for eChangeIDX = 1:length(eventsToChange)
        TF_data.Events(eventsToChange(eChangeIDX)).type = '99'; % relables out of bound events
    end


    for nCompsIDX = 1:length(TF_data.f0)

        % reshape tfdata to unstack stimtrain epoch
        tfdataTemp = TF_data.f0(nCompsIDX).tfdata;
        tfdataLin = reshape(tfdataTemp,size(tfdataTemp,1),size(tfdataTemp,2)*size(tfdataTemp,3));

        t = 1; % counter for events
        for eventIDX = 12:length(TF_data.Events)

            % find events not out of bounds
            if ~strcmpi(TF_data.Events(eventIDX).type,'99')

                % find sample point closest to event time
                [~,ind] = min(abs(full_f0_Times-(((TF_data.Events(eventIDX).latency-1)/256)*1000)));
                eventSample(1) = ind;

                % convert indices from fullTimes to indices for f0Times

                % start and end of new epoch in samples from event (event at center)
                % events in epoch will be at -1200 -600 0 600 1200 ms
                eStart = eventSample - 312;
                eEnd = eventSample + 312;

                % epoch data centered on stims
                data(:,:,t) = tfdataLin(:,eStart:eEnd);
                t = t+1;
            end 
        end
        % add epoched data to data file
%         eTF_dataW.Data(nCompsIDX).tf_data = data; % removed to save time

        % compute ITC
        tf_ITC=[];

        for freqIDX=1:size(data,1)

            tfdataSquoze = data(freqIDX,:,:);
            tfdataSquoze = squeeze(tfdataSquoze);

            % compute ITPC
            tf_ITC(freqIDX,:) = abs(mean(exp(1i*angle(tfdataSquoze)),2));
        end

        eTF_data.tfdata(nCompsIDX).ITC = tf_ITC;
        clear data
    end

    eTF_data.freqs = TF_data.f0Freqs;
    eTF_data.times = epochTimes;
    eTF_data.mu = TF_data.MuComps;
    
    % save output
    save(fullSave, 'eTF_data');
    
    clear eTF_data TF_data fullTimes full_f0_Times tfdataLin tfdataTemp tfdataSquoze tf_ITC 
    
end
    
    

% %% test plot ITC
% 
% % plot results
% figure, clf
% contourf(eTF_dataW.times,eTF_dataW.freqs,eTF_dataW.Data(8).ITC,40,'linecolor','none')
% %set(gca,'clim',[0 .6],'ydir','normal','xlim',[-300 1000])
% title('ITPC')
% xlabel('Time (ms)'), ylabel('Frequency (Hz)')
% 
% %% avg ITC across components and plot
% 
% % concatenate itc
% for nCompsIDX = 1:length(TF_dataW.f0)
%     ITC(:,:,nCompsIDX)=eTF_dataW.Data(nCompsIDX).ITC;
% end
% 
% % average ERSP accross components/subjects
% avgITC = mean(ITC,3); 
% 
% 
% % plot results
% figure, clf
% contourf(eTF_dataW.times,eTF_dataW.freqs,avgITC,40,'linecolor','none')
% %set(gca,'clim',[0 .6],'ydir','normal','xlim',[-300 1000])
% title('ITPC')
% xlabel('Time (ms)'), ylabel('Frequency (Hz)')


    
