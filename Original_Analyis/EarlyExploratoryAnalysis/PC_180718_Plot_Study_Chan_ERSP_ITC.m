% Script to run stats on ERSP with <0.05 masking using FDR correction in a
% study. Note that study will have to be up and ERSP Precomputed first

figpath = 'H:\Data\AV_TapNoTap\06a_Figures_BINCA\';

chans = ['FPZ'; ' FZ'; ' CZ'; ' PZ'; 'POZ'; ' OZ'];
chan = cellstr(chans);

names = ['All_Cond'; 'Aud_Only'; 'Vis_Only'];
name = cellstr(names);

for i = 1:3
    % Select Study design  
    STUDY = std_selectdesign(STUDY, ALLEEG, i);
    % set name for figs and study design
    tempname = char(name(i));
    for m = 1:6
        
        %Set name for channel
        tempchan = char(chan(m));
        tempchan(tempchan == ' ') = [];
        
        %Plot ITC and save fig
        STUDY = std_itcplot(STUDY,ALLEEG,'channels',{tempchan});
        fullpath = [figpath 'AV_TapNoTap' tempname '_ITC_' tempchan];
        savefig(fullpath);
        close;
        
        % Save ERSP values. Note that specific channel will have to be specified.
        [STUDY ersp times freqs ] = std_erspplot(STUDY,ALLEEG,'channels', {tempchan});
        
        % Save Normal ERSP
        fullpath = [figpath 'AV_TapNoTap' tempname '_ERSP_' tempchan];
        savefig(fullpath);
        close;
        
%         % Run Perumtation statisticts w/FDR correction 
%         pvals = std_stat({ ersp{1} zeros(size(ersp{1})) }', 'method', 'permutation', 'condstats', 'on', 'mcorrect', 'fdr');
% 
%         % average ERSP for all subjects
%         tmpersp = mean(ersp{1},4); 
% 
%         % zero out non-significant values using 0.05
%         tmpersp(pvals{1} > 0.05) = 0; 
% 
%         %Plot ERSP with non-sig values masked
%         figure; imagesclogy(times, freqs, tmpersp); set(gca, 'ydir', 'normal'); xlabel('Time (ms)'); ylabel('Frequencies (Hz)'); cbar;
%         
%         % Save Stats ERSP
%         fullpath = [figpath 'AV_Omit_' tempname '_ERSP_P05_' tempchan];
%         savefig(fullpath);
%         close;
%         
%         % Zero out non-sig values at .01
%         tmpersp(pvals{1} > 0.01) = 0; 
%         
%         %Plot ERSP with non-sig values masked
%         figure; imagesclogy(times, freqs, tmpersp); set(gca, 'ydir', 'normal'); xlabel('Time (ms)'); ylabel('Frequencies (Hz)'); cbar;
%         
%         % Save Stats ERSP
%         fullpath = [figpath 'AV_Omit_' tempname '_ERSP_P01_' tempchan];
%         savefig(fullpath);
%         close;
    end


end


