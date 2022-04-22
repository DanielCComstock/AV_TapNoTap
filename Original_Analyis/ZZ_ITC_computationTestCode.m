% Test code for calculating and plotting ITC values manually from t/f
% computed data

figure; [ersp,itc,powbase,times,freqs,erspboot,itcboot,tfdata]=...
pop_newtimef( EEG, 1, 31, [-1672  1672], [3 0.8] , 'topovec', 31, 'elocs',...
EEG.chanlocs, 'chaninfo', EEG.chaninfo, 'caption', 'OZ', 'baseline',...
[-1672 1672], 'freqs', [10 30], 'plotersp', 'off', 'plotphase', 'off', 'ntimesout', 400, 'padratio', 4);



tf_ITC=[];

for fi=1:length(freqs)
    tfdataSquoze = tfdata(fi,:,:);
    tfdataSquoze = squeeze(tfdataSquoze);
    
    % compute ITPC
    tf_ITC(fi,:) = abs(mean(exp(1i*angle(tfdataSquoze)),2));
end


% plot results
figure(15), clf
contourf(times,freqs,tf_ITC,40,'linecolor','none')
%set(gca,'clim',[0 .6],'ydir','normal','xlim',[-300 1000])
title('ITPC')
xlabel('Time (ms)'), ylabel('Frequency (Hz)')