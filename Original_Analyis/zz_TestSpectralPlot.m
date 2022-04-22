
% get averaged spectral data of all channels for each subject individually. (This is
% equivalent to average of all components for each subject individually)
[STUDY, specdata, allfreqs] = std_specplot(STUDY,ALLEEG,'channels',{'FP1','FPZ','FP2','F7','F3','FZ','F4','F8','FC5','FC1','FC2','FC6','M1','T7','C3','CZ','C4','T8','M2','CP5','CP1','CP2','CP6','P7','P3','PZ','P4','P8','POZ','O1','OZ','O2'}, 'design', 1);

% get spectral data from all components
% [STUDY, specdata, allfreqs] = std_specplot(STUDY,ALLEEG,'clusters',1, 'design', 1 );

% get spectral data of all determined left motor components (1 per subject)
%[STUDY, specdata, allfreqs] = std_specplot(STUDY,ALLEEG,'clusters',11, 'design', 1 );

clear specData neighborCorrectedData tempdata f0PowData
specData(:,:,1) = cell2mat(specdata([1]));
specData(:,:,2) = cell2mat(specdata([2]));
specData(:,:,3) = cell2mat(specdata([3]));
specData(:,:,4) = cell2mat(specdata([4]));

correctedFreqs = allfreqs(1:206);
for condIDX = 1:4
    for subIDX = 1:size(specData,2)

        for freqIDX = 5:length(correctedFreqs)
            neighborIDX = [freqIDX-4 freqIDX-3 freqIDX+3 freqIDX+4];
            neighborAvg = mean(specData(neighborIDX,subIDX,condIDX));
            neighborCorrectedData(freqIDX,subIDX,condIDX) = specData(freqIDX,subIDX,condIDX) - neighborAvg;
        end
    end
end
f0PowData = neighborCorrectedData(16,:,:);
f0PowData = squeeze(f0PowData);
avgNeighborCorrectedData = mean(neighborCorrectedData,2);
avgNeighborCorrectedData = squeeze(avgNeighborCorrectedData);
figure; 
s = stackedplot(correctedFreqs,avgNeighborCorrectedData,'Color','r','LineWidth',1);


% Get Mu Power
% get averaged spectral data of all channels for each subject individually. (This is
% equivalent to average of all components for each subject individually)
 [STUDY, specdata, allfreqs] = std_specplot(STUDY,ALLEEG,'channels',{'FP1','FPZ','FP2','F7','F3','FZ','F4','F8','FC5','FC1','FC2','FC6','M1','T7','C3','CZ','C4','T8','M2','CP5','CP1','CP2','CP6','P7','P3','PZ','P4','P8','POZ','O1','OZ','O2'}, 'design', 1);

% get spectral data from all components
% [STUDY, specdata, allfreqs] = std_specplot(STUDY,ALLEEG,'clusters',1, 'design', 1 );

% get spectral data of all determined left motor components (1 per subject)
%[STUDY, specdata, allfreqs] = std_specplot(STUDY,ALLEEG,'clusters',11, 'design', 1 );

clear muData

muData(:,1) = mean(cell2mat(specdata([1])));
muData(:,2) = mean(cell2mat(specdata([2])));
muData(:,3) = mean(cell2mat(specdata([3])));
muData(:,4) = mean(cell2mat(specdata([4])));

correctedFreqs = allfreqs(1:206);
for condIDX = 1:4
    for subIDX = 1:size(specData,2)

        for freqIDX = 5:length(correctedFreqs)
            neighborIDX = [freqIDX-4 freqIDX-3 freqIDX+3 freqIDX+4];
            neighborAvg = mean(specData(neighborIDX,subIDX,condIDX));
            neighborCorrectedData(freqIDX,subIDX,condIDX) = specData(freqIDX,subIDX,condIDX) - neighborAvg;
        end
    end
end
f0PowData = neighborCorrectedData(16,:,:);
f0PowData = squeeze(f0PowData);
avgNeighborCorrectedData = mean(neighborCorrectedData,2);
avgNeighborCorrectedData = squeeze(avgNeighborCorrectedData);
figure; 
s = stackedplot(correctedFreqs,avgNeighborCorrectedData,'Color','r','LineWidth',1);