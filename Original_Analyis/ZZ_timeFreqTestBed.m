figure;
[ersp,itc,powbase,times,freqs,erspboot,itcboot,tfdata] = newtimef(EEG.data(2,:,:),...
    EEG.pnts,[EEG.xmin EEG.xmax]*1000, EEG.srate,'cycles', [7 0],... 
    'ntimesout',3964,'baseline',[0 22797], 'freqs', [1.066 1.166 1.266 1.366 1.466 1.566 1.666 1.766 1.866 1.966],...
    'freqscale', 'linear','plotphasesign','off', 'plotersp','on', 'plotitc','off');


figure;
[ersp,itc,powbase,times,freqs,erspboot,itcboot,tfdata] = newtimef(EEG.data(2,:,:),...
    EEG.pnts,[EEG.xmin EEG.xmax]*1000, EEG.srate,'cycles', [4 0],... 
    'ntimesout',625,'baseline',[-1500 1496], 'freqs', [8 35],'padratio',2,'scale','log',...
    'freqscale', 'linear','plotphasesign','off', 'plotersp','on', 'plotitc','off');

figure(2);
imagesc(times, freqs, absERSP);
set(gca, 'ydir', 'normal');
colormap jet;
c=colorbar;

figure(3);
imagesc(times, freqs, logERSP);
set(gca, 'ydir', 'normal');
colormap jet;
c=colorbar;


figure(4);
imagesc(times, freqs, 10*log10(mean(abs(absTFData).^2,3)));
set(gca, 'ydir', 'normal');
colormap jet;
c=colorbar;

figure(5);
imagesc(times, freqs, 10*log10(mean(abs(logTFData).^2,3)));
set(gca, 'ydir', 'normal');
colormap jet;
c=colorbar;

figure(8);
imagesc(times, freqs, (mean(abs(absTFData).^2,3)));
set(gca, 'ydir', 'normal');
colormap jet;
c=colorbar;

figure(11);
imagesc(times, freqs, (mean(abs(logTFData).^2,3)));
set(gca, 'ydir', 'normal');
colormap jet;
c=colorbar;