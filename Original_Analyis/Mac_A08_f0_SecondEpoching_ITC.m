% epochs the fo data and calculates ITC for each component

%MuBeta file to load to get times (use repeatedly)
muLoad = '/Users/danielcomstock/Documents/Data/AV_TapNoTap/Data/07_Comp_TF_Data/MuBeta/AVTapNoTap1Aud_Con.mat';
load(muLoad)
epochTimes = TF_data.MuBetaTimes;


loadPath = '/Users/danielcomstock/Documents/Data/AV_TapNoTap/Data/07_Comp_TF_Data/f0/';
savePath = '/Users/danielcomstock/Documents/Data/AV_TapNoTap/Data/07_Comp_TF_Data/f0ITC/';

allFiles = dir([loadPath,'*.mat']);

for fileIDX = 1:length(allFiles)
    
    loadFile = allFiles(fileIDX).name;
    fullLoad = [loadPath loadFile];
    saveName = loadFile(1:end-4);
    fullSave = [savePath saveName];
    
    % load data
    load(fullLoad);
    


    etL = TF_dataW.WideTimes(end); % total length of 1 stimulus train
    esL = TF_dataW.WideTimes(2); % length of one sample step
    if length(TF_dataW.WideEvents) == 117    
        eventsToChange = [1:9 31:48 70:87 109:117];  % events to relable (outside of t/f computation time limits)
        fullTimes = [TF_dataW.WideTimes TF_dataW.WideTimes+(etL+esL) TF_dataW.WideTimes+((etL+esL)*2)]; % Times for unstacked stimtrain epochs
        full_f0_Times = [TF_dataW.f0Times TF_dataW.f0Times+(etL+esL) TF_dataW.f0Times+((etL+esL)*2)];
    else    
        eventsToChange = [1:9 31:48 70:87 109:126 148:156];
        fullTimes = [TF_dataW.WideTimes TF_dataW.WideTimes+(etL+esL) TF_dataW.WideTimes+((etL+esL)*2) TF_dataW.WideTimes+((etL+esL)*3)];
        full_f0_Times = [TF_dataW.f0Times TF_dataW.f0Times+(etL+esL) TF_dataW.f0Times+((etL+esL)*2) TF_dataW.f0Times+((etL+esL)*3)];
    end

    for eChangeIDX = 1:length(eventsToChange)
        TF_dataW.WideEvents(eventsToChange(eChangeIDX)).type = '99'; % relables out of bound events
    end


    for nCompsIDX = 1:length(TF_dataW.f0)

        % reshape tfdata to unstack stimtrain epoch
        tfdataTemp = TF_dataW.f0(nCompsIDX).tfdata;
        tfdataLin = reshape(tfdataTemp,size(tfdataTemp,1),size(tfdataTemp,2)*size(tfdataTemp,3));

        t = 1; % counter for events
        for eventIDX = 12:length(TF_dataW.WideEvents)

            % find events not out of bounds
            if ~strcmpi(TF_dataW.WideEvents(eventIDX).type,'99')

                % find sample point closest to event time
                [~,ind] = min(abs(full_f0_Times-(((TF_dataW.WideEvents(eventIDX).latency-1)/256)*1000)));
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

        eTF_dataW.Data(nCompsIDX).ITC = tf_ITC;
        clear data
    end
    eTF_dataW.freqs = TF_dataW.f0Freqs;
    eTF_dataW.times = epochTimes;
    
    % save output
    save(fullSave, 'eTF_dataW');
    
    clear eTF_dataW
    
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


    
